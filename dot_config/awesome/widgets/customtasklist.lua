-- Grab environment we need
local capi = { screen = screen,
               client = client }
local ipairs = ipairs
local setmetatable = setmetatable
local table = table
local common = require("awful.widget.common")
local beautiful = require("beautiful")
local tag = require("awful.tag")
local flex = require("wibox.layout.flex")
local timer = require("gears.timer")
local gcolor = require("gears.color")
local gstring = require("gears.string")
local gdebug = require("gears.debug")
local base = require("wibox.widget.base")

local function get_screen(s)
    return s and screen[s]
end

local tasklist = { mt = {} }

local instances

-- Public structures
tasklist.filter, tasklist.source = {}, {}

local function tasklist_label(c, args, tb)
    if not args then args = {} end
    local theme = beautiful.get()
    local align = args.align or theme.tasklist_align or "left"
    local fg_normal = gcolor.ensure_pango_color(args.fg_normal or theme.tasklist_fg_normal or theme.fg_normal, "white")
    local bg_normal = args.bg_normal or theme.tasklist_bg_normal or theme.bg_normal or "#000000"
    local fg_focus = gcolor.ensure_pango_color(args.fg_focus or theme.tasklist_fg_focus or theme.fg_focus, fg_normal)
    local bg_focus = args.bg_focus or theme.tasklist_bg_focus or theme.bg_focus or bg_normal
    local fg_urgent = gcolor.ensure_pango_color(args.fg_urgent or theme.tasklist_fg_urgent or theme.fg_urgent,
                                                fg_normal)
    local bg_urgent = args.bg_urgent or theme.tasklist_bg_urgent or theme.bg_urgent or bg_normal
    local tasklist_disable_icon = args.tasklist_disable_icon or theme.tasklist_disable_icon or false
    local disable_task_name = args.disable_task_name or theme.tasklist_disable_task_name or false
    local font = args.font or theme.tasklist_font or theme.font or ""
    local font_focus = args.font_focus or theme.tasklist_font_focus or theme.font_focus or font or ""
    local font_urgent = args.font_urgent or theme.tasklist_font_urgent or theme.font_urgent or font or ""
    local text = ""
    local name = ""
    local bg
    local bg_image


    -- symbol to use to indicate certain client properties
    local sticky = args.sticky or theme.tasklist_sticky or "▪"
    local ontop = args.ontop or theme.tasklist_ontop or '⌃'
    local above = args.above or theme.tasklist_above or '▴'
    local below = args.below or theme.tasklist_below or '▾'
    local floating = args.floating or theme.tasklist_floating or '✈'
    local maximized = args.maximized or theme.tasklist_maximized or '<b>+</b>'
    local maximized_horizontal = args.maximized_horizontal or theme.tasklist_maximized_horizontal or '⬌'
    local maximized_vertical = args.maximized_vertical or theme.tasklist_maximized_vertical or '⬍'

    if not theme.tasklist_plain_task_name then
        if c.sticky then name = name .. sticky end

        if c.ontop then name = name .. ontop
        elseif c.above then name = name .. above
        elseif c.below then name = name .. below end

        if c.maximized then
            name = name .. maximized
        else
            if c.maximized_horizontal then name = name .. maximized_horizontal end
            if c.maximized_vertical then name = name .. maximized_vertical end
            if c.floating then name = name .. floating end
        end
    end

    if not disable_task_name then
        name = name .. gstring.xml_escape(c.class)
    end

    local focused = capi.client.focus == c
    -- Handle transient_for: the first parent that does not skip the taskbar
    -- is considered to be focused, if the real client has skip_taskbar.
    if not focused and capi.client.focus and capi.client.focus.skip_taskbar
        and capi.client.focus:get_transient_for_matching(function(cl)
                                                             return not cl.skip_taskbar
                                                         end) == c then
        focused = true
    end

    if focused then
        bg = bg_focus
        text = text .. "<span color='"..fg_focus.."'>"..name.."</span>"
        bg_image = bg_image_focus
        font = font_focus
    elseif c.urgent then
        bg = bg_urgent
        text = text .. "<span color='"..fg_urgent.."'>"..name.."</span>"
        bg_image = bg_image_urgent
        font = font_urgent


    end 
    if tb then
        tb:set_font(font)
    end


    return text, bg, bg_image, not tasklist_disable_icon and c.icon or nil
end

local function tasklist_update(s, w, buttons, filter, data, style, update_function, args)
    local clients = {}

    local source = args and args.source or tasklist.source.all_clients or nil
    local list   = source and source(s, args) or capi.client.get()

    for _, c in ipairs(list) do
        if not (c.skip_taskbar or c.hidden
            or c.type == "splash" or c.type == "dock" or c.type == "desktop")
            and filter(c, s) then
            table.insert(clients, c)
        end
    end

    local function label(c, tb) return tasklist_label(c, style, tb) end

    update_function(w, buttons, label, data, clients, args)
end

