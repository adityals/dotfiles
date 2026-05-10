vim.pack.add({
  { src = gh 'MagicDuck/grug-far.nvim', load = function() end },
  { src = gh 'otavioschwanck/arrow.nvim', load = function() end },
  { src = gh 'hedyhli/outline.nvim', load = function() end },
  { src = gh 'saghen/blink.indent', load = function() end },
  { src = gh 'folke/which-key.nvim' },
}, { confirm = false })

require('lz.n').load {
  -- grug-far -> for search and replace
  {
    'grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    after = function()
      require('grug-far').setup {}
    end,
  },
  {
    -- outline -> outline code
    'outline.nvim',
    keys = {
      {
        '<leader>o',
        '<cmd>Outline<CR>',
        { desc = 'Toggle outline' },
      },
    },
    after = function()
      require('outline').setup {
        outline_window = {
          position = 'left',
        },
      }
    end,
  },
  -- undotree
  {
    'nvim.undotree',
    keys = {
      { '<leader>u', '<cmd>Undotree<cr>', { desc = 'Toggle Undotree' } },
    },
    after = function()
      vim.cmd 'packadd nvim.undotree'
    end,
  },
  -- arrow -> code marking navigation
  {
    'arrow.nvim',
    event = { 'BufRead', 'BufNewFile' },
    after = function()
      require('arrow').setup {
        show_icons = false,
        leader_key = '<space>;',
        buffer_leader_key = '<space>m',
      }
    end,
  },
  -- blink.indent -> for indent marking
  {
    'blink.indent',
    event = { 'BufRead', 'BufNewFile' },
    after = function()
      require('blink.indent').setup {}
    end,
  },
}

require('which-key').setup {
  preset = 'helix',
}
