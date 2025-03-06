return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'VeryLazy' }, -- https://www.lazyvim.org/plugins/lsp#nvim-lspconfig
    lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      'saghen/blink.cmp',
    },
    config = function()
      -- Setup neovim lua configuration
      require('neodev').setup()

      -- [[ Configure LSP ]]
      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', function()
          vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
        end, '[C]ode [A]ction')

        local fzflua = require 'fzf-lua'
        nmap('gd', fzflua.lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', fzflua.lsp_references, '[G]oto [R]eferences')
        nmap('gI', fzflua.lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>td', fzflua.lsp_typedefs, 'Type [D]efinition')
        nmap('<leader>ds', fzflua.lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', fzflua.lsp_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end
      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        lua_ls = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              library = {
                ['/opt/homebrew/share/lua/5.4/'] = true,
                ['/opt/homebrew/lib/lua/5.4/'] = true,
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = { globals = { 'vim' } },
          },
        },
      }

      -- blink.cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local get_git_root_dir = function(fname)
        local util = require 'lspconfig.util'
        return util.root_pattern '.git'(fname)
      end

      local lspconfig = require 'lspconfig'

      local tsls_inlay_hints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
        -- NOTES: if somewhat broken change back to ts_ls
        ['ts_ls'] = function()
          lspconfig.ts_ls.setup {
            capabilities = capabilities,
            root_dir = get_git_root_dir,
            on_attach = on_attach,
            settings = {
              typescript = {
                suggest = {
                  autoImports = false,
                },
                tsserver = {
                  maxTsServerMemory = 8192,
                },
                inlayHints = tsls_inlay_hints,
              },
              javascript = {
                suggest = {
                  autoImports = false,
                },
                inlayHints = tsls_inlay_hints,
              },
            },
          }
        end,
        ['eslint'] = function()
          lspconfig.eslint.setup {
            autostart = false,
            cmd = { 'vscode-eslint-language-server', '--stdio', '--max-old-space-size=8192' },
            capabilities = capabilities,
            root_dir = get_git_root_dir,
            on_attach = on_attach,
          }
        end,
      }
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    lazy = vim.fn.argc(-1) == 0, -- load lsp early when opening a file from the cmdline
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup {}
      vim.diagnostic.config { virtual_text = false }
    end,
  },
}
