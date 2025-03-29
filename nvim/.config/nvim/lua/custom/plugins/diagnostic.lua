return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',          -- Or `LspAttach`
  enabled = false,             -- TODO: if current_line is enough clean up this file
  lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
  priority = 1000,             -- needs to be loaded in first
  opts = {},
}
