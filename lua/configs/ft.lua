vim.filetype.add {
  -- Detect and assign filetype based on the extension of the filename
  extension = {
    env = "conf",
    conf = "conf",
    log = "log",
    zsh = "sh",
    sh = "sh",
    php = "php",
  },
  -- Detect and apply filetypes based on the entire filename
  filename = {
    [".env"] = "conf",
    ["env"] = "conf",
    [".zshrc"] = "sh",
    [".zshenv"] = "sh",
    ["hcl"] = "terraform",
  },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    ["%.env%.(%a+)"] = function(path, bunfr, ext)
      -- vim.print(ext)
      if vim.tbl_contains({ "local", "example", "dev", "staging", "prod" }, ext) then
        return "conf"
      end
    end,
    ["configs.json%.(%a+)"] = function(path, bunfr, ext)
      -- vim.print(ext)
      if vim.tbl_contains({ "local", "example", "dev", "staging", "prod" }, ext) then
        return "json"
      end
    end,
    [".*%.blade%.php"] = "blade",
  },
}
