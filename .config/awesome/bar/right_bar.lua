local awful = require("awful")
local color = require("theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

return function(s, widgets)
  local top_right = awful.popup {
    widget = wibox.container.background,
    ontop = false,
    bg = color["Grey900"],
    visible = true,
    screen = s,
    placement = function(c) awful.placement.top_right(c, { margins = dpi(10) }) end,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end
  }

  top_right:struts {
    top = 55
  }

  local function prepare_widgets(ws)
    local layout = {
      forced_height = 45,
      layout = wibox.layout.fixed.horizontal
    }
    for i, widget in pairs(ws) do
      if i == 1 then
        table.insert(layout,
          {
            widget,
            left = dpi(6),
            right = dpi(3),
            top = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
          })
      elseif i == #ws then
        table.insert(layout,
          {
            widget,
            left = dpi(3),
            right = dpi(6),
            top = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
          })
      else
        table.insert(layout,
          {
            widget,
            left = dpi(3),
            right = dpi(3),
            top = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
          })
      end
    end
    return layout
  end

  awesome.connect_signal(
    "togglebar",
    function()
      top_right.visible = not top_right.visible
    end
  )

  top_right:setup {
    nil,
    nil,
    prepare_widgets(widgets),
    layout = wibox.layout.align.horizontal
  }
end
