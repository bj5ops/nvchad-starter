-- Load environment variables for activation plugins
local env = require "configs.env"

-- Load plugins
return {
  -- Core plugins
  require "plugins.core.ai"(env.ai),
  require "plugins.core.cmp"(env.cmp),
  require "plugins.core.treesitter"(env.treesitter),
  require "plugins.core.gitsigns"(env.gitsigns),
  require "plugins.core.lspconfig"(env.lspconfig),
  require "plugins.core.mason_lspconfig"(env.mason_lspconfig),
  require "plugins.core.lint"(env.lint),
  require "plugins.core.mason_lint"(env.mason_lint),
  require "plugins.core.conform"(env.conform),
  require "plugins.core.mason_conform"(env.mason_conform),
  require "plugins.core.telescope"(env.telescope),
  require "plugins.core.lspsaga"(env.lspsaga),
  require "plugins.core.toggleterm"(env.toggleterm),
  require "plugins.core.yanky"(env.yanky),

  -- UI plugins
  require "plugins.ui.nvim_tree"(env.nvim_tree),
  require "plugins.ui.dressing"(env.dressing),
  require "plugins.ui.noice"(env.noice),
  require "plugins.ui.neoscroll"(env.neoscroll),
  require "plugins.ui.quit"(env.quite),
  require "plugins.ui.fold"(env.fold),
  require "plugins.ui.highlighturl"(env.highlighturl),
  require "plugins.ui.indent_blankline"(env.indent_blankline),
  require "plugins.ui.flash"(env.flash),
  require "plugins.ui.visual_multi"(env.visual_multi),
  require "plugins.ui.bookmarks"(env.bookmarks),
  require "plugins.ui.todo_comments"(env.todo_comments),
  require "plugins.ui.trouble"(env.trouble),
  require "plugins.ui.undotree"(env.undotree),

  -- Misc plugins
  require "plugins.misc.comment"(env.comment),
  require "plugins.misc.editorconfig"(env.editorconfig),
  require "plugins.misc.boole"(env.booole),
  require "plugins.misc.case_change"(env.case_change),
  require "plugins.misc.move"(env.move),
  require "plugins.misc.duplicate"(env.duplicate),
  require "plugins.misc.dotenv"(env.dotenv),
  require "plugins.misc.illuminate"(env.illuminate),
  require "plugins.misc.surround"(env.surround),
  require "plugins.misc.spectre"(env.spectre),
  require "plugins.misc.vim_tmux"(env.vim_tmux),
  require "plugins.misc.vim_maximizer"(env.vim_maximizer),
  require "plugins.misc.session"(env.session),
  require "plugins.misc.rename"(env.rename),
  require "plugins.misc.silicon"(env.silicon),
}
