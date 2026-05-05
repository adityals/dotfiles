vim.pack.add({
  gh 'stevearc/conform.nvim',
}, { confirm = false })

local api = vim.api
local conform = require 'conform'

conform.setup {
  notify_on_error = false,
  format_after_save = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    conform.format { bufnr = args.buf }
  end,
})
