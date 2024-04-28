return {

  -- lua line
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    opts = {
      options  = {
        icons_enabled = true,
        theme = 'catppuccin-mocha',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = { { 'filename', path = 1, } },
      },
    },
  },

  -- better vim.ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- This is what powers LazyVim's fancy-looking
  -- tabs, which include filetype icons and close buttons.
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>',          desc = 'Delete other buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>',           desc = 'Delete buffers to the right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>',            desc = 'Delete buffers to the left' },
      { '<S-h>',      '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
      { '<S-l>',      '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
      { '[b',         '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
      { ']b',         '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
    },
    opts = {
      options = {
        -- stylua: ignore
        -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- -- stylua: ignore
        -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- diagnostics = 'nvim_lsp',
        -- always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require('lazyvim.config').icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
