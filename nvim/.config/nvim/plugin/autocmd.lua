local api = vim.api
local lsp = vim.lsp
local set = vim.keymap.set

api.nvim_create_autocmd('LspAttach', {
    group = api.nvim_create_augroup('my_lsp_attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            if desc then
                desc = 'LSP: ' .. desc
            end
            set(mode, keys, func, { buffer = event.buf, desc = desc })
        end


        local fzflua = require 'fzf-lua'

        map('<leader>rn', lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', lsp.buf.code_action, '[C]ode [A]ction')

        map('gd', fzflua.lsp_definitions, '[G]oto [D]efinition')
        map('gr', fzflua.lsp_references, '[G]oto [R]eferences')
        map('gI', fzflua.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>td', fzflua.lsp_typedefs, 'Type [D]efinition')
        map('<leader>ds', fzflua.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', fzflua.lsp_workspace_symbols, '[W]orkspace [S]ymbols')

        map('gD', lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>wa', lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        map('<leader>wr', lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        map('<leader>wl', function()
            print(vim.inspect(lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')


        api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
        end

        local client = lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = api.nvim_create_augroup('my_lsp_highlight', { clear = false })
            api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = lsp.buf.document_highlight,
            })

            api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = lsp.buf.clear_references,
            })

            api.nvim_create_autocmd('LspDetach', {
                group = api.nvim_create_augroup('my_lsp_detach', { clear = true }),
                callback = function(event_detach)
                    lsp.buf.clear_references()
                    api.nvim_clear_autocmds { group = 'my_lsp_highlight', buffer = event_detach.buf }
                end,
            })
        end

        if client and client_supports_method(client, lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>ih', function()
                lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end
})
