local exist, internal_ai_tools = pcall(require, 'config.internal_ai')
local ai_tools_cli = {}

if exist then
    for k, value in pairs(internal_ai_tools) do
        ai_tools_cli[k] = value
    end
end

return {
    {
        'folke/sidekick.nvim',
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                },
                win = {
                    split = {
                        width = 55,
                    },
                },
                tools = ai_tools_cli,
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>"
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                '<leader>aa',
                function()
                    require('sidekick.cli').toggle()
                end,
                desc = '[Sidekick] Toggle CLI',
            },
            {
                '<leader>as',
                function()
                    require('sidekick.cli').select { filter = { installed = true } }
                end,
                desc = '[Sidekick] Select CLI',
            },
            {
                '<leader>ad',
                function()
                    require('sidekick.cli').close()
                end,
                desc = '[Sidekick] Detach a CLI Session',
            },
            {
                '<leader>ap',
                function()
                    require('sidekick.cli').prompt()
                end,
                mode = { 'n', 'x' },
                desc = '[Sidekick] Select Prompt',
            },
        },
    },
}
