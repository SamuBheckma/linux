-- ~/.config/nvim/lua/plugins/java.lua

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
    },

    config = function()
      local jdtls = require("jdtls")
      local mason = vim.fn.stdpath("data") .. "/mason/packages"

      ----------------------------------------------------------------
      -- Caminhos do Mason
      ----------------------------------------------------------------

      local launcher =
        vim.fn.glob(
          mason .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
        )

      local lombok =
        mason .. "/jdtls/lombok.jar"

      local bundles = {}

	vim.list_extend(
	  bundles,
	  vim.split(
	    vim.fn.glob(
	      vim.fn.stdpath("data")
	        .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
   ),
   "\n"
  )
)

vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(
      vim.fn.stdpath("data")
        .. "/mason/packages/java-test/extension/server/*.jar"
    ),
    "\n"
  )
)
	
      local config

      if vim.fn.has("mac") == 1 then
        config = mason .. "/jdtls/config_mac"
      elseif vim.fn.has("win32") == 1 then
        config = mason .. "/jdtls/config_win"
      else
        config = mason .. "/jdtls/config_linux"
      end

      ----------------------------------------------------------------
      -- Workspace
      ----------------------------------------------------------------

      local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

      local workspace =
        vim.fn.stdpath("data")
        .. "/jdtls-workspace/"
        .. project

      ----------------------------------------------------------------
      -- Root dir
      ----------------------------------------------------------------

      local root =
        require("jdtls.setup").find_root({
          ".git",
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
          "build.gradle.kts",
        })

      if root == "" then
        return
      end

      ----------------------------------------------------------------
      -- Inicia automaticamente
      ----------------------------------------------------------------

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",

        callback = function()

          local config = {

            capabilities = _G.lsp_capabilities,

            cmd = {

              "java",

              "-Declipse.application=org.eclipse.jdt.ls.core.id1",

              "-Dosgi.bundles.defaultStartLevel=4",

              "-Declipse.product=org.eclipse.jdt.ls.core.product",

              "-Dlog.protocol=true",

              "-Dlog.level=ALL",

              "-javaagent:" .. lombok,

              "-Xms1g",

              "--add-modules=ALL-SYSTEM",

              "--add-opens",
              "java.base/java.util=ALL-UNNAMED",

              "--add-opens",
              "java.base/java.lang=ALL-UNNAMED",

              "-jar",
              launcher,

              "-configuration",
              config,

              "-data",
              workspace,
            },

            root_dir = root,

            settings = {
              java = {
                signatureHelp = {
                  enabled = true,
                },

                completion = {
                  favoriteStaticMembers = {
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                  },
                },

                configuration = {
                  runtimes = {},
                },
              },
            },

            init_options = {
              bundles = bundles,
            },

            on_attach = function(client, bufnr)

              jdtls.start_or_attach(config)

		jdtls.setup_dap({
		  hotcodereplace = "auto",
		})

		require("jdtls.dap").setup_dap_main_class_configs()

              local opts = {
                buffer = bufnr,
                silent = true,
              }

              vim.keymap.set(
                "n",
                "<leader>oi",
                jdtls.organize_imports,
                opts
              )

              vim.keymap.set(
                "n",
                "<leader>ev",
                jdtls.extract_variable,
                opts
              )

              vim.keymap.set(
                "v",
                "<leader>ev",
                function()
                  jdtls.extract_variable(true)
                end,
                opts
              )

              vim.keymap.set(
                "n",
                "<leader>ec",
                jdtls.extract_constant,
                opts
              )

              vim.keymap.set(
                "v",
                "<leader>em",
                function()
                  jdtls.extract_method(true)
                end,
                opts
              )
            end,
          }

          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
