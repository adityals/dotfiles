return {
  -- Git related plugins
  {
    'NeogitOrg/neogit',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>gs',
        '<CMD>Neogit<CR>',
        desc = 'Open Neogit',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim',

      'ibhagwan/fzf-lua',
    },
    config = true,
  },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },
}
