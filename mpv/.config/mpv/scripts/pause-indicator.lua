-- local ov = mp.create_osd_overlay('ass-events')
-- ov.data = [[{\an5\p1\alpha&H79\1c&Hffffff&\3a&Hff\pos(760,440)}]] ..
--           [[m-125 -75 l 2 2 l -125 75]]

-- mp.observe_property('pause', 'bool', function(_, paused)
--     mp.add_timeout(0.1, function()
--         if paused then ov:update()
--         else ov:remove() end
--     end)
-- end)

-- Pause Icon
local ov = mp.create_osd_overlay('ass-events')
ov.data = [[{\an5\p1\alpha&H23\1c&Hffffff&\3a&Hff\pos(700,400)}]] ..
          -- [[m-125 -75 l 2 2 l -125 75]] ..
          [[m-45 -60 l -45 60 l -20 60 l -20 -60]] ..  -- Vertical bar
          [[m 20 -60 l 20 60 l 45 60 l 45 -60]]        -- Vertical bar

mp.observe_property('pause', 'bool', function(_, paused)
    mp.add_timeout(0.1, function()
        if paused then ov:update()
        else ov:remove() end
    end)
end)

