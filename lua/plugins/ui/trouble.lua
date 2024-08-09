return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "folke/trouble.nvim",
      cmd = "Trouble",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
      },
      opts = {
        modes = {
          lsp = {
            win = { position = "right" },
          },
        },
      },
      keys = function()
        local __Utils = require "utils"
        local map = vim.keymap.set

        map("n", "<leader>xx", __Utils.cmd "Trouble diagnostics toggle", { desc = "diagnostics (trouble)" })
        map(
          "n",
          "<leader>xX",
          __Utils.cmd "Trouble diagnostics toggle filter.buf=0",
          { desc = "buffer diagnostics (trouble)" }
        )
        map("n", "<leader>cs", __Utils.cmd "Trouble symbols toggle", { desc = "symbols (trouble)" })
        map(
          "n",
          "<leader>cS",
          __Utils.cmd "TroubleToggle lsp toggle",
          { desc = "LSP definitions/declarations/... (trouble)" }
        )
        map("n", "<leader>xL", __Utils.cmd "Trouble loclist toggle", { desc = "location tist (trouble)" })
        map("n", "<leader>xQ", __Utils.cmd "Trouble qflist toggle", { desc = "quickfix tist (trouble)" })
        map("n", "[q", function()
          if require("lua.plugins.ui.trouble").is_open() then
            require("lua.plugins.ui.trouble").prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end, { desc = "previous trouble/quickfix item" })
        map("n", "]q", function()
          if require("lua.plugins.ui.trouble").is_open() then
            require("lua.plugins.ui.trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end, { desc = "next trouble/quickfix item" })
      end,
    }
  end

  return plugin
end
