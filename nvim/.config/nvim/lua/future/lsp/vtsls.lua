local inlay_hints = {
    parameterNames = {
        enabled = 'all'
    },
    parameterTypes = {
        enabled = true
    },
    variableTypes = {
        enabled = true
    },
    propertyDeclarationTypes = {
        enabled = true
    },
    functionLikeReturnTypes = {
        enabled = true
    },
    enumMemberValues = {
        enabled = true
    }
}

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
        vtsls = {
            autoUseWorkspaceTsdk = true,
        },
        typescript = {
            inlayHints = inlay_hints,
            tsserver = {
                maxTsServerMemory = 8192,
            }
        },
        javascript = {
            inlayHints = inlay_hints,
        }
    },
}
