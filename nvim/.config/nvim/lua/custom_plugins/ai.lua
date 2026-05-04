local exist, internal_ai_tools = pcall(require, 'config.internal_ai')
local ai_tools_cli = {}

if exist then
  for k, value in pairs(internal_ai_tools) do
    ai_tools_cli[k] = value
  end
end

vim.pack.add({
  gh 'folke/sidekick.nvim',
}, { confirm = false })

local sidekick = require 'sidekick'
sidekick.setup {
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

vim.keymap.set('n', '<tab>', function()
  if not sidekick.nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

local sidekick_cli = require 'sidekick.cli'
vim.keymap.set('n', '<leader>aa', sidekick_cli.toggle, { desc = '[Sidekick] Toggle CLI' })
vim.keymap.set('n', '<leader>ad', sidekick_cli.close, { desc = '[Sidekick] Detach CLI Session' })
vim.keymap.set('n', '<leader>ap', sidekick_cli.prompt, { desc = '[Sidekick] Select Prompt' })
