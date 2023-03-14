#!/usr/bin/lua

local fs = require "nixio.fs"

local function scrape()
  for input in fs.glob("/sys/class/hwmon/hwmon*/temp1_input") do
    local name = input:gsub("/sys/class/hwmon/",""):gsub("/","_")
    local temp = get_contents(input)
    metric("nodex_"..name, "gauge", nil, tonumber(temp) / 1000.0)
  end
end

return { scrape = scrape }

