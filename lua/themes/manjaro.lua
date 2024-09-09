-- Credits to original https://github.com/one-dark
-- This is modified version of it

local M = {}

M.base_30 = {
  white = "#c9cdd4",
  darker_black = "#192124",
  black = "#1B2224", --  nvim bg
  black2 = "#222d31",
  one_bg = "#2A373C", -- real bg of onedark
  one_bg2 = "#324248",
  one_bg3 = "#4b646c",
  grey = "#42464e",
  grey_fg = "#565c64",
  grey_fg2 = "#6f737b",
  light_grey = "#6f737b",
  red = "#e06c75",
  baby_pink = "#DE8C92",
  pink = "#ff75a0",
  line = "#2A373C", -- for lines like vertsplit
  green = "#98c379",
  vibrant_green = "#7eca9c",
  nord_blue = "#81A1C1",
  blue = "#16A085",
  yellow = "#e7c787",
  sun = "#EBCB8B",
  purple = "#de98fd",
  dark_purple = "#c882e7",
  teal = "#519ABA",
  orange = "#fca2aa",
  cyan = "#a3b8ef",
  statusline_bg = "#1B2224",
  lightbg = "#2A373C",
  pmenu_bg = "#A3BE8C",
  folder_bg = "#8FBCBB",
  logo_fg = "#16A085",
}

M.base_16 = {
  base00 = "#1B2224",
  base01 = "#222D31",
  base02 = "#2A373C",
  base03 = "#324248",
  base04 = "#46555a",
  base05 = "#c9cdd4",
  base06 = "#d0d2d9",
  base07 = "#d7d7dd",
  base08 = "#e06c75",
  base09 = "#d19a66",
  base0A = "#e5c07b",
  base0B = "#98c379",
  base0C = "#56b6c2",
  base0D = "#61afef",
  base0E = "#c678dd",
  base0F = "#be5046",
}

M.type = "dark"

M = require("base46").override_theme(M, "manjaro")

return M
