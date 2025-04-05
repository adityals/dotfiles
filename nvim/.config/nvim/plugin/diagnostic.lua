local diagnostic = vim.diagnostic

diagnostic.config({
  virtual_lines = {
    current_line = true
  },
  virtual_text = false,
  severity_sort = true,
})
