return function(activate)
  local config = {}

  if activate then
    config = {
      "orhnk/vim-case-change",
      event = { "BufReadPost", "BufNewFile" },
      keys = function()
        local Utils = require "utils"
        local map = vim.keymap.set

        vim.g.casechange_nomap = 1

        map("v", "<M-S>", Utils.cmd "ToggleCase", { desc = "case change" })
        map({ "i", "n" }, "<M-S>", "<ESC>viw<CMD>ToggleCase<CR>", { desc = "case change" })
      end,
    }
  end

  return config
end
