return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      config = function()
        require("codeium").setup {
          bin_path = vim.fn.stdpath "data" .. "/codeium/bin",
          config_path = vim.fn.stdpath "data" .. "/codeium/config.json",
          enable_chat = true,
        }
      end,
      keys = function()
        local map = vim.keymap.set

        map("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        map("i", "<C-;>", function()
          return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true })
        map("i", "<C-,>", function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true })
        map("i", "<C-x>", function()
          return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true })
      end,
    }
  end

  return plugin
end
