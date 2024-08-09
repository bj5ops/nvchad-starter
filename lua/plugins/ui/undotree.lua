return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "mbbill/undotree",
      event = "VeryLazy",
      keys = function()
        local __Utils = require "utils"
        local map = vim.keymap.set

        map("n", "<leader><F5>", __Utils.cmd "UndotreeToggle", { desc = "undotree" })
      end,
    }
  end

  return plugin
end
