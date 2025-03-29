-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local set = vim.keymap.set

set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[y]ank to clipboard' })
set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank to clipboard' })
set('n', '<leader>cp', '<CMD>let @+=expand("%:p")<CR>', { desc = 'copy filepath current buffer' })

set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")
set('n', '<C-k>', '<cmd>cnext<CR>zz')
set('n', '<C-j>', '<cmd>cprev<CR>zz')
set('n', 'J', 'msJ`z')

-- exit terminal with esc
set('t', '<esc>', [[<C-\><C-n>]])

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Go to previous diagnostic message' })
set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Go to next diagnostic message' })

set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- utils
-- close all buffer
set('n', '<leader>bo', '<cmd>%bd|e#<cr>', { desc = 'Close all buffers but the current one' })
-- toggle virtual_lines
set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
