return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'franco-ruggeri/codecompanion-lualine.nvim',
  },
  opts = {
    options = {
      icons_enabled = false,
      theme = 'auto',
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        'branch',
        'diagnostics',
      },
      lualine_c = {
        'filename',
        function()
          return require('lsp-progress').progress()
        end,
        'codecompanion',
      },
    },
  },
}
