local telescope = require('telescope')
local inspect   = require('inspect')
local Path      = require('plenary.path')
local utils     = require('telescope.utils')

local action_state = require('telescope.actions.state')

telescope.setup {
  pickers = {
    find_files = {
      mappings = {
        i = {
          ["<Tab>"] = function(prompt_bufnr)
            local selected = action_state.get_selected_entry().filename

            local line = action_state.get_current_line()

            local end_chr = 1
            while line:len() >= end_chr and line:sub(end_chr, 1) == selected:sub(end_chr, 1) do
              end_chr = end_chr + 1
            end

            local next_end = selected:find('/', end_chr) or selected:find('\\', end_chr) or selected:len()
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:set_prompt(selected:sub(1, next_end))
          end,
          ["<C-y>"] = function(prompt_bufnr)
            local prompt = action_state.get_current_line();

            if prompt == "" then
              utils.notify('c-y', {
                msg = 'Could not do anything with blank line...',
                level = 'WARN',
              })
              return
            end
            local file = Path:new(prompt)
            if not file:exists() then
              file:touch { parents = true }
            end

            require("telescope.actions").close(prompt_bufnr)
            pcall(vim.cmd, string.format("edit %s", file.filename))
          end
        }
      }
    }
  }
}
telescope.load_extension('projects')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fp', telescope.extensions.projects.projects, {})
vim.keymap.set('n', '<leader>orc', function()
  builtin.find_files {
    cwd = vim.fn.stdpath("config")
  }
end, {})
