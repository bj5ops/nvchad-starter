return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "nat-418/boole.nvim",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("boole").setup {
          mappings = {
            increment = "<C-a>",
            decrement = "<C-x>",
          },
        }
      end,
    }
  end

  return plugin
end
