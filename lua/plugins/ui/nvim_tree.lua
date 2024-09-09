return function(activate)
  local plugin = {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  }

  if activate then
    plugin = {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle", "NvimTreeRefresh", "NvimTreeCollapse" },
      config = function()
        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local HEIGHT_RATIO = 0.8 -- You can change this
        local WIDTH_RATIO = 0.3 -- You can change this too

        local tree_api = require "nvim-tree"
        local tree_view = require "nvim-tree.view"

        local function my_on_attach(bufnr)
          local api = require "nvim-tree.api"

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- custom mappings
          vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts "Up")
          vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
        end

        vim.api.nvim_create_augroup("NvimTreeResize", {
          clear = true,
        })

        vim.api.nvim_create_autocmd({ "VimResized" }, {
          group = "NvimTreeResize",
          callback = function()
            if tree_view.is_visible() then
              tree_view.close()
              tree_api.open()
            end
          end,
        })

        local view_float_enable = false

        local options = {
          disable_netrw = true,
          hijack_netrw = true,
          hijack_cursor = true,
          hijack_unnamed_buffer_when_opening = false,
          sync_root_with_cwd = true,
          respect_buf_cwd = true,
          auto_reload_on_write = true,
          update_focused_file = {
            enable = true,
            update_root = false,
          },
          view = {
            adaptive_size = false,
            side = "left",
            preserve_window_proportions = true,
            float = {
              enable = false,
              open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                return {
                  border = "single",
                  relative = "editor",
                  row = center_y,
                  col = center_x,
                  width = window_w_int,
                  height = window_h_int,
                }
              end,
            },
            width = function()
              local wd = 35
              if view_float_enable then
                wd = math.floor(vim.opt.columns:get() * WIDTH_RATIO)
              end
              return wd
            end,
          },
          git = {
            enable = true,
            ignore = false,
          },
          filesystem_watchers = {
            enable = true,
          },
          actions = {
            open_file = {
              resize_window = false,
              window_picker = {
                enable = false,
              },
              -- quit_on_open = true,
            },
          },
          renderer = {
            root_folder_label = false,
            highlight_git = true,
            highlight_opened_files = "none",

            indent_markers = {
              enable = true,
            },

            icons = {
              show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
              },

              glyphs = {
                default = "󰈚",
                symlink = "",
                folder = {
                  default = "",
                  empty = "",
                  empty_open = "",
                  open = "",
                  symlink = "",
                  symlink_open = "",
                  arrow_open = "",
                  arrow_closed = "",
                },
                git = {
                  unstaged = "✗",
                  staged = "✓",
                  unmerged = "",
                  renamed = "➜",
                  untracked = "★",
                  deleted = "",
                  ignored = "◌",
                },
              },
            },
          },
          filters = {
            custom = {
              "\\.git$",
              "\\.DS_Store$",
              "\\.Trash$",
              "\\node_modules$",
              "\\vendor$",
              "\\.vscode$",
              "\\.idea$",
            },
            exclude = {
              "\\.make$",
              "\\.data$",
              "^.env",
              "\\.output$",
              "\\.nuxt$",
            },
          },
          trash = {
            cmd = "trash",
            require_confirm = true,
          },
          on_attach = my_on_attach,
        }

        tree_api.setup(options)
      end,
      keys = function()
        local __Utils = require "utils"
        local map = vim.keymap.set

        map("n", "<leader>ee", __Utils.cmd "NvimTreeToggle", { desc = "nvimtree toggle file explorer" })
        map("n", "<leader>ef", __Utils.cmd "NvimTreeFocus", { desc = "nvimtree focus file explorer" })
        map(
          "n",
          "<leader>es",
          __Utils.cmd "NvimTreeFindFileToggle",
          { desc = "nvimtree toggle file explorer on current file" }
        )
        map("n", "<leader>ec", __Utils.cmd "NvimTreeCollapse", { desc = "nvimtree collapse file explorer" })
        map("n", "<leader>er", __Utils.cmd "NvimTreeRefresh", { desc = "nvimtree refresh file explorer" })
      end,
    }
  end

  return plugin
end
