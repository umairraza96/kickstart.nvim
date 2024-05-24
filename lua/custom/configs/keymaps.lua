-- Custom Keymaps

local map = vim.keymap.set

-- diagnostic,
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float', close_on_exit = true }
local htop = Terminal:new { cmd = 'htop', hidden = true, direction = 'float', close_on_exit = true }

function _lazygit_toggle()
  lazygit:toggle()
end

function _htop_toggle()
  htop:toggle()
end

return {

  map('n', '<C-u>', '<C-u>zz', { desc = 'Move cursor up', remap = true }),
  map('n', '<C-d>', '<C-d>zz', { desc = 'Move cursor down', remap = true }),
  -- Move to window using the <ctrl> hjkl keys
  map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true }),
  map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true }),
  map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true }),
  map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true }),

  -- Resize window using <ctrl> arrow keys
  map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' }),
  map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' }),
  map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' }),
  map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' }),

  -- Move Lines
  map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' }),
  map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' }),
  map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' }),
  map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' }),
  map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' }),
  map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' }),
  -- buffers,
  -- map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Prev buffer' }),
  -- map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' }),
  -- map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' }),
  -- map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' }),
  -- map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' }),
  map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' }),

  -- better indenting
  map('v', '<', '<gv'),
  map('v', '>', '>gv'),

  -- diagnostic
  map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' }),
  map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' }),
  map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' }),
  map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' }),
  map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' }),
  map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' }),
  map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' }),

  -- lazygit
  map('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { desc = 'Lazygit' }),
  -- map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

  -- git diff
  map('n', '<leader>gd', function()
    vim.cmd ':DiffviewOpen'
  end, { desc = '[G]it [D]iffview' }),

  -- system status
  map('n', '<leader>ht', '<cmd>lua _htop_toggle()<CR>', { desc = '[H][T]OP' }),

  -- copy in register
  map({ 'n', 'v' }, '<leader>p', '"_dP', { desc = '[P]aste with register' }),

  --terminal
  map('n', '<C-`>', function()
    vim.cmd [[ToggleTerm persist_mode = true]]
  end, { desc = 'Toggle Terminal' }),

  map('n', '<leader>fe', function()
    vim.cmd [[Neotree toggle]]
  end, { desc = 'Toggle [F]ile [E]xplorer' }),

  map('n', '<leader>rf', function()
    vim.cmd [[Neotree reveal]]
  end, { desc = '[R]eveal [F]ile in Explorer' }),
  -- map('t', '<C-c>', [[<C-\><C-n>]], { desc = 'Exit terminal insert mode with ESC' }),

  -- Lazy
  map('n', '<leader>l', function()
    vim.cmd ':Lazy'
  end, { desc = 'Open [L]azy' }),
}
