return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
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
  },
}
