return {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
  {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows eor more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = {
      "rktjmp/lush.nvim",
    },

    -- config = function()
    --   vim.cmd.colorscheme 'duckbones'
    -- end,
  },

  -- Catpuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
