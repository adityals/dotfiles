-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local set = vim.keymap.set

set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[y]ank to clipboard' })
set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank to clipboard' })

set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")
set('n', '<C-k>', '<cmd>cnext<CR>zz')
set('n', '<C-j>', '<cmd>cprev<CR>zz')
set('n', 'J', 'msJ`z')

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
