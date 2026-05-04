vim.pack.add({
  gh 'MagicDuck/grug-far.nvim',
  gh 'otavioschwanck/arrow.nvim',
  gh 'hedyhli/outline.nvim',
  gh 'saghen/blink.indent',
  gh 'folke/which-key.nvim',
}, { confirm = false })

-- grug-far -> for search and replace
require('grug-far').setup {}

-- arrow -> code marking navigation
require('arrow').setup {
  show_icons = false,
  leader_key = '<space>;',
  buffer_leader_key = '<space>m',
}

-- outline -> outline code
require('outline').setup {
  outline_window = {
    position = 'left',
  },
}
vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle outline' })

-- blink.indent -> for indent marking
require('blink.indent').setup {}

-- undotree
vim.cmd 'packadd nvim.undotree'
vim.keymap.set('n', '<leader>u', '<cmd>Undotree<cr>', { desc = 'Toggle Undotree' })

-- which-key
require('which-key').setup {
  preset = 'helix',
}
