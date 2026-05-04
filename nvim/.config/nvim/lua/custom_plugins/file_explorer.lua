vim.pack.add({
  gh 'stevearc/oil.nvim',
  gh 'ibhagwan/fzf-lua',
}, { confirm = false })

-- oil.nvim
local oil = require 'oil'
oil.setup {
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

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory with oil' })
vim.keymap.set('n', '<leader>e', oil.toggle_float, { desc = 'Toggle oil float in curr directory' })

-- fzf-lua
local fzflua = require 'fzf-lua'
local utils = require('fzf-lua').utils

local function hl_validate(hl)
  return not utils.is_hl_cleared(hl) and hl or nil
end

vim.keymap.set('n', '<leader>ff', fzflua.files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>fb', fzflua.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>ps', fzflua.grep, { desc = 'Search patterns' })
vim.keymap.set('n', '<leader>sw', fzflua.live_grep, { desc = 'Search words live' })

fzflua.setup {
  keymap = {
    fzf = {
      ['ctrl-q'] = 'select-all+accept',
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
}
