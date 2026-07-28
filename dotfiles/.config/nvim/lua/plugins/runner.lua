return {
  {
    "CRAG666/code_runner.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      require("code_runner").setup({
        mode = "term",

        filetype = {
          javascript = "node",
          typescript = "node",
          python = "python3 -u",

          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",

          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",

          cpp = "cd $dir && g++ $fileName -std=c++20 -o $fileNameWithoutExt && ./$fileNameWithoutExt",

          lua = "lua",
          sh = "bash",
        },
      })

      vim.keymap.set("n", "<F5>", "<cmd>RunCode<CR>", {
        silent = true,
        desc = "Executar arquivo atual",
      })
    end,
  },
}
