return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      dependencies = {
        "rcarriga/nvim-notify",
      },
      config = function()
        local options = {
          formatters_by_ft = {
            lua = { "stylua" },
          },

          format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return {
              timeout_ms = 500,
              lsp_fallback = true,
            }
          end,
        }

        require("conform").setup(options)

        -- Show notifications
        local notify = require "notify"
        local function show_notification(message, level)
          notify(message, level, { title = "Conform nvim" })
        end

        vim.api.nvim_create_user_command("FormatToggle", function(args)
          local is_global = not args.bang
          if is_global then
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            if vim.g.disable_autoformat then
              show_notification("Auto format on save disabled globally", "info")
            else
              show_notification("Auto format on save enabled globally", "info")
            end
          else
            vim.b.disable_autoformat = not vim.b.disable_autoformat
            if vim.b.disable_autoformat then
              show_notification("Auto format on save disabled for this buffer", "info")
            else
              show_notification("Auto format on save enabled for this buffer", "info")
            end
          end
        end, { desc = "Toggle auto format on save", bang = true })
      end,
      keys = function()
        local map = vim.keymap.set

        map({ "n", "v" }, "<leader>cf", function()
          require("conform").format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          }
        end, { desc = "format file" })
      end,
    }
  end

  return plugin
end
