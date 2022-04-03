vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>',
  { noremap = true, silent = true })

local fb_utils = require "telescope._extensions.file_browser.utils"
local Path = require "plenary.path"
local state = require "telescope.actions.state"

local create_and_open = function(prompt_bufnr)
  local file = state.get_current_line()
  if not file then
    return
  end
  if file == "" then
    print "Please enter valid filename!"
    return
  end
  file = Path:new(file)
  if fb_utils.is_dir(file.filename) then
    print "Please enter a valid file name!"
    return
  end
  if not file:exists() then
    file:touch { parents = true }
  end

  require("telescope.actions").close(prompt_bufnr)
  pcall(vim.cmd, string.format("edit %s", file.filename))
end

require('telescope').setup{
  pickers = {
    find_files = {
      mappings = {
        ["i"] = {
          ["<C-y>"] = create_and_open,
        }
      }
    }
  },
  defaults = {
    file_ignore_patterns = {
      "%.git",
      "node_modules",
      "vendor",
      "plugged",
    }
  }
}
