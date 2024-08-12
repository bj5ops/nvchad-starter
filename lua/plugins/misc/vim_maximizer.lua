return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "szw/vim-maximizer",
      keys = {
        { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "maximize/minimize a split" },
      },
    }
  end

  return plugin
end
