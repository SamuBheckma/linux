-- ~/.config/nvim/init.lua - Configuração do Neovim
--
-- Neovim usa Lua (linguagem mais rápida que VimScript)
-- Arquivo de config chamado init.lua ao invés de init.vim
--

-- ============================================================================
-- OPÇÕES BÁSICAS
-- ============================================================================

local opt = vim.opt

-- Números de linha
opt.number = true
opt.relativenumber = true

-- Indentação
opt.expandtab = true      -- Tabs como espaços
opt.tabstop = 4           -- 4 espaços por tab
opt.shiftwidth = 4        -- 4 espaços para indent
opt.smartindent = true    -- Auto-indent inteligente

-- Busca
opt.ignorecase = true     -- Case-insensitive search
opt.smartcase = true      -- Mas case-sensitive se houver maiúscula
opt.hlsearch = true       -- Highlight de resultados
opt.incsearch = true      -- Busca enquanto digita

-- Interface
opt.wrap = true           -- Quebra de linha
opt.scrolloff = 8         -- Manter 8 linhas acima/abaixo do cursor
opt.sidescrolloff = 8     -- Idem para horizontal
opt.cursorline = true     -- Highlight a linha atual
opt.signcolumn = "yes"    -- Coluna para sinais (errors, etc)

-- Performance
opt.lazyredraw = true     -- Não redesenhar a cada macro
opt.timeoutlen = 500      -- Timeout para macros

-- Backup e undo
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- ============================================================================
-- TEMA/CORES
-- ============================================================================

-- Modo true color (colors mais bonitas)
opt.termguicolors = true

-- Tema padrão (ajuste conforme preferência)
-- vim.cmd.colorscheme "default"  -- Tema padrão

-- ============================================================================
-- KEYBINDINGS (atalhos de teclado)
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key (prefixo para commands)
-- Você vai ver esse padrão: <leader>wd para windows delete, etc
vim.g.mapleader = " "      -- Space como leader key
vim.g.maplocalleader = ","

-- Normal mode

-- Salvar arquivo
keymap("n", "<C-s>", ":w<CR>", opts)

-- Naegar entre splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Redimensionar splits
keymap("n", "<M-h>", "<C-w><", opts)
keymap("n", "<M-j>", "<C-w>-", opts)
keymap("n", "<M-k>", "<C-w>+", opts)
keymap("n", "<M-l>", "<C-w>>", opts)

-- Tabs
keymap("n", "<leader>tn", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<Tab>", ":tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":tabprevious<CR>", opts)

-- Insert mode

-- Escape com jj (mais rápido que ESC)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Visual mode

-- Identar com Tab/Shift-Tab
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- ============================================================================
-- COMANDOS E FUNÇÕES
-- ============================================================================

-- Comando para remover trailing whitespace
vim.api.nvim_create_user_command("TrimWhitespace", function()
  vim.cmd('%s/\\s\\+$//')
end, {})

-- Auto-comando para trim whitespace ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! %s/\\s\\+$//")
  end
})

-- ============================================================================
-- STATUS LINE (barra de status customizada)
-- ============================================================================

-- Função para atualizar statusline
local function set_statusline()
  local statusline = table.concat({
    "%#StatusLine#",
    " %f",                        -- Nome do arquivo
    " %m",                        -- Modified flag
    "%=",                         -- Separação
    "Ln %l, Col %c ",             -- Linha e coluna
  })
  vim.o.statusline = statusline
end

set_statusline()

-- ============================================================================
-- COMENTÁRIO IMPORTANTE: LAZY.NVIM
-- ============================================================================

--[[
Para instalar plugins, você pode usar Lazy.nvim:

1. Clonar Lazy.nvim:
   git clone --filter=blob:none https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/opt/lazy.nvim

2. No seu init.lua, adicionar:

   require("lazy").setup({
     { "nvim-treesitter/nvim-treesitter" },
     { "neovim/nvim-lspconfig" },
     -- ... mais plugins
   })

Para agora, deixar com apenas Lua puro (sem plugins). Você pode adicionar depois!
--]]

-- ============================================================================
-- INSTRUÇÕES: PRÓXIMOS PASSOS
-- ============================================================================

--[[
1. Editar este arquivo: :e ~/.config/nvim/init.lua
2. Tecla i para Insert mode
3. Digitar o que quer
4. ESC e :w para salvar
5. :source % para recarregar o arquivo

Modos do Vim:
  - Normal (ESC): navegação e edição
  - Insert (i, a, o): escrever texto
  - Visual (v): selecionar
  - Command (:): comandos

Atalhos básicos:
  - h, j, k, l: setas (esquerda, baixo, cima, direita)
  - w, e, b: próxima palavra, fim, começo
  - gg: início do arquivo
  - G: fim do arquivo
  - /pattern: buscar
  - dd: deletar linha
  - yy: copiar linha
  - p: colar
  - i: insert antes do cursor
  - a: insert depois do cursor
  - o: nova linha abaixo
  - O: nova linha acima
--]]
