return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "rmagatti/auto-session",
      event = "VeryLazy",
      dependencies = {
        "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
      },
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "/Data/Projects", "/Data/Labs", "~/Downloads", "/" },
          auto_restore_enabled = false,

          -- ⚠️ This will only work if Telescope.nvim is installed
          -- The following are already the default values, no need to provide them if these are already the settings you want.
          session_lens = {
            -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
            load_on_setup = true,
            theme_conf = { border = true },
            previewer = false,
            buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session when a new one is loaded
          },
        }
      end,

      keys = function()
        local map = vim.keymap.set
        map(
          "n",
          "<leader>ss",
          require("auto-session.session-lens").search_session,
          { noremap = true, desc = "search session" }
        )
      end,
    }
  end

  return plugin
end
