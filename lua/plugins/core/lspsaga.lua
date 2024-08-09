return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "nvimdev/lspsaga.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("lspsaga").setup {
          lightbulb = {
            enable = false,
          },
        }
      end,
      keys = function()
        local __Utils = require "utils"
        local map = vim.keymap.set

        map("n", "<leader>lc", __Utils.cmd "Lspsaga code_action", { desc = "lsp code action" })
        map("n", "<leader>lr", __Utils.cmd "Lspsaga rename", { desc = "lsp rename" })
        map("n", "<leader>lf", __Utils.cmd "Lspsaga finder", { desc = "lsp finder" })
        map("n", "<leader>lo", __Utils.cmd "Lspsaga outline", { desc = "lsp outline" })
        map("n", "<leader>ld", __Utils.cmd "Lspsaga goto_definition", { desc = "lsp goto definition" })
        map("n", "<leader>lp", __Utils.cmd "Lspsaga preview_definition", { desc = "lsp preview definition" })
        map("n", "<leader>ls", __Utils.cmd "Lspsaga signature_help", { desc = "lsp signature help" })
        map("n", "<leader>lw", __Utils.cmd "Lspsaga show_workspace_diagnostics", { desc = "lsp workspace diagnostics" })
      end,
    }
  end

  return plugin
end
