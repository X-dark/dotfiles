local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local interface = "en16"
-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
sbar.exec(
  "$CONFIG_DIR/helpers/event_providers/network_load/bin/network_load " .. interface .. " eth_network_update 2.0"
)

local popup_width = 250

local eth_up = sbar.add("item", "widgets.eth1", {
  position = "right",
  padding_left = -5,
  width = 0,
  icon = {
    padding_right = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.ethernet.upload,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.red,
    string = "??? Bps",
  },
  y_offset = 4,
})

local eth_down = sbar.add("item", "widgets.eth2", {
  position = "right",
  padding_left = -5,
  icon = {
    padding_right = 0,
    font = {
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = icons.ethernet.download,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.blue,
    string = "??? Bps",
  },
  y_offset = -4,
})

local ethernet = sbar.add("item", "widgets.ethernet.padding", {
  position = "right",
  label = { drawing = false },
})

-- Background around the item
local eth_bracket = sbar.add("bracket", "widgets.ethernet.bracket", {
  ethernet.name,
  eth_up.name,
  eth_down.name,
}, {
  background = { color = colors.bg1 },
  popup = { align = "center", height = 30 },
})

local hostname = sbar.add("item", {
  position = "popup." .. eth_bracket.name,
  icon = {
    align = "left",
    string = "Hostname:",
    width = popup_width / 2,
  },
  label = {
    max_chars = 20,
    string = "????????????",
    width = popup_width / 2,
    align = "right",
  },
})

local ip = sbar.add("item", {
  position = "popup." .. eth_bracket.name,
  icon = {
    align = "left",
    string = "IP:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

local mask = sbar.add("item", {
  position = "popup." .. eth_bracket.name,
  icon = {
    align = "left",
    string = "Subnet mask:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

local router = sbar.add("item", {
  position = "popup." .. eth_bracket.name,
  icon = {
    align = "left",
    string = "Router:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

sbar.add("item", { position = "right", width = settings.group_paddings })

eth_up:subscribe("eth_network_update", function(env)
  local up_color = (env.upload == "000 Bps") and colors.grey or colors.red
  local down_color = (env.download == "000 Bps") and colors.grey or colors.blue
  eth_up:set({
    icon = { color = up_color },
    label = {
      string = env.upload,
      color = up_color,
    },
  })
  eth_down:set({
    icon = { color = down_color },
    label = {
      string = env.download,
      color = down_color,
    },
  })
end)

ethernet:subscribe({ "wifi_change", "system_woke" }, function(env)
  sbar.exec("ipconfig getifaddr " .. interface, function(ip)
    local connected = not (ip == "")
    ethernet:set({
      icon = {
        string = connected and icons.ethernet.connected or icons.ethernet.disconnected,
        color = connected and colors.white or colors.red,
      },
    })
  end)
end)

local function hide_details()
  eth_bracket:set({ popup = { drawing = false } })
end

local function toggle_details()
  local should_draw = eth_bracket:query().popup.drawing == "off"
  if should_draw then
    eth_bracket:set({ popup = { drawing = true } })
    sbar.exec("networksetup -getcomputername", function(result)
      hostname:set({ label = result })
    end)
    sbar.exec("ipconfig getifaddr " .. interface, function(result)
      ip:set({ label = result })
    end)
    sbar.exec("ipconfig getsummary " .. interface .. " | awk -F ' ' '/^subnet_mask/ {print $3}'", function(result)
      mask:set({ label = result })
    end)
    sbar.exec("ipconfig getsummary " .. interface .. " | awk -F ' ' '/Router / {print $3}'", function(result)
      router:set({ label = result })
    end)
  else
    hide_details()
  end
end

eth_up:subscribe("mouse.clicked", toggle_details)
eth_down:subscribe("mouse.clicked", toggle_details)
ethernet:subscribe("mouse.clicked", toggle_details)
ethernet:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec('echo "' .. label .. '" | pbcopy')
  sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
