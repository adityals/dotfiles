-- treesitter eager start

local api = vim.api

vim.pack.add({
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-treesitter/nvim-treesitter-context',
  gh 'windwp/nvim-ts-autotag',
}, { confirm = false })

local treesitter = require 'nvim-treesitter'
treesitter.setup {}
treesitter.install {
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

api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

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

local function setup_autotag()
  require('nvim-ts-autotag').setup {}
end

api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    setup_autotag()
  end,
})

api.nvim_create_autocmd('BufNewFile', {
  pattern = '*',
  callback = function()
    setup_autotag()
  end,
})
