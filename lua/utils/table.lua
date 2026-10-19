local M = {}

--- The identity function, used as a default for tranformation functions
---@param v any
---@return any
local function identity(v)
	return v
end

--- The nofilter function, used as a default for filter functions
---@param _ any
---@return boolean
local function nofilter(_)
	return true
end

--- Creates a lookup table of skipkeys mapping them to a boolean value from a list of strings keys to skip
---@param keys string[]
---@return table<string, boolean>
local function note_keys_to_skip(keys)
	local skip = {}
	for _, s in pairs(keys) do
		skip[s] = true
	end
	return skip
end

--- Indexes a given table recursively using key (which is a dot notation formatted string) until nil is returned or the key parts are exhausted
---@param tbl table <string|integer, any> the value to resolve a nested index for
---@param key string sequence of indexes separated by dots
---@return any
M.deep_idx = function(tbl, key)
	local v = tbl
	for idx in key:gmatch("([^%.]+)") do
		if type(v) ~= "table" then
			--- value is not index-able but we still have an index to try
			return nil
		end

		v = v[idx]
	end

	return v
end

--- Walks a given table and gathers the values that pass a given filter function
---@param val table the table to walk
---@param filter? fun(v: any): boolean the predicate that determines if the discovered value is included in the result set
---@param transform? fun(v: any): any the transformation function that modify discovered values
---@param unique? boolean switch to keep the result set unique
---@param skip? string[] list of keys to avoid recursively walking
---@return any[]
M.walk = function(val, filter, transform, unique, skip)
	---@type any[]
	local found = {}
	---@type table<any, boolean>
	local seen = {}
	---@type table<any, boolean>
	local visited = {}

	local filterfn = filter or nofilter
	local mutatefn = transform or identity
	local skipkeys = note_keys_to_skip(skip or {})

	--- Iterates through the given value, recursively
	---@param v any
	---@return string|number|boolean|nil
	local function iter(v)
		if filterfn(v) then
			if unique and seen[v] then
				return nil
			end
			seen[v] = true
			found[#found + 1] = mutatefn(v)
			return found[#found]
		end

		if type(v) ~= "table" or visited[v] then
			return nil
		end

		visited[v] = true

		for key, value in pairs(v) do
			if not skip or not skipkeys[key] then
				local newv = iter(value)
				if newv ~= nil then
					v[key] = newv
				end
			end
		end
		return v
	end

	iter(val)
	return found
end

return M
