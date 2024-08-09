return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "tpope/vim-dotenv",
      event = { "VeryLazy" },
    }
  end

  return plugin
end
