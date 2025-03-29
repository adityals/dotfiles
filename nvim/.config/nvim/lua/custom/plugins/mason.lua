local ensure_installed = {
  "lua-language-server",
  "vtsls",
  "eslint-lsp",
  "gopls",
}

return {
  {
    'williamboman/mason.nvim',
    event = { 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require('mason').setup {}
      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
      }
    end
  },
  {
    'j-hui/fidget.nvim',
    event = { 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    opts = {}
  }
}
