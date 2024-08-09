return function(activate)
  local plugin = {
    "zapling/mason-conform.nvim",
    enabled = false,
  }

  if activate then
    plugin = {
      "zapling/mason-conform.nvim",
      event = "VeryLazy",
      dependencies = { "conform.nvim" },
      config = function()
        local mason_conform = require "mason-conform"

        mason_conform.setup {
          -- List of formatters to ignore during install
          ignore_install = {},
        }
      end,
    }
  end

  return plugin
end
