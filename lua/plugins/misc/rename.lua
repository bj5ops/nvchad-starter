return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "smjonas/inc-rename.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      config = function()
        require("inc_rename").setup {
          input_buffer_type = "dressing",
        }

        vim.keymap.set("n", "<leader>rn", function()
          return ":IncRename " .. vim.fn.expand "<cword>"
        end, { desc = "increment rename", expr = true })
      end,
    }
  end

  return plugin
end
