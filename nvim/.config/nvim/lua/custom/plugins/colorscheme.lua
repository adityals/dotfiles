return {
  {
    'aliqyan-21/darkvoid.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('darkvoid').setup {
        transparent = true,
        glow = true,
        colors = {
          fg = '#c0c0c0',
          bg = '#1c1c1c',
          cursor = '#bdfe58',
          line_nr = '#404040',
          visual = '#303030',
          comment = '#585858',
          string = '#d1d1d1',
          func = '#e1e1e1',
          kw = '#f1f1f1',
          identifier = '#b1b1b1',
          type = '#a1a1a1',
          type_builtin = '#c5c5c5', -- current
          -- type_builtin = '#8cf8f7', -- glowy blue old (was present by default before type_builtin was introduced added here for people who may like it)
          search_highlight = '#1bfd9c',
          operator = '#1bfd9c',
          bracket = '#1bfd9c',
          preprocessor = '#4b8902',
          bool = '#66b2b2',
          constant = '#b2d8d8',
        },
      }
      vim.cmd 'colorscheme darkvoid'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    enabled = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        -- https://github.com/rebelot/kanagawa.nvim/blob/master/README.md#remove-gutter-background
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file#dark-completion-popup-menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- https://github.com/rebelot/kanagawa.nvim/blob/master/README.md#transparent-floating-windows
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          }
        end,
      }
      vim.cmd 'colorscheme kanagawa-dragon'
    end,
  },
}
