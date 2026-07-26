return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Na versão moderna, as configurações são diretas no módulo principal
      require("nvim-treesitter").setup({
        -- Garante a instalação do parser de Lua e outras essenciais
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        
        -- Instala parsers faltantes ao abrir os arquivos
        auto_install = true,

        -- Ativa o realce de sintaxe avançado
        highlight = {
          enable = true,
        },
      })
    end,
  }
}

