return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy', -- https://www.lazyvim.org/configuration/examples
  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
    },
  },
  config = function()
    require('darkvoid').setup()
  end,
}
