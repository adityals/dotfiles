return {
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>sn',
        '<CMD>ScratchWithName<CR>',
        desc = 'Scratching with Name',
      },
      {
        '<leader>so',
        '<CMD>ScratchOpen<CR>',
        desc = 'Scratching Open',
      },
    },
  },
  {
    'CRAG666/code_runner.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>cr',
        function()
          require('code_runner').run_code()
        end,
        desc = 'Code run',
      },
    },
    opts = {
      filetype = {
        javascript = 'bun',
        typescript = 'bun',
      },
    },
  },
}
