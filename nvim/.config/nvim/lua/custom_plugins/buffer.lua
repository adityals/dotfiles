vim.pack.add({
  { src = gh 'serhez/bento.nvim', load = function() end },
}, { confirm = false })

require('lz.n').load {
  'bento.nvim',
  event = { 'BufRead', 'BufNewFile' },
  after = function()
    require('bento').setup {}
  end,
  keys = {
    {
      '<leader>bc',
      function()
        require('bento').close_all_buffers { visible = false, locked = false, current = false }
      end,
      { desc = 'Close non visibile and protected buffers' },
    },
  },
}
