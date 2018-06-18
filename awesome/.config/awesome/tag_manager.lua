--
-- Created by IntelliJ IDEA.
-- User: fred
-- Date: 12/6/17
-- Time: 6:01 PM
--
-- This script handles my tags. The first tag is special as all screens should have one able to contain tags
--

local awful = require("awful")

local module = {}

module.names = {
    "1: ",
    "2: ",
    "3: ",
    "4: ",
    "5: ",
    "6: ",
    "7",
    "8",
    "9"
}

module.get_tag_num = function(tag)
    return tonumber(tag.name:sub(1, 1))
end

function find_on_screen(s, num)
    for _, tag in ipairs(s.tags) do
        if tag.name ~= nil and tonumber(tag.name:sub(1, 1)) == num then
            return tag
        end
    end
end

function find_populated_tag(num)
    for s in screen do
        local tag = find_on_screen(s, num)

        if #tag:clients() ~= 0 then return tag end
    end
end

-- Will first see if the tag exists anywhere with one client, or merely just get from the given screen
module.determine = function(num, screen)
    if not screen then screen = awful.screen.focused() end

    if num == 1 then
        -- Buffer tag is special and is non-unique. Keep one for each screen
        return find_on_screen(screen, 1)
    elseif find_populated_tag(num) ~= nil then
        -- A populated tag was found, potentially on some other screen.
        -- Let's use the existing one regardless of the screen.
        return find_populated_tag(num)
    else
        return find_on_screen(screen, num)
    end

end

module.set_tag = function(tag_num, screen)
    module.get_tag(tag_num, screen):view_only()
end

module.move_by = function(offset)
    local num = module.get_tag_num(awful.screen.focused().selected_tag) + offset

    local find_tag_by_number = function(tag_num)
        for s in screen do
            for _, tag in ipairs(s.tags) do
                if tag.name ~= nil and tonumber(tag.name:sub(1, 1)) == tag_num then
                    return tag
                end
            end
        end
    end

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
    find_on_screen(awful.screen.focused(), num):view_only()
end

-- Filters tags in the taglist. Returns false when the tag is empty or only contains Polybar
module.taglist_filter = function(tag)
    local show = tag.selected
    for _, v in ipairs(tag:clients()) do
        if v.class ~= "Polybar" then show = true end
    end
    return show
end

return module