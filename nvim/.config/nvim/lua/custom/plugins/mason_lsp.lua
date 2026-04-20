return {
    'mason-org/mason-lspconfig.nvim',
    opts = {
        ensure_installed = {
            'cssls',
            'eslint',
            'gopls',
            'lua_ls',
            'oxlint',
            'rust_analyzer',
            'stylua',
            'tailwindcss',
            'vtsls',
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
            'rust_analyzer',
            'tailwindcss',
            'vtsls',
        }
    end,
}
