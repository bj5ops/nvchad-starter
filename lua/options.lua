require "nvchad.options"

vim.scriptencoding = "utf-8"

local opt = vim.opt
local o = vim.o

-- Numbers
o.number = true
o.relativenumber = true

-- search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Misc
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.cmdheight = 0
opt.wildignore:append {
  "*.o",
  "*.obj,*~",
  "*.git*",
  "*.meteor*",
  "*vim/backups*",
  "*sass-cache*",
  "*mypy_cache*",
  "*__pycache__*",
  "*cache*",
  "*logs*",
  "*node_modules*",
  "**/node_modules/**",
  "*DS_Store*",
  "*.gem",
  "log/**",
  "tmp/**",
  "*package-lock.json*",
  "**/dist/**",
  "**/.next/**",
  "**/.nx/**",
  "*vendor*",
  "**/vendor/**",
}

-- o.cursorlineopt ='both' -- to enable cursorline!
