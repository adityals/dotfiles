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
      local utils = require('fzf-lua').utils

      local function hl_validate(hl)
        return not utils.is_hl_cleared(hl) and hl or nil
      end

      fzflua.setup {
        defaults = {
          git_icons = false,
          file_icons = false,
          color_icons = false,
        },
        previewers = {
          bat = {
            cmd = 'bat',
            args = '--color=always --style=numbers,changes',
            theme = 'ansi',
          },
        },
        fzf_opts = { ['--layout'] = 'default', ['--marker'] = '+' },
        hls = {
          normal = hl_validate 'TelescopeNormal',
          border = hl_validate 'TelescopeBorder',
          title = hl_validate 'TelescopePromptTitle',
          help_normal = hl_validate 'TelescopeNormal',
          help_border = hl_validate 'TelescopeBorder',
          preview_normal = hl_validate 'TelescopeNormal',
          preview_border = hl_validate 'TelescopeBorder',
          preview_title = hl_validate 'TelescopePreviewTitle',
          cursor = hl_validate 'Cursor',
          cursorline = hl_validate 'TelescopeSelection',
          cursorlinenr = hl_validate 'TelescopeSelection',
          search = hl_validate 'IncSearch',
        },
        fzf_colors = {
          ['fg'] = { 'fg', 'TelescopeNormal' },
          ['bg'] = { 'bg', 'TelescopeNormal' },
          ['hl'] = { 'fg', 'TelescopeMatching' },
          ['fg+'] = { 'fg', 'TelescopeSelection' },
          ['bg+'] = { 'bg', 'TelescopeSelection' },
          ['hl+'] = { 'fg', 'TelescopeMatching' },
          ['info'] = { 'fg', 'TelescopeMultiSelection' },
          ['border'] = { 'fg', 'TelescopeBorder' },
          ['gutter'] = { 'bg', 'TelescopeNormal' },
          ['query'] = { 'fg', 'TelescopePromptNormal' },
          ['prompt'] = { 'fg', 'TelescopePromptPrefix' },
          ['pointer'] = { 'fg', 'TelescopeSelectionCaret' },
          ['marker'] = { 'fg', 'TelescopeSelectionCaret' },
          ['header'] = { 'fg', 'TelescopeTitle' },
        },
        winopts = {
          width = 0.8,
          height = 0.9,
          preview = {
            default = 'bat',
          },
        },
        manpages = { previewer = 'man_native' },
        helptags = { previewer = 'help_native' },
        tags = { previewer = 'bat' },
        btags = { previewer = 'bat' },
        grep = {
          -- adding --hidden from default value and exclude .git dir
          rg_opts = '--hidden --glob=!.git/ --column --line-number --no-heading --color=never --smart-case --max-columns=4096 -e',
        },
      }
    end,
  },
}
