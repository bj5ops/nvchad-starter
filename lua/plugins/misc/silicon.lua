return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "michaelrommel/nvim-silicon",
      lazy = true,
      cmd = "Silicon",
      config = function()
        local silicon = require "silicon"
        silicon.setup {
          theme = "Nord",
          background = "#16A085",
          font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
          output = function()
            return os.getenv "HOME" .. "/Screenshots/" .. os.date "!%Y-%m-%dT%H-%M-%SZ" .. "_code.png"
          end,
          window_title = function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
          end,
        }
      end,
      keys = function()
        local map = vim.keymap.set

        map("v", "<leader>ss", function()
          require("nvim-silicon").shoot()
        end, { desc = "screenshot code" })
        map("v", "<leader>sf", function()
          require("nvim-silicon").file()
        end, { desc = "screenshot save as file" })
        map("v", "<leader>sc", function()
          require("nvim-silicon").clip()
        end, { desc = "screenshot copy to clipboard" })
      end,
    }
  end

  return plugin
end
