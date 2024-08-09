return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "gbprod/substitute.nvim",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        local substitute = require "substitute"

        substitute.operator {
          count = 1, -- number of substitutions
          register = "a", -- register used for substitution
          motion = "iw", -- only available for `operator`, this will automatically use
          modifiers = nil, -- modifiers used for substitution
        }
        substitute.setup()
      end,

      keys = function()
        local map = vim.keymap.set

        map("n", "s", require("substitute").operator, { noremap = true })
        map("n", "ss", require("substitute").line, { noremap = true })
        map("n", "S", require("substitute").eol, { noremap = true })
        map("x", "s", require("substitute").visual, { noremap = true })
      end,
    }
  end

  return plugin
end
