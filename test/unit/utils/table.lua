local luaunit = require("luaunit")

local function assertListCountainsValueExactTimes(l, v, expectedAppearances)
	local count = 0
	for _, e in ipairs(l) do
		if e == v then
			count = count + 1
		end
	end
	luaunit.assertEquals(expectedAppearances, count)
end

local tableutils = require("utils.table")

function TestDeepIdxSingleLayer()
	local v = { a = 1, b = 2 }
	luaunit.assertEquals(tableutils.deep_idx(v, "a"), 1)
	luaunit.assertEquals(tableutils.deep_idx(v, "b"), 2)
end

function TestDeepIdxMultipleLayers()
	local v = {
		name = "Alice",
		address = {
			street_number = 123,
			street_name = "some street",
			city = "this city",
			country = "that country",
		},
	}
	luaunit.assertEquals(tableutils.deep_idx(v, "address.city"), "this city")
	luaunit.assertEquals(tableutils.deep_idx(v, "address.country"), "that country")
end

function TestDeepIdxFoundNilValue()
	local v = { a = 1, b = 2 }
	luaunit.assertNil(tableutils.deep_idx(v, "c"))
end

function TestDeepIndexFoundNilInnerValue()
	local v = {
		name = "Bob",
		address = {
			street_number = 456,
			street_name = "another road",
			city = "far far away city",
			country = "opposite side of the world land",
		},
	}
	luaunit.assertNil(tableutils.deep_idx(v, "address.zip_code"))
end

function TestWalkForStringsInTable()
	local event = {
		level = "debug",
		type = "view",
		ip = "253.4.31.92",
		data = {
			page = "/dolor/adipiscing",
			referrer = "facebook.com",
			duration = 6492,
		},
		metadata = {
			version = "3.3.9",
			env = "production",
			site = "facebook.com",
		},
	}

	local strings = tableutils.walk(event, function(v)
		return type(v) == "string"
	end)

	luaunit.assertEquals(#strings, 8)
	assertListCountainsValueExactTimes(strings, "facebook.com", 2)
end

function TestWalkForUniqueStringsInTable()
	local event = {
		level = "debug",
		type = "view",
		ip = "253.4.31.92",
		data = {
			page = "/dolor/adipiscing",
			referrer = "facebook.com",
			duration = 6492,
		},
		metadata = {
			version = "3.3.9",
			env = "production",
			site = "facebook.com",
		},
	}

	local strings = tableutils.walk(event, function(v)
		return type(v) == "string"
	end, nil, true, nil)

	luaunit.assertEquals(#strings, 7)
	assertListCountainsValueExactTimes(strings, "facebook.com", 1)
end

function TestWalkForStringsMatchingPatternInTable()
	local style = {
		border = {
			top = "#676869",
			left = "red",
			right = "red",
			bottom = "#676869",
		},
	}
	local pattern = "^#%x%x%x%x%x%x$"
	local strings = tableutils.walk(style, function(v)
		return type(v) == "string" and string.match(v, pattern) ~= nil
	end)
	luaunit.assertEquals(#strings, 2)
	for _, s in pairs(strings) do
		luaunit.assertStrMatches(s, pattern)
	end
end

function TestWalkForUniqueStringsMatchingPatternInTable()
	local style = {
		border = {
			top = "#676869",
			left = "red",
			right = "red",
			bottom = "#676869",
		},
	}
	local pattern = "^#%x%x%x%x%x%x$"
	local strings = tableutils.walk(style, function(v)
		return type(v) == "string" and string.match(v, pattern) ~= nil
	end, nil, true, nil)

	luaunit.assertEquals(#strings, 1)
	for _, s in pairs(strings) do
		luaunit.assertStrMatches(s, pattern)
	end
end

function TestWalkForNumbersInTableExceptNonNumericalSubvalues()
	local style = {
		font_size = 15,
		font_rules = {
			weight = "strong",
			italic = false,
		},
		font_shaping = {
			min_size = 12,
			max_size = 20,
		},
	}
	local numbers = tableutils.walk(style, function(v)
		return type(v) == "number"
	end)
	luaunit.assertEquals(#numbers, 3)
end

function TestWalkForNumbersInTableExceptExplicitlySkipped()
	local style = {
		font_size = 15,
		font_rules = {
			weight = "strong",
			italic = false,
		},
		font_shaping = {
			min_size = 12,
			max_size = 20,
		},
	}
	local numbers = tableutils.walk(style, function(v)
		return type(v) == "number"
	end, nil, false, { "font_shaping" })
	luaunit.assertEquals(#numbers, 1)
end

function TestWalkForNumbersInTableAfterSquaringThem()
	local style = {
		font_size = 15,
		font_rules = {
			weight = "strong",
			italic = false,
		},
		font_shaping = {
			min_size = 12,
			max_size = 20,
		},
	}
	local numbers = tableutils.walk(style, function(v)
		return type(v) == "number"
	end, function(x)
		return x * x
	end, false, { "font_shaping" })
	luaunit.assertEquals(#numbers, 1)
	luaunit.assertEquals(numbers[1], 15 * 15)
	luaunit.assertEquals(style.font_size, 15 * 15)
end
