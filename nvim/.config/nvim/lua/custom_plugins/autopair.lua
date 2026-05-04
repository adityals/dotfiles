vim.pack.add({
  gh 'saghen/blink.download',
  { src = gh 'saghen/blink.pairs', version = vim.version.range '*' },
}, { confirm = false })

require('blink.pairs').setup {
  mappings = {
    enabled = true,
    cmdline = true,
    disabled_filetypes = {},
    wrap = {
      -- move closing pair via motion
      ['<C-b>'] = 'motion',
      -- move opening pair via motion
      ['<C-S-b>'] = 'motion_reverse',
    },
    -- see the defaults:
    -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
    pairs = {},
  },
  highlights = {
    enabled = true,
    -- requires require('vim._extui').enable({}), otherwise has no effect
    cmdline = true,
    groups = { 'BlinkPairsOrange', 'BlinkPairsPurple', 'BlinkPairsBlue' },
    unmatched_group = 'BlinkPairsUnmatched',
    matchparen = {
      enabled = true,
      -- known issue where typing won't update matchparen highlight, disabled by default
      cmdline = false,
      -- also include pairs not on top of the cursor, but surrounding the cursor
      include_surrounding = false,
      group = 'BlinkPairsMatchParen',
      priority = 250,
    },
  },
  debug = false,
}
