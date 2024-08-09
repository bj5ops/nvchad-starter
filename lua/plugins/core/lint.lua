return function(activate)
  local plugin = {
    "mfussenegger/nvim-lint",
    enabled = false,
  }

  if activate then
    plugin = {
      "mfussenegger/nvim-lint",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
          lua = { "luacheck" },
          bash = { "shellcheck" },
          sh = { "shellcheck" },
          yaml = { "yamllint" },
          json = { "jsonlint" },
          markdown = { "markdownlint" },
          ansible = { "ansible-lint" },
          python = { "pylint" },
          dockerfile = { "hadolint" },
          toml = { "taplo" },
          php = {},
          terraform = { "tflint" },
          zsh = { "shellcheck" },
        }

        lint.linters.luacheck.args = {
          "--globals",
          "vim",
          "--formatter",
          "plain",
          "--codes",
          "--ranges",
          "-",
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          callback = function()
            lint.try_lint()
          end,
        })
      end,
    }
  end

  return plugin
end
