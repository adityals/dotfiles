return {
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme kanso-zen')
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        enabled = false,
        config = function()
            require('rose-pine').setup {
                styles = {
                    bold = true,
                    italic = false,
                    transparency = false,
                },
            }
            vim.cmd 'colorscheme rose-pine-moon'
        end,
    },
    {
        'aliqyan-21/darkvoid.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            local glow_base_color = '#1bfd9c'

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
                    search_highlight = glow_base_color,
                    operator = glow_base_color,
                    bracket = glow_base_color,
                    preprocessor = '#4b8902',
                    bool = '#66b2b2',
                    constant = '#b2d8d8',
                },
            }
            vim.cmd 'colorscheme darkvoid'
        end,
    }
}
