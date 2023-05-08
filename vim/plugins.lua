--]] to update plugins do: Packer sync ; packer update
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})
end)




