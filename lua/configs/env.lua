local __Dotenv = require "utils.dotenv"

local M = {}

-- Buffer number
M.stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

-- User interface
M.transparency = __Dotenv.env("BASE_TRANSPARENCY", "boolean")
M.theme = __Dotenv.env("BASE_THEME", "string")

-- Core activation plugins
M.ai = __Dotenv.env("PLUGIN_CORE_AI", "boolean")
M.cmp = __Dotenv.env("PLUGIN_CORE_CMP", "boolean")
M.treesitter = __Dotenv.env("PLUGIN_CORE_TREESITTER", "boolean")
M.gitsigns = __Dotenv.env("PLUGIN_CORE_GITSIGNS", "boolean")
M.lspconfig = __Dotenv.env("PLUGIN_CORE_LSPCONFIG", "boolean")
M.mason_lspconfig = __Dotenv.env("PLUGIN_CORE_MASON_LSPCONFIG", "boolean")
M.lint = __Dotenv.env("PLUGIN_CORE_LINT", "boolean")
M.mason_lint = __Dotenv.env("PLUGIN_CORE_MASON_LINT", "boolean")
M.conform = __Dotenv.env("PLUGIN_CORE_CONFORM", "boolean")
M.mason_conform = __Dotenv.env("PLUGIN_CORE_MASON_CONFORM", "boolean")
M.telescope = __Dotenv.env("PLUGIN_CORE_TELESCOPE", "boolean")
M.lspsaga = __Dotenv.env("PLUGIN_CORE_LSPSAGA", "boolean")
M.toggleterm = __Dotenv.env("PLUGIN_CORE_TOGGLETERM", "boolean")
M.yanky = __Dotenv.env("PLUGIN_CORE_YANKY", "boolean")

-- UI activation plugins
M.nvim_tree = __Dotenv.env("PLUGIN_UI_NVIMTREE", "boolean")
M.dressing = __Dotenv.env("PLUGIN_UI_DRESSING", "boolean")
M.noice = __Dotenv.env("PLUGIN_UI_NOICE", "boolean")
M.neoscroll = __Dotenv.env("PLUGIN_UI_NEOSCROLL", "boolean")
M.quite = __Dotenv.env("PLUGIN_UI_QUITE", "boolean")
M.fold = __Dotenv.env("PLUGIN_UI_FOLD", "boolean")
M.highlighturl = __Dotenv.env("PLUGIN_UI_HIGHLIGHTURL", "boolean")
M.indent_blankline = __Dotenv.env("PLUGIN_UI_INDENT_BLANKLINE", "boolean")
M.flash = __Dotenv.env("PLUGIN_UI_FLASH", "boolean")
M.visual_multi = __Dotenv.env("PLUGIN_UI_VISUAL_MULTI", "boolean")
M.bookmarks = __Dotenv.env("PLUGIN_UI_BOOKMARKS", "boolean")
M.todo_comments = __Dotenv.env("PLUGIN_UI_TODO_COMMENTS", "boolean")
M.trouble = __Dotenv.env("PLUGIN_UI_TROUBLE", "boolean")
M.undotree = __Dotenv.env("PLUGIN_UI_UNDOTREE", "boolean")

-- Misc activation plugins
M.comment = __Dotenv.env("PLUGIN_MISC_COMMENT", "boolean")
M.editorconfig = __Dotenv.env("PLUGIN_MISC_EDITORCONFIG", "boolean")
M.booole = __Dotenv.env("PLUGIN_MISC_BOOLE", "boolean")
M.case_change = __Dotenv.env("PLUGIN_MISC_CASE_CHANGE", "boolean")
M.move = __Dotenv.env("PLUGIN_MISC_MOVE", "boolean")
M.duplicate = __Dotenv.env("PLUGIN_MISC_DUPLICATE", "boolean")
M.dotenv = __Dotenv.env("PLUGIN_MISC_DOTENV", "boolean")
M.illuminate = __Dotenv.env("PLUGIN_MISC_ILLUMINATE", "boolean")
M.surround = __Dotenv.env("PLUGIN_MISC_SURROUND", "boolean")
M.spectre = __Dotenv.env("PLUGIN_MISC_SPECTRE", "boolean")
M.vim_tmux = __Dotenv.env("PLUGIN_MISC_VIM_TMUX", "boolean")
M.session = __Dotenv.env("PLUGIN_MISC_SESSION", "boolean")
M.rename = __Dotenv.env("PLUGIN_MISC_RENAME", "boolean")
M.silicon = __Dotenv.env("PLUGIN_MISC_SILICON", "boolean")

return M
