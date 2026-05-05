---@param repo string
---@return string
_G.gh = function(repo)
  return 'https://github.com/' .. repo
end

require 'custom_plugins.file_explorer'
require 'custom_plugins.treesitter'
require 'custom_plugins.autoformat'
require 'custom_plugins.ai'
require 'custom_plugins.completion'
require 'custom_plugins.lsp'
require 'custom_plugins.autopair'
require 'custom_plugins.buffer'
require 'custom_plugins.git'
require 'custom_plugins.small_utils'

-- internal work related
local exist, mod = pcall(require, 'trae')
if exist then
  mod.setup {}
end
