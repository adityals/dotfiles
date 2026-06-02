local exist, internal_ai_tools = pcall(require, 'config.internal_ai')
local ai_tools_cli = {}

if exist then
  local sidekick_ai_cli = internal_ai_tools['sidekick']
  for k, value in pairs(sidekick_ai_cli) do
    ai_tools_cli[k] = value
  end
end

vim.pack.add({
  { src = gh 'folke/sidekick.nvim', load = function() end },
}, { confirm = false })

local lazy = require 'lz.n'
lazy.load {
  'sidekick.nvim',
  event = { 'BufRead', 'BufNewFile' },
  after = function()
    require('sidekick').setup {
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
        win = {
          split = {
            width = 55,
          },
        },
        tools = ai_tools_cli,
      },
    }
  end,
}

local sidekick_keymap = lazy.keymap {
  'sidekick.nvim',
}
sidekick_keymap.set('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })
sidekick_keymap.set('n', '<leader>aa', require('sidekick.cli').toggle, { desc = '[Sidekick] Toggle CLI' })
sidekick_keymap.set('n', '<leader>ad', require('sidekick.cli').close, { desc = '[Sidekick] Detach CLI Session' })
sidekick_keymap.set({ 'n', 'v' }, '<leader>ap', require('sidekick.cli').prompt, { desc = '[Sidekick] Select Prompt' })
