-- vim autocmd
local autocmd = vim.api.nvim_create_autocmd

-- [[ Set spacing on startup kitty ]]
autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})
autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

-- [[ Return to last edit position when opening files ]]
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Open Nvdash on close all buffers ]]
autocmd({ "BufEnter", "BufDelete", "FileType" }, {
  callback = function(args)
    if args.event == "FileType" then
      vim.o.showtabline = vim.bo.ft == "nvdash" and 0 or 2
      return
    end

    local buf = args.buf

    if not vim.bo[buf].buflisted then
      return
    end

    vim.schedule(function()
      if #vim.t.bufs == 1 and vim.api.nvim_buf_get_name(buf) == "" then
        require("nvchad.nvdash").open()
        require("nvchad.utils").set_cleanbuf_opts "nvdash"
      end
    end)
  end,
})

-- Add new line to the end of the file
autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("UserOnSave", {}),
  pattern = "*",
  callback = function()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank <= n_lines then
      vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" })
    end
  end,
})
