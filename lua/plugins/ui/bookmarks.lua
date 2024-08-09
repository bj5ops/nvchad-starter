return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "tomasky/bookmarks.nvim",
      -- after = "telescope.nvim",
      event = "VimEnter",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("bookmarks").setup {
          -- sign_priority = 8,  --set bookmark sign priority to cover other sign
          save_file = vim.fn.stdpath "data" .. "/bookmarks", -- bookmarks save file path
          keywords = {
            ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
            ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
            ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
            ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
          },
          on_attach = function(bufnr)
            local bm = require "bookmarks"
            local map = vim.keymap.set
            map("n", "<leader>mm", bm.bookmark_toggle, { desc = "bookmark toggle" }) -- add or remove bookmark at current line
            map("n", "<leader>mi", bm.bookmark_ann, { desc = "bookmark add" }) -- add or edit mark annotation at current line
            map("n", "<leader>mc", bm.bookmark_clean, { desc = "bookmark clean" }) -- clean all marks in local buffer
            map("n", "<leader>mn", bm.bookmark_next, { desc = "bookmark next" }) -- jump to next mark in local buffer
            map("n", "<leader>mp", bm.bookmark_prev, { desc = "bookmark prev" }) -- jump to previous mark in local buffer
            map("n", "<leader>ml", bm.bookmark_list, { desc = "bookmark list" }) -- show marked file list in quickfix window
            map("n", "<leader>mx", bm.bookmark_clear_all, { desc = "bookmark clear all" }) -- removes all bookmarks
          end,
        }

        require("telescope").load_extension "bookmarks"
      end,
    }
  end

  return plugin
end
