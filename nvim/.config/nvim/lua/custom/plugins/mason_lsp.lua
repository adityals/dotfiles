local vimfn = vim.fn
local ensure_installed = {
  "lua-language-server",
  "vtsls",
  "eslint-lsp",
  "gopls",
}

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'VeryLazy' },     -- https://www.lazyvim.org/plugins/lsp#nvim-lspconfig
    lazy = vimfn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      -- Ensure the servers above are installed
      local mason = require 'mason'
      local mason_lspconfig = require 'mason-lspconfig'
      local mason_tools_installer = require 'mason-tool-installer'

      local lspconfig = require 'lspconfig'


      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      mason.setup()
      mason_lspconfig.setup()
      mason_tools_installer.setup {
        ensure_installed = ensure_installed,
      }

      local get_git_root_dir = function(fname)
        local util = require 'lspconfig.util'
        return util.root_pattern '.git' (fname)
      end

      -- Enable the following language servers
      -- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local eslint_lsp = require 'future.lsp.eslint'
      local servers = {
        lua_ls = {
          settings = require 'future.lsp.lua_ls'.settings,
        },
        vtsls = {
          root_dir = get_git_root_dir,
          settings = require 'future.lsp.vtsls'.settings
        },
        eslint = {
          cmd = eslint_lsp.cmd,
          root_dir = get_git_root_dir,
          settings = eslint_lsp.settings
        },
        gopls = {
          settings = require 'future.lsp.gopls'.settings
        }
      }

      -- blink.cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      mason_lspconfig.setup {
        ensure_installed = {}, -- we're using mason-tool-installer, so intented to empty table
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end
        }
      }
    end,
  }
}
