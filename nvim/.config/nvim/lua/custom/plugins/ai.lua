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
    {
        'olimorris/codecompanion.nvim',
        keys = {
            { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[CodeCompanion] Toggle Chat' },
            { '<leader>ai', '<cmd>CodeCompanion<cr>',            mode = { 'n', 'v' },                 desc = '[CodeCompanion] Inline Prompt' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local opts = {
                -- NOTES: need to install acp client
                -- codex: https://github.com/zed-industries/codex-acp
                -- claude: https://github.com/zed-industries/claude-agent-acp
                interactions = {
                    chat = {
                        adapter = {
                            name = 'claude_code',
                        },
                    },
                    inline = {
                        adapter = {
                            name = 'ollama',
                            model = 'kimi-k2.5:cloud',
                        },
                    },
                },
                adapters = {
                    acp = {
                        claude_code = function()
                            return require('codecompanion.adapters').extend('claude_code', {
                                env = {
                                    ANTHROPIC_AUTH_TOKEN = 'ollama',
                                    ANTHROPIC_BASE_URL = 'http://localhost:11434',
                                    ANTHROPIC_AUTH_KEY = '',
                                },
                            })
                        end,
                    },
                    http = {
                        ollama = function()
                            return require('codecompanion.adapters').extend('ollama', {
                                env = {
                                    url = 'http://127.0.0.1:11434',
                                },
                            })
                        end,
                    },
                },
                display = {
                    chat = {
                        window = {
                            position = 'right',
                        },
                    },
                },
            }
            require('codecompanion').setup(opts)
        end,
    },
}
