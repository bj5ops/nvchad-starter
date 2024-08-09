return function(activate)
  local plugin = {}

  if activate then
    plugin = {
      "editorconfig/editorconfig-vim",
      ft = { "editorconfig" },
      event = { "BufReadPost", "BufNewFile" },
    }
  end

  return plugin
end
