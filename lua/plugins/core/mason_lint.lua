return function(activate)
  local plugin = {
    "rshkarin/mason-nvim-lint",
    enabled = false,
  }

  if activate then
    plugin = {
      "rshkarin/mason-nvim-lint",
      event = "VeryLazy",
      dependencies = { "nvim-lint" },
      config = function()
        local __Utils = require "utils"
        local lint = package.loaded["lint"]

        -- List of linters to ignore during install
        local ignore_install = {}

        -- Build a list of linters to install minus the ignored list.
        local all_linters = {}

        -- Add all linters_by_ft
        for _, v in pairs(lint.linters_by_ft) do
          for _, linter in ipairs(v) do
            if not __Utils.TableContents(ignore_install, linter) then
              table.insert(all_linters, linter)
            end
          end
        end

        require("mason-nvim-lint").setup {
          ensure_installed = all_linters,
          automatic_installation = false,
        }
      end,
    }
  end

  return plugin
end
