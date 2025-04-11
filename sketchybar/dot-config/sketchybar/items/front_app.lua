local colors = require("colors")
local settings = require("settings")
local icons = require("icons")
-- local app_icons = require("helpers.app_icons")

-- local front_app = sbar.add("item", "front_app", {
--   display = "active",
--   icon = {
--     padding_left = 8,
--     padding_right = 9,
--     color = colors.grey,
--     string = app_icons["Default"],
--     font = "sketchybar-app-font:Regular:16.0",
--   },
--   label = {
--     font = {
--       style = settings.font.style_map["Black"],
--       size = 12.0,
--     },
--   },
--   updates = true,
-- })

-- front_app:subscribe("front_app_switched", function(env)
--   local lookup = app_icons[env.INFO]
--   local icon = ((lookup == nil) and app_icons["Default"] or lookup)
--   front_app:set({
--     icon = { string = icon },
--     label = { string = env.INFO },
--   })
-- end)

local menu_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.white,
    string = icons.menu.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Application Menus",
    color = colors.white,
  },
  background = {
    -- color = colors.with_alpha(colors.grey, 0.0),
    -- border_color = colors.with_alpha(colors.bg1, 0.0),
    color = colors.bg2,
    border_color = colors.black,
    border_width = 1
  }
})

menu_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = menu_indicator:query().icon.value == icons.menu.on
  menu_indicator:set({
    icon = currently_on and icons.menu.off or icons.menu.on
  })
end)

menu_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    menu_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

menu_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    menu_indicator:set({
      background = {
        color = colors.bg2,
        border_color = colors.black,
      },
      icon = { color = colors.white },
      label = { width = 0, }
    })
  end)
end)

menu_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)

-- front_app:subscribe("mouse.clicked", function(env)
--   sbar.trigger("swap_menus_and_spaces")
-- end)
