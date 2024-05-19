return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true
  },
  init = function()
    vim.cmd.colorscheme "tokyonight-moon"
    vim.cmd.hi 'Comment gui=none'
  end
}
