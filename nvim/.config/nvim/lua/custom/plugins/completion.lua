return {
  {
    'saghen/blink.compat',
    version = '2.*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      'rafamadriz/friendly-snippets',
      'folke/lazydev.nvim',
    },
    version = '1.*',
    opts = {
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
    },
    opts_extend = { 'sources.default' },
  },
}
