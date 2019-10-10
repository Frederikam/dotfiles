--
-- Created by IntelliJ IDEA.
-- User: fred
-- Date: 1/1/18
-- Time: 12:34 PM
--

local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

naughty.config.notify_callback = function (args)
    args.height = dpi(72)
    args.margin = dpi(4)

    if args.icon then
        args.icon_size = args.height - args.margin * 2
        args.width = dpi(400 + args.icon_size)
    else
        args.width = dpi(400)
    end

    args.font = "sans 10"
    args.bg = xrdb.color4
    args.fg = "#ffffff"

    return args;
end

--naughty.notify({ title = "Achtung!", text = "Debitis voluptatum iste omnis ullam repellat voluptatibus sit expedita. Est est sint officia explicabo. Error ipsam blanditiis ea quia. Sunt consectetur modi autem. Fuga ratione vero voluptas cupiditate. Sed voluptas iste dicta quo. Rem qui esse nesciunt quaerat totam reiciendis. Eos hic tempora veritatis reiciendis velit tempora omnis molestias. Nam temporibus eaque quia distinctio repellat est error molestiae. Ipsum quam id quia a quisquam blanditiis. Ut aspernatur odit voluptatem dolorem at veniam vitae. Maxime deserunt non temporibus nesciunt labore. Eos voluptatem ut harum ut quidem neque. Est omnis officiis numquam. ", timeout = 0 })
