--
-- Created by IntelliJ IDEA.
-- User: fred
-- Date: 12/6/17
-- Time: 6:01 PM
-- To change this template use File | Settings | File Templates.
--

local awful = require("awful")

local module = {}

module.names = {
    "1:  Chrome",
    "2:  Code",
    "3:  Code alt",
    "4: ",
    "5:  Chat",
    "6:  Music",
    "7",
    "8",
    "9"
}

module.get_tag_num = function(tag)
    return tonumber(tag.name:sub(1, 1))
end

function find_tag_by_number(tag_num)
    for s in screen do
        for _, tag in ipairs(s.tags) do
            if tag.name ~= nil and tonumber(tag.name:sub(1, 1)) == tag_num then
                return tag
            end
        end
    end
end

function find_tag_by_number_on_screen(tag_num, s)
    for _, tag in ipairs(s.tags) do
        if tag.name ~= nil and tonumber(tag.name:sub(1, 1)) == tag_num then
            return tag
        end
    end
end

module.get_tag = function(tag_num)
    local t = find_tag_by_number(tag_num)

    if t then return t end

    t = awful.tag.add(module.names[tag_num])

    return t
end

module.set_tag = function(tag_num)
    tag_num = math.max(math.min(tag_num, 9), 1)
    find_tag_by_number(tag_num):view_only()
end

module.move_by = function(offset)
    local num = module.get_tag_num(awful.screen.focused().selected_tag) + offset

    if (offset > 0) then
        while num < 9
                and awful.screen.focused() ~= find_tag_by_number(num).screen
                and #find_tag_by_number(num):clients() ~= 0 do
            num = num + 1
        end
    elseif (offset < 0) then
        while num > 1
                and awful.screen.focused() ~= find_tag_by_number(num).screen
                and #find_tag_by_number(num):clients() ~= 0 do
            num = num - 1
        end
    end

    num = math.max(math.min(num, 9), 1)
    find_tag_by_number_on_screen(num, awful.screen.focused()):view_only()
end

return module