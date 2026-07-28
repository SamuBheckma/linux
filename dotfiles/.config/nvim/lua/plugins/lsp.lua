-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  ------------------------------------------------------------------
  -- Mason
  ------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  ------------------------------------------------------------------
  -- Mason LSPConfig
  ------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "jdtls",
      },
      automatic_installation = true,
    },
  },

  ------------------------------------------------------------------
  -- LSPCONFIG
  ------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local lspconfig = require("lspconfig")

      ----------------------------------------------------------------
      -- Capabilities do nvim-cmp
      ----------------------------------------------------------------
      local capabilities =
        require("cmp_nvim_lsp").default_capabilities()

      ----------------------------------------------------------------
      -- Diagnósticos
      ----------------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      ----------------------------------------------------------------
      -- Keymaps ao conectar um LSP
      ----------------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)

          local opts = {
            buffer = event.buf,
            silent = true,
          }

          vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            opts
          )

          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            opts
          )

          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            opts
          )

          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            opts
          )

          vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            opts
          )

          vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            opts
          )

          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
          )

          vim.keymap.set(
            "n",
            "[d",
            vim.diagnostic.goto_prev,
            opts
          )

          vim.keymap.set(
            "n",
            "]d",
            vim.diagnostic.goto_next,
            opts
          )
        end,
      })

      ----------------------------------------------------------------
      -- Lua Language Server
      ----------------------------------------------------------------
      lspconfig.lua_ls.setup({
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
              },
            },

            workspace = {
              checkThirdParty = false,
            },

            telemetry = {
              enable = false,
            },
          },
        },
      })

      ----------------------------------------------------------------
      -- Disponibiliza as capabilities para o jdtls
      ----------------------------------------------------------------
      _G.lsp_capabilities = capabilities
    end,
  },
}
