local M = {
  "echasnovski/mini.hipatterns",
  version = "*",
  opts = function()
    local hipatterns = require("mini.hipatterns")

    -- Returns hex color group for matching short hex color.
    --
    ---@param match string
    ---@return string
    local hex_color_short = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
      local hex = string.format('#%s%s%s%s%s%s', r, r, g, g, b, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgb() color.
    --
    ---@param match string
    ---@return string
    local rgb_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue = match:match('rgb%((%d+), ?(%d+), ?(%d+)%)')
      local hex = string.format('#%02x%02x%02x', red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgba() color
    -- or false if alpha is nil or out of range.
    -- The use of the alpha value refers to a black background.
    --
    ---@param match string
    ---@return string|false
    local rgba_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue, alpha = match:match('rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)')
      alpha = tonumber(alpha)
      if alpha == nil or alpha < 0 or alpha > 1 then return false end
      local hex = string.format('#%02x%02x%02x', red * alpha, green * alpha, blue * alpha)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching 0xAARRGGBB color
    -- or false if alpha is nil or out of range.
    -- The use of the alpha value refers to a black background.
    --
    ---@param match string
    ---@return string|false
    local hex_zero_rgba_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local alpha, red, green, blue = match:sub(3, 4), match:sub(5, 6), match:sub(7, 8), match:sub(9, 10)

      local a = tonumber(alpha, 16) / 255
      local r = tonumber(red, 16)
      local g = tonumber(green, 16)
      local b = tonumber(blue, 16)
      if a == nil or a < 0 or a > 1 then return false end
      local hex = string.format('#%02x%02x%02x', r * a, g * a, b * a)
      -- local hex = string.format('#%s%s%s', red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns extmark opts for highlights with virtual inline text.
    --
    ---@param data table Includes `hl_group`, `full_match` and more.
    ---@return table
    local extmark_opts_inline = function(_, _, data)
      return {
        virt_text = { { '', data.hl_group } },
        virt_text_pos = 'inline',
        -- priority = 200,
        right_gravity = false,
      }
    end

    local ret = {
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- `#rrggbb`
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
        hex_color = hipatterns.gen_highlighter.hex_color({ style = 'inline', inline_text = '' }),
        -- `#rgb`
        hex_color_short = { pattern = '#%x%x%x%f[%X]', group = hex_color_short, extmark_opts = extmark_opts_inline },
        -- `rgb(255, 255, 255)`
        rgb_color = { pattern = 'rgb%(%d+, ?%d+, ?%d+%)', group = rgb_color, extmark_opts = extmark_opts_inline },
        -- `rgba(255, 255, 255, 0.5)`
        rgba_color = {
          pattern = 'rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)',
          group = rgba_color,
          extmark_opts = extmark_opts_inline,
        },
        -- `0xAARRGGBB`
        hex_zero_rgba_color = { pattern = '0x%x%x%x%x%x%x%x%x%f[%X]', group = hex_zero_rgba_color, extmark_opts = extmark_opts_inline },
      },
    }
    return ret
  end,
}

return { M }
