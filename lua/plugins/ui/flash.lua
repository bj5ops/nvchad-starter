return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "folke/flash.nvim",
      event = "VeryLazy",
      vscode = true,
      opts = function()
        local options = {
          jump = { nohlsearch = true },
          prompt = {
            -- Place the prompt above the statusline.
            win_config = { row = -3 },
          },
          search = {
            exclude = {
              "cmp_menu",
              "flash_prompt",
              "qf",
              function(win)
                -- Floating windows from bqf.
                if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match "BqfPreview" then
                  return true
                end

                -- Non-focusable windows.
                return not vim.api.nvim_win_get_config(win).focusable
              end,
            },
          },
        }

        return options
      end,
      keys = function()
        -- local __Utils = require "utils"
        local map = vim.keymap.set

        map({ "n", "x", "o" }, "<leader>ks", function()
          require("flash").jump()
        end, { desc = "flash" })

        map({ "n", "x", "o" }, "<leader>kS", function()
          require("flash").treesitter()
        end, { desc = "flash treesitter" })

        map({ "n", "x", "o" }, "<leader>kR", function()
          require("flash").remote()
        end, { desc = "flash remote" })

        map({ "n", "x", "o" }, "<leader>kk", function()
          require("flash").toggle()
        end, { desc = "flash toggle" })

        map({ "n", "x", "o" }, "<leader>ke", function()
          require("flash").edit()
        end, { desc = "edit flash" })
      end,
    }
  end

  return plugin
end
