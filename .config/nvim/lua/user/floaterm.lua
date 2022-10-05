local padding_x = 20;
local padding_y = 10;

local border_chars = { '╭', '╮', '╰', '╯', '─', '│', }

local border_buf = nil
local border_win = nil

local term_win = nil
local open_terms = {}
local current_term = 0

local function draw_border()
  local width = vim.go.columns - padding_x * 2
  local height = vim.go.lines - padding_y * 2
  local border_title = 'Terminal (' .. tostring(current_term) .. '/' .. tostring(#open_terms) .. ')'

  local lines = {}
  for y = 1, height, 1 do
    local line
    if y == 1 then
      line = border_chars[1] ..
          border_title .. string.rep(border_chars[5], width - string.len(border_title) - 2) .. border_chars[2]
    elseif y == height then
      line = border_chars[3] .. string.rep(border_chars[5], width - 2) .. border_chars[4]
    else
      line = border_chars[6] .. string.rep(' ', width - 2) .. border_chars[6]
    end

    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(border_buf, 0, -1, true, lines)
end

local function create_border()
  if not border_buf then
    border_buf = vim.api.nvim_create_buf(false, true)
  end

  draw_border()
end

local function open_border_window()
  local width = vim.go.columns - padding_x * 2
  local height = vim.go.lines - padding_y * 2
  local sx = padding_x
  local sy = padding_y

  border_win = vim.api.nvim_open_win(border_buf, 1, {
    relative = 'editor',
    anchor = 'nw',
    width = width,
    height = height,
    col = sx,
    row = sy,
    -- focusable = false,
    style = 'minimal',
    border = 'none',
  })

  vim.api.nvim_win_set_option(border_win, 'winhl', 'Normal:Float')
end

local function close_border_window()
  if not border_win then
    return
  end
  vim.api.nvim_win_close(border_win, { force = true })
  border_win = nil
end

local function open_terminal_window()
  if not border_win then
    open_border_window()
  end

  local opts = vim.api.nvim_win_get_config(border_win)
  opts.width = opts.width - 2
  opts.height = opts.height - 2
  opts.col = padding_x + 1
  opts.row = padding_y + 1
  opts.focusable = true

  term_win = vim.api.nvim_open_win(0, true, opts)
end

local function close_terminal_window()
  if not term_win then
    return
  end

  vim.api.nvim_win_close(term_win, { force = true })
  term_win = nil

  if border_win then
    close_border_window()
  end
end

local function create_terminal_buffer()
  if not term_win then
    open_terminal_window()
  end

  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(term_win, term_buf)
  table.insert(open_terms, term_buf)
  current_term = #open_terms

  vim.fn.termopen(vim.opt.shell:get(), {
    on_exit = function()
      for k, v in ipairs(open_terms) do
        if v == term_buf then
          table.remove(open_terms, k)
          if #open_terms == 0 then
            current_term = #open_terms
            close_terminal_window()
            break
          end

          if current_term == k then
            current_term = current_term - 1
            vim.api.nvim_win_set_buf(term_win, open_terms[current_term])
            break
          end

          if current_term > k then
            current_term = current_term - 1
          end
          break
        end
      end
      draw_border()
    end
  })

  draw_border()
end

local function open_current_terminal()
  if not term_win then
    open_terminal_window()
  end

  if #open_terms == 0 then
    create_terminal_buffer()
  end

  vim.api.nvim_win_set_buf(term_win, open_terms[current_term])

  vim.api.nvim_create_autocmd({ 'WinClosed', 'WinLeave' }, {
    buffer = open_terms[current_term],
    once = true,
    callback = function()
      if term_win then
        close_terminal_window()
      end
      close_border_window()
    end,
  })

  draw_border()
end

local function next_terminal()
  current_term = current_term + 1
  if current_term > #open_terms then
    current_term = 1
  end

  open_current_terminal()
end

local function prev_terminal()
  current_term = current_term - 1
  if current_term == 0 then
    current_term = #open_terms
  end

  open_current_terminal()
end

create_border()
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    draw_border()

    if border_win then
      close_border_window()
      open_border_window()
    end
  end
})

vim.keymap.set('n', '<leader>tt', function()
  if term_win then
    close_terminal_window()
  else
    open_current_terminal()
  end
end)

vim.keymap.set('n', '<leader>to', function()
  create_terminal_buffer()
end)

vim.keymap.set('n', '<leader>tn', function()
  next_terminal()
end)

vim.keymap.set('n', '<leader>tp', function()
  prev_terminal()
end)

vim.keymap.set('t', '<C-x><Esc>', '<C-\\><C-n>')
