return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        {
          "neoclide/jsonc.vim",
        },
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
        },
        {
          "Wansmer/treesj",
          opts = { use_default_keymaps = false },
          keys = function()
            local __Utils = require "utils"
            local map = vim.keymap.set

            map("n", "<leader>cj", __Utils.cmd "TSJToggle", { desc = "Join/split code block" })
          end,
        },
        -- {
        --   "HiPhish/jinja.vim",
        --   -- "Glench/Vim-Jinja2-Syntax",
        -- },
      },
      config = function()
        local options = {
          ensure_installed = {
            "bash",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "toml",
            "vim",
            "vimdoc",
            "yaml",
            "json",
            "python",
            "php_only",
            "blade",
            "javascript",
            "typescript",
            "query",
            "dockerfile",
            "go",
            "make",
            "ini",
            "html",
            "css",
            "scss",
            "vue",
            "git_config",
            "gitignore",
            "ssh_config",
            "rasi",
            "regex",
            "terraform",
            "dot",
          },

          highlight = {
            enable = true,
            use_languagetree = true,
          },

          indent = { enable = true },
          rainbow = { enable = true },
          autotag = { enable = true },

          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<C-space>",
              node_incremental = "<C-space>",
              scope_incremental = false,
              node_decremental = "<bs>",
            },
          },

          textobjects = {
            select = {
              enable = true,

              -- Automatically jump forward to textobj, similar to targets.vim
              lookahead = true,

              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ii"] = "@conditional.inner",
                ["ai"] = "@conditional.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["at"] = "@comment.outer",
              },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outerii"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        }

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade",
        }
        require("nvim-treesitter.configs").setup(options)
      end,
    }
  end

  return plugin
end
