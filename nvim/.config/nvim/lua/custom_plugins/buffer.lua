vim.pack.add({
  { src = gh 'serhez/bento.nvim' },
}, { confirm = false })

local bento = require 'bento'
bento.setup {}

vim.keymap.set('n', '<leader>bc', function()
  require('bento').close_all_buffers { visible = false, locked = false, current = false }
end, { desc = 'Close non visibile and protected buffers' })
