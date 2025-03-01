return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    local oil = require 'oil'
    oil.setup {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      -- lsp_file_methods = {
      --   enabled = true,
      --   timeout_ms = 5000, -- default 1000
      --   autosave_changes = true, -- default false
      -- },
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
  end,
}
