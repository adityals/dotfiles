return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'VeryLazy' },
        lazy = vim.fn.argc(-1) == 0,
        branch = "main",
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install {
                'c',
                'cpp',
                'go',
                'lua',
                'python',
                'rust',
                'tsx',
                'javascript',
                'typescript',
                'vimdoc',
                'vim',
                'bash',
                'thrift',
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'VeryLazy' },
        lazy = vim.fn.argc(-1) == 0,
        config = function()
            require('treesitter-context').setup {
                enable = true,
                max_lines = 1,
                min_window_height = 0,
                trim_scope = 'outer',
                patterns = {
                    default = {
                        'class',
                        'function',
                        'method',
                        'for',
                        'while',
                        'if',
                        'switch',
                        'case',
                    },
                    tex = {
                        'chapter',
                        'section',
                        'subsection',
                        'subsubsection',
                    },
                    rust = {
                        'impl_item',
                        'struct',
                        'enum',
                    },
                    scala = {
                        'object_definition',
                    },
                    vhdl = {
                        'process_statement',
                        'architecture_body',
                        'entity_declaration',
                    },
                    markdown = {
                        'section',
                    },
                    elixir = {
                        'anonymous_function',
                        'arguments',
                        'block',
                        'do_block',
                        'list',
                        'map',
                        'tuple',
                        'quoted_content',
                    },
                    json = {
                        'pair',
                    },
                    yaml = {
                        'block_mapping_pair',
                    },
                },
                on_attach = function(bufnr)
                    if vim.bo[bufnr].filetype == 'markdown' or vim.bo[bufnr].filetype == 'org' then
                        return false
                    end
                end,
                exact_patterns = {},
                zindex = 20,
                mode = 'cursor',
                separator = nil,
            }
            vim.keymap.set('n', '<leader>tc', '<CMD>TSContext toggle<CR>', { desc = 'Toggle treesitter-context' })
        end

    },
    {
        'windwp/nvim-ts-autotag',
        event = { 'BufReadPre', 'BufNewFile' },
        config = true,
    },
}
