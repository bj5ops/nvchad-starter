return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        {
          "rcarriga/nvim-notify",
          config = function()
            require("notify").setup {
              background_colour = "#1B2224",
              minimum_width = 50,
              maximum_width = 50,
              stages = "fade_in_slide_out",
              timeout = 3000,
            }
          end,
        },
      },
      config = function()
        require("noice").setup {
          lsp = {
            override = {
              -- override the default lsp markdown formatter with Noice
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              -- override the lsp markdown formatter with Noice
              ["vim.lsp.util.stylize_markdown"] = true,
              -- override cmp documentation with Noice (needs the other options to work)
              ["cmp.entry.get_documentation"] = true,
            },
            signature = {
              enabled = false,
            },
            hover = {
              enabled = true,
            },
          },
          presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
          views = {
            cmdline_popup = {
              position = {
                row = 5,
                col = "50%",
              },
              border = {
                style = "single",
                padding = { 0, 1 },
              },
              size = {
                min_width = 70,
                width = 70,
                height = "auto",
              },
            },
            cmdline_popupmenu = {
              relative = "editor",
              position = {
                row = 7,
                col = "50%",
              },
              size = {
                width = 70,
                height = "auto",
                max_height = 12,
              },
              border = {
                style = "single",
                padding = { 0, 1 },
              },
            },
          },
        }
      end,
      keys = function()
        local map = vim.keymap.set

        map("n", "<leader>na", function()
          require("noice").cmd "all"
        end, { desc = "noice cmd all" })
        map("n", "<leader>nl", function()
          require("noice").cmd "last"
        end, { desc = "noice cmd last" })
        map("n", "<leader>nh", function()
          require("noice").cmd "history"
        end, { desc = "noice cmd history" })
        map("n", "<leader>nx", function()
          require("noice").cmd "dismiss"
        end, { desc = "noice cmd dismiss" })
      end,
    }
  end

  return plugin
end
