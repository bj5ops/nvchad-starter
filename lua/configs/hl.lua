local M = {}

---@class HLTable
M.add = {}

---@class HLTable
M.override = {
  Comment = { italic = true },
  ["@comment"] = { italic = true },
  NvDashAscii = {
    bg = "none",
    fg = (not "logo_fg") and "blue" or "logo_fg",
  },
  NvDashButtons = {
    bg = "none",
    -- fg = (not "logo_fg") and "blue" or "logo_fg",
  },
  St_NormalMode = { bg = "logo_fg" },
  St_NormalModeSep = { fg = "logo_fg" },
  NvimTreeNormal = { bg = "black" },
  NvimTreeNormalNC = { bg = "black" },
  NvimTreeEndOfBuffer = { bg = "black" },
  NvimTreeWinSeparator = {
    fg = "black",
    bg = "black",
  },
}

return M
