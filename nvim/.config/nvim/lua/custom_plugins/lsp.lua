-- lsp eager start

vim.pack.add({
  gh 'neovim/nvim-lspconfig',
  gh 'williamboman/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
}, { confirm = false })

local mason = require 'mason'
mason.setup {}

local mason_lsp = require 'mason-lspconfig'
mason_lsp.setup {
  ensure_installed = {
    'copilot',
    'cssls',
    'eslint',
    'gopls',
    'lua_ls',
    'oxlint',
    'oxfmt',
    'stylua',
    'rust_analyzer',
    'tsgo',
    'tailwindcss',
    'vtsls',
  },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('vtsls', {
  settings = require('lsp_config.vtsls').settings,
})

vim.lsp.config('lua_ls', {
  settings = require('lsp_config.lua_ls').settings,
})

local eslint_lsp = require 'lsp_config.eslint'
vim.lsp.config('eslint', {
  cmd = eslint_lsp.cmd,
  settings = eslint_lsp.settings,
})

vim.lsp.config('gopls', {
  settings = require('lsp_config.gopls').settings,
})

vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.enable {
  'copilot',
  'cssls',
  'eslint',
  'gopls',
  'lua_ls',
  'oxlint',
  'oxfmt',
  'stylua',
  'rust_analyzer',
  'tailwindcss',
  'vtsls',
}
