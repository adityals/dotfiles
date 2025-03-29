---@type vim.lsp.Config
return {
    cmd = { "vtsls", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = { ".git" },
    settings = {
        autoUseWorkspaceTsdk = true,
        typescript = {
            tsserver = {
                maxTsServerMemory = 8192,
            },
        },
        javascript = {
        }
    },
}
