return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      conf = function()
        -- vim.g.tmux_navigator_no_mappings = 1
        local nvim_tmux_nav = require "nvim-tmux-navigator"

        nvim_tmux_nav.setup {
          disable_when_zoomed = true,
        }
      end,
      keys = function()
        local __Util = require "utils"
        local map = vim.keymap.set

        map("n", "<C-h>", __Util.cmd "<C-U>TmuxNavigateLeft", { noremap = true })
        map("n", "<C-j>", __Util.cmd "<C-U>TmuxNavigateDown", { noremap = true })
        map("n", "<C-k>", __Util.cmd "<C-U>TmuxNavigateUp", { noremap = true })
        map("n", "<C-l>", __Util.cmd "<C-U>TmuxNavigateRight", { noremap = true })
        map("n", "<C-\\>", __Util.cmd "<C-U>TmuxNavigatePrevious", { noremap = true })
      end,
    }
  end

  return plugin
end
