-- Helper functions
-- Check if file exists
local function fileExists(name)
  local f = io.open(name, "r")
  if f ~= nil then io.close(f) return true else return false end
end

-- Read file
local function readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

-- Table length
local function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- Get keys from a table
local function tableGetKeys(t)
  local keys={}
  for key,_ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

-- Trim string
local function trim(s)
  return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

-- Explode string
local function stringExplode(str, div)
  assert(type(str) == "string" and type(div) == "string", "invalid arguments")
  local o = {}
  while true do
      local pos1,pos2 = str:find(div)
      if not pos1 then
          o[#o+1] = str
          break
      end
      o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
  end
  return o
end

--- Main module functions
local M = {}
local keys = {}
local env = {}

--- Get the value of an environment variable as a string.
-- @tparam string key the name of the variable.
-- @tparam ?string|nil fallback a string to return if the variable is not set.
-- @treturn ?string|nil the value of the variable if set, else the fallback is used, nil if no fallback is provided.
M.getString = function(key, fallback)
	assert(type(key) == "string", "Key must be a string.")
	assert(fallback == nil or type(fallback) == "string", "Fallback must be a string or left empty.")

	return keys[key] or fallback
end

--- Get the value of an environment variable as a number.
-- @tparam string key the name of the variable.
-- @tparam ?number|nil fallback a number to return if the variable is not set.
-- @treturn ?number|nil the value of the variable if set, else the fallback is used, nil if no fallback is provided.
M.getNumber = function(key, fallback)
	assert(fallback == nil or type(fallback) == "number", "Fallback must be a number or left empty.")

	return tonumber(M.getString(key)) or fallback
end

--- Get the value of an environment variable as an integer.
-- @tparam string key the name of the variable.
-- @tparam ?number|nil fallback an integer to return if the variable is not set.
-- @treturn ?number|nil the value of the variable if set, else the fallback is used, nil if no fallback is provided.
M.getInteger = function(key, fallback)
	local value = M.getNumber(key, fallback)
	if type(value) == "number" then
		return math.floor(value)
	end
end

--- Get the value of an environment variable as a boolean.
-- @tparam string key the name of the variable.
-- @tparam ?boolean|nil fallback a boolean to return if the variable is not set.
-- @treturn ?boolean|nil the value of the variable if set, else the fallback is used, nil if no fallback is provided.
M.getBoolean = function(key, fallback)
	assert(fallback == nil or type(fallback) == "boolean", "Fallback must be a boolean or left empty.")

	local value = M.getString(key)

	if type(value) == "string" then
		local lower = value:lower()

		if lower == "true" then
			return true
		elseif lower == "false" then
			return false
		end
	end

	return fallback
end

--- Get every variable name set in the environment.
-- @treturn {string,...} a sequential table of variable names.
M.getKeys = function()
	return tableGetKeys(keys)
end

--- Parses the body of a dotenv file.
-- @tparam string the dotenv file body.
-- @treturn {[string]=string,...} the variable keys associated with their values.
local parse = function(body)
	assert(type(body) == "string", "Body must be a string.")
	local output = {}
	local errors = {}
	-- Remove anything we can.
	body = body:gsub("\r", "") -- Remove carriage returns.
	body = body:gsub("\n+", "\n") -- Remove duplicate new lines.
	body = trim(body) -- Remove leading and trailing whitespace.
	local lines = stringExplode(body, "\n")

	for i = #lines, 1, -1 do
		--[[ CLEANING UP ]]
		local line = lines[i]
		if trim(line) == "" then goto skip_env_line end
		if line:sub(1, 1) == "#" then goto skip_env_line end

		local isInQoutes = false
		local isEscaped = false
		local shouldEscapeEnd = false

		for j = 1, #line do
			local char = line:sub(j, j)

			if isEscaped then
				shouldEscapeEnd = true
			end

			if char == "\\" then
				isEscaped = true
				shouldEscapeEnd = false
			end

			-- looks ugly but it works to prevent ' from stopping a " qoute and the other way around.
			if (char == "\"" or char == "'") and not (isEscaped or isInQoutes) then
				isInQoutes = char
			elseif char == isInQoutes and not isEscaped then
				isInQoutes = false
			end

			-- this state should only be for 1 character at a time
			if shouldEscapeEnd then
				shouldEscapeEnd = false
				isEscaped = false
			end

			if char == "#" and not isInQoutes then
				line = line:sub(1, j - 1)
				break
			end
		end

		--[[ PARSING ]]
		local key, value = line:match("^([^=]+)=(.*)$")

		if not key or trim(key) == "" then
			table.insert(errors, "Invalid Key: " .. line)
			goto skip_env_line
		end

		if not value or trim(value) == "" then
			value = nil -- Treat empty values as nil.
		end

		if value then
			value = trim(value) -- Remove leading and trailing whitespace.
			value = value:gsub("^\"(.*)\"$", "%1") -- Remove double quotes.
			value = value:gsub("^'(.*)'$", "%1") -- Remove single quotes.
		end

		output[trim(key)] = value

		::skip_env_line::
	end

	return output, (tableLength(errors) > 0 and errors) or nil
end

--- Loads the dotenv file at the given location.
-- @tparam string the path to the dotenv file.
M.load = function(filePath)
	assert(type(filePath) == "string", "File path must be a string.")
	if not fileExists(filePath) then
		print("Attempted to load non-existent dotenv file at:", filePath)
		return
	end

	keys = parse(readAll(filePath))
end

setmetatable(env, {
	__call = function(_, key, fallback)
		return M.getString(key, fallback)
	end
})

return M
