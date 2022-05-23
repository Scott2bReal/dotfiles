-- Awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")

-- Initialize apps table
local apps = {}

-- Define user apps
apps.browser = function ()
  awful.spawn(user.browser, { switchtotag = true })
end

return apps
