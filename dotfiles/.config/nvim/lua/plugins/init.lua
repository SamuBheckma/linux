return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    
    priority = 1000, 
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          position = "left", -- Abre na lateral esquerda
          width = 30,        -- Largura da janela
        },
        filesystem = {
          filtered_items = {
            visible = true,  -- Mostra arquivos ocultos
          },
        }
      })

      vim.keymap.set('n', '<F2>', ':Neotree toggle<CR>', { silent = true })
    end
  },
}

