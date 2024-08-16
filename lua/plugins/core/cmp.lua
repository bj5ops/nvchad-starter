return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          dependencies = {
            "rafamadriz/friendly-snippets",
          },
          opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
          },
          config = function(_, opts)
            require("luasnip").config.set_config(opts)
            require("luasnip.loaders.from_vscode").lazy_load()
            require "nvchad.configs.luasnip"
          end,
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji",
        "Exafunction/codeium.nvim",
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          dependencies = {
            "Bilal2453/luvit-meta",
            lazy = true,
          },
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "luvit-meta/library", words = { "vim%.uv" } },
              { path = "lazy.nvim", words = { "LazyVim" } },
            },
          },
        },
      },
      opts = function()
        local cmp_ui = require("nvconfig").ui.cmp
        local cmp_style = cmp_ui.style
        local config = require "nvchad.configs.cmp"
        local function border(hl_name)
          return {
            { "┌", hl_name },
            { "─", hl_name },
            { "┐", hl_name },
            { "│", hl_name },
            { "┘", hl_name },
            { "─", hl_name },
            { "└", hl_name },
            { "│", hl_name },
          }
        end

        config.sources = {
          { name = "codeium" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "emoji" },
          {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
        }

        if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
          config.window.completion.border = border "CmpBorder"
          config.window.documentation.border = border "CmpBorder" -- default border "CmpDocBorder"
        end
      end,
    }
  end

  return plugin
end
