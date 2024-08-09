-- Load dotenv module
local Env = require "modules.dotenv"

-- Dotenv util
local M = {}

-- Function to load env config
-- @return string
local loadEnvConfig = function()
  local cfg = os.getenv "HOME" .. "/.config/nvim/.env"
  if os.getenv "XDG_CONFIG_HOME" ~= nil then
    cfg = os.getenv "XDG_CONFIG_HOME" .. "/nvim/.env"
  end
  return cfg
end

-- Function to load env config
Env.load(loadEnvConfig())

-- Function to load env config
-- @param a string
-- @param case string ( string | number | boolean )
-- @return string
M.env = function(a, case)
  -- Local variable instead of function(a) on every case:
  local value = a
  -- Cases list:
  local switchcase = {}

  -- Cases:
  switchcase["string"] = function()
    return Env.getString(value)
  end
  switchcase["number"] = function()
    return Env.getNumber(value)
  end
  switchcase["boolean"] = function()
    return Env.getBoolean(value)
  end

  return switchcase[case](a)
end

return M
