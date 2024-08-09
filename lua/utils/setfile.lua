local M = {}

-- Function to set filetype
-- @param patterns table
-- @param ft string
-- @return vim set filetype
M.type = function(patterns, ft)
  assert(type(patterns) == "table", "patterns must be a table")
  assert(type(ft) == "string", "ft must be a string")
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = patterns,
    group = vim.api.nvim_create_augroup("setFiletype", {}),
    command = "set filetype=" .. ft,
  })
end

return M
