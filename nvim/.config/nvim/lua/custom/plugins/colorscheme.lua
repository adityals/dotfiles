return {
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup {
        options = {
          transparent = false,
          styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
          },
        },
        palettes = { nordfox = { bg1 = '#181616' } },
      }
      vim.cmd 'colorscheme nordfox'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    enabled = false, -- enable when not boring
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
