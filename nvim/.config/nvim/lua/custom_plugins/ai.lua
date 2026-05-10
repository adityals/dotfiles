local exist, internal_ai_tools = pcall(require, 'config.internal_ai')
local ai_tools_cli = {}
local _99_config = {}

if exist then
  if internal_ai_tools['_99'] then
    _99_config = internal_ai_tools['_99']
  end

  local sidekick_ai_cli = internal_ai_tools['sidekick']
  for k, value in pairs(sidekick_ai_cli) do
    ai_tools_cli[k] = value
  end
end

vim.pack.add({
  { src = gh 'folke/sidekick.nvim', load = function() end },
  { src = gh 'ThePrimeagen/99', load = function() end },
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

local _99_keymap = lazy.keymap {
  '99',
  after = function()
    local _99 = require '99'
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    local provider = _99_config['provider_key'] or nil
    local model = _99_config['model'] or nil

    _99.setup {
      provider = _99.Providers[provider] or nil,
      model = model or nil,
      logger = {
        level = _99.DEBUG,
        path = '/tmp/' .. basename .. '.99.debug',
        print_on_error = true,
      },
      -- When setting this to something that is not inside the CWD tools
      -- such as claude code or opencode will have permission issues
      -- and generation will fail refer to tool documentation to resolve
      -- https://opencode.ai/docs/permissions/#external-directories
      -- https://code.claude.com/docs/en/permissions#read-and-edit
      tmp_dir = './tmp',
      --- Completions: #rules and @files in the prompt buffer
      completion = {
        -- I am going to disable these until i understand the
        -- problem better.  Inside of cursor rules there is also
        -- application rules, which means i need to apply these
        -- differently
        -- cursor_rules = "<custom path to cursor rules>"

        --- A list of folders where you have your own SKILL.md
        --- Expected format:
        --- /path/to/dir/<skill_name>/SKILL.md
        ---
        --- Example:
        --- Input Path:
        --- "scratch/custom_rules/"
        ---
        --- Output Rules:
        --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
        --- ... the other rules in that dir ...
        ---
        custom_rules = {
          -- 'scratch/custom_rules/',
        },

        --- Configure @file completion (all fields optional, sensible defaults)
        files = {
          -- enabled = true,
          -- max_file_size = 102400,     -- bytes, skip files larger than this
          -- max_files = 5000,            -- cap on total discovered files
          -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
        },
        --- File Discovery:
        --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
        --- - Non-git repos: Falls back to filesystem scanning with manual excludes
        --- - Both methods apply the configured `exclude` list on top of gitignore

        --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
        source = 'native', -- "native" (default), "cmp", or "blink"
      },

      --- WARNING: if you change cwd then this is likely broken
      --- ill likely fix this in a later change
      ---
      --- md_files is a list of files to look for and auto add based on the location
      --- of the originating request.  That means if you are at /foo/bar/baz.lua
      --- the system will automagically look for:
      --- /foo/bar/AGENT.md
      --- /foo/AGENT.md
      --- assuming that /foo is project root (based on cwd)
      md_files = {
        'AGENT.md',
      },
    }
  end,
}

_99_keymap.set({ 'v' }, '<leader>9v', function()
  require('99').visual()
end)

_99_keymap.set({ 'n' }, '<leader>9s', function()
  require('99').search()
end)
