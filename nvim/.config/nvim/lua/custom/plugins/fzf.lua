return {
  {
    'ibhagwan/fzf-lua',
    opts = {},
    keys = {
      {
        '<leader>ff',
        function()
          require('fzf-lua').files {}
        end,
        desc = 'Search Files',
      },
      {
        '<leader>ps',
        function()
          require('fzf-lua').grep {}
        end,
        desc = 'Search Pattern',
      },
      {
        '<leader>sw',
        function()
          require('fzf-lua').live_grep {}
        end,
        desc = 'Live Grep',
      },
    },
    config = function()
      local fzflua = require 'fzf-lua'
      fzflua.setup {
        winopts = {
          width = 0.95, -- window width
        },
        files = {
          git_icons = false,
          file_icons = false,
          color_icons = false,
        },
        grep = {
          -- adding --hidden from default value
          rg_opts = '--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
          git_icons = false,
          file_icons = false,
          color_icons = false,
        },
        git = {
          files = {
            git_icons = true,
            file_icons = false,
            color_icons = false,
          },
        },
      }
    end,
  },
}
