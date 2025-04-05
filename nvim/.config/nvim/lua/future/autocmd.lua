local api = vim.api
local lsp = vim.lsp

-- See `:help vim.highlight.on_yank()`
local highlight_group = api.nvim_create_augroup('YankHighlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

api.nvim_create_user_command('LspLog', function()
    vim.cmd(string.format('tabnew %s', lsp.get_log_path()))
end, {
    desc = 'Opens the Nvim LSP client log.',
})

api.nvim_create_user_command('LspStop', function()
    local lsp_clients = vim.lsp.get_clients()
    vim.lsp.stop_client(lsp_clients)
end, { desc = 'Stop LSP' })
