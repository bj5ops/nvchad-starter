return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "akinsho/toggleterm.nvim",
      version = "*",
      event = "VeryLazy",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        {
          "ryanmsnyder/toggleterm-manager.nvim",
          event = "TermOpen",
          config = function()
            local map = vim.keymap.set
            local __Utils = require "utils"

            local toggleterm_manager = require "toggleterm-manager"
            local actions = toggleterm_manager.actions

            toggleterm_manager.setup {
              mappings = { -- key mappings bound inside the telescope window
                i = {
                  ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
                  ["<C-i>"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
                  ["<C-d>"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
                  ["<C-r>"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
                },
                n = {
                  ["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
                  ["x"] = { action = actions.delete_term, exit_on_action = false },
                },
              },
              titles = {
                preview = "Preview", -- title of the preview buffer in telescope
                prompt = " Terminals", -- title of the prompt buffer in telescope
                results = "Results", -- title of the results buffer in telescope
              },
              results = {
                fields = { -- fields that will appear in the results of the telescope window
                  "state", -- the state of the terminal buffer: h = hidden, a = active
                  "space", -- adds space between fields, if desired
                  "term_icon", -- a terminal icon
                  "term_name", -- toggleterm's display_name if it exists, else the terminal's id assigned by toggleterm
                },
                separator = " ", -- the character that will be used to separate each field provided in results.fields
                term_icon = "", -- the icon that will be used for term_icon in results.fields
              },
              search = {
                field = "term_name", -- the field that telescope fuzzy search will use when typing in the prompt
              },
              sort = {
                field = "term_name", -- the field that will be used for sorting in the telesocpe results
                ascending = true, -- whether or not the field provided above will be sorted in ascending or descending order
              },
            }

            map(
              { "n", "t" },
              "<leader>tt",
              __Utils.cmd "Telescope toggleterm_manager",
              { desc = "telescope toggleterm" }
            )
          end,
        },
      },
      config = function()
        local options = {
          size = 20,
          open_mapping = [[<c-\>]],
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = "float",
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = "single",
            winblend = 0,
            highlights = {
              border = "#16A085",
              background = "Normal",
            },
            FloatBorder = {
              guifg = "#16A085",
              -- guibg = "#16A085",
            },
          },
        }

        require("toggleterm").setup(options)
      end,
      keys = function()
        local map = vim.keymap.set
        local __Utils = require "utils"
        local opts = { noremap = true, silent = true }

        function _G.set_terminal_keymaps()
          local opts = { noremap = true }
          vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
          -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
          vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
          vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
          vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
          vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new { cmd = "lazygit", hidden = true, direction = "float" }
        function _LAZYGIT_TOGGLE()
          lazygit:toggle()
        end

        local node = Terminal:new { cmd = "node", hidden = true }
        function _NODE_TOGGLE()
          node:toggle()
        end

        local python = Terminal:new { cmd = "python3", hidden = true }
        function _PYTHON_TOGGLE()
          python:toggle()
        end

        local btop = Terminal:new { cmd = "btop", hidden = true, direction = "float" }
        function _BTOP_TOGGLE()
          btop:toggle()
        end

        map("n", "<leader>tl", "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "terminal lazygit" })
        map("n", "<leader>tn ", "<Cmd>lua _HTOP_TOGGLE()<CR>", { desc = "terminal node" })
        map("n", "<leader>tp", "<Cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "terminal python" })
        map("n", "<leader>tb", "<Cmd>lua _BTOP_TOGGLE()<CR>", { desc = "terminal btop" })
        map({ "n", "t" }, "<A-`>", __Utils.cmd "ToggleTerm direction=float", opts)
        map(
          { "n", "t" },
          "<leader>tt",
          __Utils.cmd "ToggleTerm direction=float",
          { desc = "terminal float", noremap = true }
        )
        map({ "n", "t" }, "<A-t>", __Utils.cmd "ToggleTerm direction=float", opts)
        -- map("i", "<C-//>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", { desc = "terminal horizontal" })
        -- map("n", "<C-//>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", { desc = "terminal horizontal" })
        -- map({ "n", "t" }, "<A-h>", __Utils.cmd "ToggleTerm size=20 direction=horizontal", { desc = "terminal horizontal" })
        -- map({ "n", "t" }, "<A-v>", __Utils.cmd "ToggleTerm size=80 direction=vertical", { desc = "terminal vertical" })
      end,
    }
  end

  return plugin
end
