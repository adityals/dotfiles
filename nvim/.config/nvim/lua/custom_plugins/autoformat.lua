vim.pack.add({
  { src = gh 'stevearc/conform.nvim', load = function() end },
}, { confirm = false })

require('lz.n').load {
  'conform.nvim',
  event = { 'BufWritePre', 'BufReadPre', 'BufNewFile' },
  after = function()
    local conform = require 'conform'
    conform.setup {
      notify_on_error = false,
      format_after_save = {
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', 'oxfmt', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', 'oxfmt', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', 'oxfmt', stop_after_first = true },
      },
    }
  end,
}

local api = vim.api

api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})
