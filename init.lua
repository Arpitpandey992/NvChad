require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", true)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
-- key bindings
-- Move line up with Option+k
vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>==', { noremap = true, silent = true })
-- Move line down with Option+j
vim.api.nvim_set_keymap('n', '<M-j>', ':m .+1<CR>==', { noremap = true, silent = true })
-- Duplicate current line up with Shift+Option+K
-- Function to duplicate lines in normal mode
function duplicate_line_up()
  vim.api.nvim_command('normal! YP')
end

function duplicate_line_down()
  vim.api.nvim_command('normal! Yp')
end

-- Function to duplicate lines in visual mode
function duplicate_lines_up()
  vim.cmd('normal! y\'<Pgv')
end

function duplicate_lines_down()
  vim.cmd('normal! y\'<p')
end

-- Map Shift+Option+K to duplicate the current line or selected lines up in normal mode and visual mode
vim.api.nvim_set_keymap('n', '<S-M-k>', ':lua duplicate_line_up()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-M-k>', ':lua duplicate_lines_up()<CR>', { noremap = true, silent = true })

-- Map Shift+Option+J to duplicate the current line or selected lines down in normal mode and visual mode
vim.api.nvim_set_keymap('n', '<S-M-j>', ':lua duplicate_line_down()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-M-j>', ':lua duplicate_lines_down()<CR>', { noremap = true, silent = true })

-- make background of neovim transparent
vim.cmd("hi Normal ctermbg=none guibg=none")

-- fix clipboard when using inside WSL
vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = true,
}

require "plugins"

