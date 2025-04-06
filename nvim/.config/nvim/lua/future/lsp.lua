-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.lsp.enable({
    'lua_ls',
    'vtsls',
    'eslint',
    'gopls',
})

--  merge lsp capabilities with blink (blink should not be lazy)
local capabilities = {
    textDocument = {
        semanticTokens = {
            multilineTokenSupport = true,
        },
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
}
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' }
})