--- Create a new tasklist widget.
-- The last two arguments (update_function
-- and layout) serve to customize the layout of the tasklist (eg. to
-- make it vertical). For that, you will need to copy the
-- awful.widget.common.list_update function, make your changes to it
-- and pass it as update_function here. Also change the layout if the
-- default is not what you want.
--
function tasklist.new(args, filter, buttons, style, update_function, base_widget)
    local screen = nil

    local argstype = type(args)

    -- Detect the old function signature
    if argstype == "number" or argstype == "screen" or
      (argstype == "table" and args.index and args == capi.screen[args.index]) then
        gdebug.deprecate("The `screen` paramater is deprecated, use `args.screen`.",
            {deprecated_in=5})

        screen = get_screen(args)
        args = {}
    end

    assert(type(args) == "table")

    for k, v in pairs { filter          = filter,
                        buttons         = buttons,
                        style           = style,
                        update_function = update_function,
                        layout          = base_widget
    } do
        gdebug.deprecate("The `awful.widget.tasklist()` `"..k
            .."` paramater is deprecated, use `args."..k.."`.",
        {deprecated_in=5})
        args[k] = v
    end

    screen = screen or get_screen(args.screen)
    local uf = args.update_function or common.list_update
    local w = base.make_widget_from_value(args.layout or flex.horizontal)

    local data = setmetatable({}, { __mode = 'k' })

    local spacing = args.style and args.style.spacing or args.layout and args.layout.spacing
                    or beautiful.tasklist_spacing
    if w.set_spacing and spacing then
        w:set_spacing(spacing)
    end

    local queued_update = false

    -- For the tests
    function w._do_tasklist_update_now()
        queued_update = false
        if screen.valid then
            tasklist_update(screen, w, args.buttons, args.filter, data, args.style, uf, args)
        end
    end

    function w._do_tasklist_update()
        -- Add a delayed callback for the first update.
        if not queued_update then
            timer.delayed_call(w._do_tasklist_update_now)
            queued_update = true
        end
    end
    function w._unmanage(c)
        data[c] = nil
    end
    if instances == nil then
        instances = setmetatable({}, { __mode = "k" })
        local function us(s)
            local i = instances[get_screen(s)]
            if i then
                for _, tlist in pairs(i) do
                    tlist._do_tasklist_update()
                end
            end
        end
        local function u()
            for s in pairs(instances) do
                if s.valid then
                    us(s)
                end
            end
        end

        tag.attached_connect_signal(nil, "property::selected", u)
        tag.attached_connect_signal(nil, "property::activated", u)
        capi.client.connect_signal("property::urgent", u)
        capi.client.connect_signal("property::sticky", u)
        capi.client.connect_signal("property::ontop", u)
        capi.client.connect_signal("property::above", u)
        capi.client.connect_signal("property::below", u)
        capi.client.connect_signal("property::floating", u)
        capi.client.connect_signal("property::maximized_horizontal", u)
        capi.client.connect_signal("property::maximized_vertical", u)
        capi.client.connect_signal("property::maximized", u)
        capi.client.connect_signal("property::minimized", u)
        capi.client.connect_signal("property::name", u)
        capi.client.connect_signal("property::icon_name", u)
        capi.client.connect_signal("property::icon", u)
        capi.client.connect_signal("property::skip_taskbar", u)
        capi.client.connect_signal("property::screen", function(c, old_screen)
            us(c.screen)
            us(old_screen)
        end)
        capi.client.connect_signal("property::hidden", u)
        capi.client.connect_signal("tagged", u)
        capi.client.connect_signal("untagged", u)
        capi.client.connect_signal("unmanage", function(c)
            u(c)
            for _, i in pairs(instances) do
                for _, tlist in pairs(i) do
                    tlist._unmanage(c)
                end
            end
        end)
        capi.client.connect_signal("list", u)
        capi.client.connect_signal("focus", u)
        -- Commenting this out stops the "flicker" from switching tags
        -- but i'm sure there's an edge case that needs it
        -- capi.client.connect_signal("unfocus", u)
        capi.screen.connect_signal("removed", function(s)
            instances[get_screen(s)] = nil
        end)
    end
    w._do_tasklist_update()
    local list = instances[screen]
    if not list then
        list = setmetatable({}, { __mode = "v" })
        instances[screen] = list
    end
    table.insert(list, w)
    return w
end

--- Filtering function to include only the currently focused client.
-- @param c The client.
-- @param screen The screen we are drawing on.
-- @return true if c is focused on screen, false otherwise
-- @filterfunction awful.tasklist.filter.focused
function tasklist.filter.focused(c, screen)
    -- Only print client on the same screen as this widget
    return get_screen(c.screen) == get_screen(screen) and capi.client.focus == c
end

--- Get all the clients in an undefined order.
--
-- This is the default source.
--
-- @sourcefunction awful.tasklist.source.all_clients
function tasklist.source.all_clients()
    return capi.client.get()
end

function tasklist.mt:__call(...)
    return tasklist.new(...)
end

return setmetatable(tasklist, tasklist.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
