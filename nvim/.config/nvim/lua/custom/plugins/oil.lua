return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    local oil = require 'oil'
    oil.setup {
      skip_confirm_for_simple_edits = false,
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory with oil' })
    vim.keymap.set('n', '<leader>e', oil.toggle_float, { desc = 'Toggle oil flot in parent directory' })
  end,
}
