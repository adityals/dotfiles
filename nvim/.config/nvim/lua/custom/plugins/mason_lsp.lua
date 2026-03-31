return {
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    event = { 'VeryLazy' },
    opts = {
      ensure_installed = {
        'stylua',
        'lua_ls',
        'vtsls',
        'eslint',
        'gopls',
        'rust_analyzer',
      },
    },
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'williamboman/mason.nvim',        config = true },
      { 'linrongbin16/lsp-progress.nvim', opts = {} },
    },
    config = function()
      local mason = require 'mason'
      mason.setup()

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

      vim.lsp.config('copilot-language-server', {})

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.enable {
        'lua_ls',
        'gopls',
        'vtsls',
        'rust_analyzer',
        'eslint',
        'oxlint',
        'tailwindcss',
      }
    end,
  },
}
