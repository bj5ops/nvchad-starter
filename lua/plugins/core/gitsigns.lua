return function(activate)
  local plugin = {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  }

  if activate then
    plugin = {
      "lewis6991/gitsigns.nvim",
      event = "User FilePost",
      config = function()
        local gitsigns = require "gitsigns"

        local options = {
          signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "󰍵" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "│" },
          },

          current_line_blame = true,

          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
              if vim.wo.diff then
                vim.cmd.normal { "]c", bang = true }
              else
                gs.nav_hunk "next"
              end
            end)

            map("n", "[c", function()
              if vim.wo.diff then
                vim.cmd.normal { "[c", bang = true }
              else
                gs.nav_hunk "prev"
              end
            end)

            -- Actions
            map("n", "<leader>hs", gs.stage_hunk, { desc = "gitsigns stage hunk" })
            map("n", "<leader>hr", gs.reset_hunk, { desc = "gitsigns reset hunk" })
            map("v", "<leader>hs", function()
              gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
            end, { desc = "gitsigns stage hunk" })
            map("v", "<leader>hr", function()
              gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
            end, { desc = "gitsigns reset hunk" })
            map("n", "<leader>hS", gs.stage_buffer, { desc = "gitsigns stage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "gitsigns undo stage hunk" })
            map("n", "<leader>hR", gs.reset_buffer, { desc = "gitsigns reset buffer" })
            map("n", "<leader>hp", gs.preview_hunk, { desc = "gitsigns preview hunk" })
            map("n", "<leader>hb", function()
              gs.blame_line { full = true }
            end, { desc = "gitsigns blame line full" })
            map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "gitsigns blame line toggle" })
            map("n", "<leader>htd", gs.toggle_deleted, { desc = "gitsigns deleted toggle" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "gitsigns select hunk" })
          end,
        }

        gitsigns.setup(options)
      end,
    }
  end

  return plugin
end
