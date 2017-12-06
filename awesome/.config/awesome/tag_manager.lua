--
-- Created by IntelliJ IDEA.
-- User: fred
-- Date: 12/6/17
-- Time: 6:01 PM
-- To change this template use File | Settings | File Templates.
--

local awful = require("awful")

local module = {}

local names = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
}

function find_tag_by_number(tag_num)
    for s in screen do
        for _, tag in ipairs(s.tags) do
            if tag.name ~= nil and tonumber(tag.name:sub(1, 1)) == tag_num then
                return tag
            end
        end
    end
end

module.set_tag = function(tag_num)
    --require("naughty").notify{text=tostring(tag_num)}

    local cur_tag = awful.screen.focused().selected_tag
    local new_tag
    tag_num = math.max(math.min(tag_num, 9), 1)

    new_tag = find_tag_by_number(tag_num)

    -- Or create a new tag instead

    if new_tag == nil then
        new_tag = awful.tag.add(names[tag_num])
    end

    new_tag:view_only()

    if new_tag ~= cur_tag and #cur_tag:clients() == 0 then
        cur_tag:delete()
    end
end

module.move_by = function(offset)
    local num = tonumber(awful.screen.focused().selected_tag.name:sub(1, 1)) + offset

    if (offset > 0) then
        while num < 9 and find_tag_by_number(num) ~= nil do num = num + 1 end
    elseif (offset < 0) then
        while num > 1 and find_tag_by_number(num) ~= nil do num = num - 1 end
    end

    module.set_tag(num)
end

return module