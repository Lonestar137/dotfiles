-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
local gitConfig ={
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "mattn/vim-gist",
    event = "BufRead",
    dependencies = "mattn/webapi-vim",
  },
}

local plugins = {
  {"lunarvim/colorschemes"},
  {"ellisonleao/gruvbox.nvim"},
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup{
        enable = true,
        throttle = true, -- throttles plugin updates(may improve performance)
        max_lines = 0, -- 0 = no limit
        patterns = {
          --default = {
          --  'class',
          --  'function',
          --  'method',
          --},
        },
      }
    end
  },
  {
    -- Next gen note-taking
    "oberblastmeister/neuron.nvim",
  },
}

-- Add GitConfig
for i=1, #gitConfig do
  table.insert(plugins, gitConfig[i])
end

lvim.plugins = plugins


lvim.colorscheme = "gruvbox"
lvim.transparent_window = true
lvim.use_icons = false
-- vim.opt.tabstop = 4 -- 4 spaces for tabs
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"





