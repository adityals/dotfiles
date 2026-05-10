-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- trae
vim.g.trae_disable_autocompletion = true
vim.g.trae_no_map_tab = true
vim.g.trae_disable_bindings = true

-- set transparent
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })

-- NOTES: experimental
require('vim._core.ui2').enable {}

-- lazy load util
vim.pack.add({ 'https://github.com/lumen-oss/lz.n' }, { confirm = false })

require 'custom_plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
