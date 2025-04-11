local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "mem_update" for
-- the memory load data, which is fired every 2.0 seconds.
sbar.exec("killall mem_usage >/dev/null; $CONFIG_DIR/helpers/event_providers/mem_usage/bin/mem_usage mem_update 2.0")

local memory = sbar.add("graph", "widgets.memory" , 42, {
  position = "right",
  graph = { color = colors.blue },
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = { string = icons.memory },
  label = {
    string = "mem ??%",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    align = "right",
    padding_right = 0,
    width = 0,
    y_offset = 4
  },
  padding_right = settings.paddings + 6
})

memory:subscribe("mem_update", function(env)
  local usage = tonumber(env.usage)
  memory:push({ usage / 100. })

  local color = colors.blue
  if usage > 30 then
    if usage < 60 then
      color = colors.yellow
    elseif usage < 80 then
      color = colors.orange
    else
      color = colors.red
    end
  end

  memory:set({
    graph = { color = color },
    label = "mem " .. env.usage .. "%",
  })
end)

memory:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Activity Monitor'")
end)

-- Background around the memory item
sbar.add("bracket", "widgets.memory.bracket", { memory.name }, {
  background = { color = colors.bg1 }
})

-- Background around the memory item
sbar.add("item", "widgets.memory.padding", {
  position = "right",
  width = settings.group_paddings
})
