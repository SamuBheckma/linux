return {
  -- 1. O gerenciador Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2. O Mason-DAP (faz o Mason instalar debuggers automaticamente)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        -- Escreva aqui os debuggers das linguagens que você usa
        -- Exemplos: "python", "js" (para javascript/typescript), "codelldb" (para C/C++/Rust)
        ensure_installed = { "python", "codelldb", "java", "js" },
        automatic_installation = true,
      })
    end,
  },

  -- 3. O Core do Debugger e a Interface Visual (DAP + DAP UI)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Requisito para o dap-ui nas versões novas
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Abre a interface de debug automaticamente quando o debug começa
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- Fecha a interface automaticamente quando o debug termina
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Atalhos de teclado para debugar
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Iniciar/Continuar" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Passar por cima (Step Over)" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Entrar na função (Step Into)" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Sair da função (Step Out)" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Marcar/Desmarcar Breakpoint" })
    end,
  },
}

