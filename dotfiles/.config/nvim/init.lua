local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrap = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.cursorline = true
opt.signcolumn = "yes"
opt.lazyredraw = true
opt.timeoutlen = 500
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")
opt.termguicolors = true

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = ","

keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<M-h>", "<C-w><", opts)
keymap("n", "<M-j>", "<C-w>-", opts)
keymap("n", "<M-k>", "<C-w>+", opts)
keymap("n", "<M-l>", "<C-w>>", opts)

keymap("n", "<leader>tn", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<Tab>", ":tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":tabprevious<CR>", opts)

keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)

keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

vim.api.nvim_create_user_command("TrimWhitespace", function()
  vim.cmd('%s/\\s\\+$//')
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! %s/\\s\\+$//")
  end
})

local function set_statusline()
  local statusline = table.concat({
    "%#StatusLine#",
    " %f",
    " %m",
    "%=",
    "Ln %l, Col %c ",
  })
  vim.o.statusline = statusline
end

set_statusline()
