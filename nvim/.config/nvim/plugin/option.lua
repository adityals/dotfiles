-- [[ Setting options ]]
-- See `:help vim.opt

local opt = vim.opt
local wo = vim.wo

-- Set highlight on search
opt.hlsearch = false

-- Make line numbers default
wo.number = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
wo.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

--  My custom options
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.showbreak = '↪'

opt.cursorline = true

opt.number = true
opt.relativenumber = true

opt.title = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.colorcolumn = '120'

-- disable showmode
vim.cmd 'set noshowmode'
