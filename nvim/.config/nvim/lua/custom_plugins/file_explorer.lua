vim.pack.add({
  { src = gh 'stevearc/oil.nvim', load = function() end },
  { src = gh 'ibhagwan/fzf-lua', load = function() end },
}, { confirm = false })

require('lz.n').load {
  {
    'oil.nvim',
    keys = {
      { '-', '<CMD>Oil<CR>', { desc = 'Open parent directory with oil' } },
      { '<leader>e', require('oil').toggle_float, { desc = 'Toggle oil float in curr directory' } },
    },
    after = function()
      require('oil').setup {
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        float = {
          max_width = 0.8,
          max_height = 0.8,
        },
        keymaps = {
          ['g?'] = { 'actions.show_help', mode = 'n' },
          ['<CR>'] = 'actions.select',
          ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
          ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
          ['<C-t>'] = { 'actions.select', opts = { tab = true } },
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = { 'actions.close', mode = 'n' },
          ['<C-l>'] = 'actions.refresh',
          ['-'] = { 'actions.parent', mode = 'n' },
          ['_'] = { 'actions.open_cwd', mode = 'n' },
          ['`'] = { 'actions.cd', mode = 'n' },
          ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
          ['gs'] = { 'actions.change_sort', mode = 'n' },
          ['gx'] = 'actions.open_external',
          ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
          ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        },
        use_default_keymaps = false,
      }
    end,
  },
  {
    'fzf-lua',
    keys = {
      { '<leader>ff', require('fzf-lua').files, { desc = 'Search files' } },
      { '<leader>fb', require('fzf-lua').buffers, { desc = 'Search buffers' } },
      { '<leader>ps', require('fzf-lua').grep, { desc = 'Search patterns' } },
      { '<leader>sw', require('fzf-lua').live_grep, { desc = 'Search words live' } },
    },
    after = function()
      local fzflua = require 'fzf-lua'
      local utils = require('fzf-lua').utils
      local actions = require('fzf-lua').actions

      local function hl_validate(hl)
        return not utils.is_hl_cleared(hl) and hl or nil
      end

      fzflua.setup {
        keymap = {
          fzf = {
            ['ctrl-a'] = 'select-all+accept',
          },
        },
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
        fzf_opts = { ['--layout'] = 'default', ['--marker'] = '+', ['--wrap'] = '' },
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
          width = 0.9,
          height = 0.9,
          preview = {
            default = 'bat',
            vertical = 'down:25%', -- up|down:size
            horizontal = 'right:40%', -- right|left:size
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
        files = {
          cwd_prompt = false,
          rg_opts = [[--hidden --glob=!.git/ --column --line-number --no-heading --color=never --smart-case --max-columns=4096 -e]],
          fd_opts = [[--color=never --type file --hidden --exclude .git ]],
        },
        actions = {
          files = {
            ['enter'] = actions.file_edit_or_qf,
            ['ctrl-s'] = actions.file_split,
            ['ctrl-v'] = actions.file_vsplit,
            ['ctrl-t'] = actions.file_tabedit,
            ['ctrl-q'] = actions.file_sel_to_qf,
            ['ctrl-Q'] = actions.file_sel_to_ll,
            ['ctrl-i'] = actions.toggle_ignore,
            ['ctrl-h'] = actions.toggle_hidden,
            ['ctrl-f'] = actions.toggle_follow,
          },
        },
      }
    end,
  },
}
