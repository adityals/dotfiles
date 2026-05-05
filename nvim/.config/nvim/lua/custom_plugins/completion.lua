vim.pack.add({
  { src = gh 'saghen/blink.compat', version = vim.version.range '2.*' },
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  gh 'dmitmel/cmp-digraphs',
  gh 'rafamadriz/friendly-snippets',
  gh 'folke/lazydev.nvim',
}, { confirm = false })

require('blink.compat').setup {}
require('blink.cmp').setup {
  keymap = {
    ['<Tab>'] = {
      function()
        return require('sidekick').nes_jump_or_apply()
      end,
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      function()
        return vim.lsp.inline_completion.get()
      end,
      'fallback',
    },
  },
  signature = { enabled = true },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    menu = {
      border = 'rounded',
      draw = {
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind', 'source_name', gap = 1 } },
      },
    },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    documentation = {
      auto_show = true,
      window = { border = 'rounded' },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'trae' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      trae = {
        name = 'trae',
        module = 'blink.compat.source',
        opts = {},
        async = true,
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
