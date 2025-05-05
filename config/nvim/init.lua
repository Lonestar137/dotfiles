vim.g.mapleader = " "
vim.opt.relativenumber = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local autopairs = {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
}

local whichkey = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}

local plugins = {
  whichkey,
  autopairs,
  "ellisonleao/gruvbox.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "sindrets/diffview.nvim",
  "stevearc/oil.nvim"
}
local opts = {
	"folke/neoconf.nvim", cmd = "Neoconf",
	{ import = "custom/plugins" }, {
	  change_detection = {
	    notify = false,
	  },
	}
}

require("lazy").setup(plugins, opts)
require("mason").setup()
require("oil").setup()

vim.cmd.colorscheme "gruvbox"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>wh', '<c-w>h', {})
vim.keymap.set('n', '<leader>wl', '<c-w>l', {})
vim.keymap.set('n', '<leader>wj', '<c-w>j', {})
vim.keymap.set('n', '<leader>wk', '<c-w>k', {})
