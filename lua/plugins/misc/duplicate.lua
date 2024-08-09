return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "hinell/duplicate.nvim",
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "LineDuplicate", "VisualDuplicate" },
      config = function()
        vim.g["duplicate-nvim-config"] = {
          visual = {
            selectAfter = true, -- true to select duplicated text
            block = true, -- true to enable block-wise duplication
          },
        }
      end,
      keys = function()
        local Utils = require "utils"
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        -- map("n", "<C-A-Up>", Utils.cmd "LineDuplicate -1", opts)
        map("n", "<C-A-k>", Utils.cmd "LineDuplicate -1", opts)
        -- map("n", "<C-A-Down>", Utils.cmd "LineDuplicate +1", opts)
        map("n", "<C-A-j>", Utils.cmd "LineDuplicate +1", opts)
        -- map("v", "<C-A-Up>", Utils.cmd "VisualDuplicate -1", opts)
        map("v", "<C-A-k>", Utils.cmd "VisualDuplicate -1", opts)
        -- map("v", "<C-A-Down>", Utils.cmd "VisualDuplicate +1", opts)
        map("v", "<C-A-j>", Utils.cmd "VisualDuplicate +1", opts)
      end,
    }
  end

  return plugin
end
