require "classes.primitive"
local Color = require "classes.color.color"

-- Obstacle class

local obst = {}

Obstacle = Class{
    __includes = {Object},
    init = function(self, grid, i, j, key, bg)
        Object.init(self, grid, i, j, "obst", bg)
        self.img = OBJS_IMG[key]
        self.sx = ROOM_CW/self.img:getWidth()
        self.sy = ROOM_CH/self.img:getHeight()
    end
}

return obst