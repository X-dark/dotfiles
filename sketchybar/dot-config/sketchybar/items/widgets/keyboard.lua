local colors = require("colors")
local settings = require("settings")

sbar.add("event", "input_changed", "AppleSelectedInputSourcesChangedNotification")

local input = sbar.add("item", {
  icon = { drawing = false },
  background = { color = colors.bg1 },
  label = {
    string = "input",
    font = {
      style = settings.font.style_map["Regular"],
      size = 12.0,
    },
  },
  position = "right",
  updates = true,
})

input:subscribe("input_changed", function(_)
  sbar.exec("defaults read com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID", function(source)

    -- Remove trailing whitespace/newline
    source = source:gsub("^%s*(.-)%s*$", "%1")

    -- Shorten layout
    -- com.apple.keylayout.French-PC
    local result, replacements = source:gsub("^com%.apple%.keylayout%.(..).-(%-.*)$", "%1%2")
    -- com.apple.keylayout.French
    if replacements == 0 then
      result, replacements = source:gsub("^com%.apple%.keylayout%.(..).*$", "%1")
     end

    input:set({
      label = {
        string = result
      }
    })
  end)
end)

input:subscribe("mouse.clicked", function(_)
  sbar.exec("osascript -e 'tell application \"System Events\" to key code 63'")
end)

sbar.trigger("input_changed")
