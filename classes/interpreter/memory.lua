local Color = require "classes.color.color"
require "classes.primitive"

Memory = Class{
    __includes =  {RECT},
    init = function(self, x, y, w, h, slots)
        RECT.init(self, x, y, w, h)
        self.tp = "memory"

        self.unavailable_font = FONTS.fira(50)

        self:setSlots(slots)
    end
}

function Memory:setSlots(slots)
    self.slots = slots
    -- Decide draw
    local best_r = 1
    local best_ssize = math.min(self.h, self.w / self.slots)
    for i = 2, 5 do
        local columns = math.ceil(slots / i)
        local cs = math.min(self.h / i, self.w / columns)
        if cs > best_ssize then
            best_r = i
            best_ssize = cs
        end
    end
    -- slot size
    self.ssize = best_ssize
    self.rows = best_r
    self.columns = math.ceil(slots / self.rows)

    self.index_font = FONTS.fira(self.ssize / 3)
    self.value_font = FONTS.fira(self.ssize * .4)

    -- actual memory
    self.vec = {}
    for i = 1, slots do self.vec[i] = math.floor(math.random() * 17) end
end

function Memory:reset()
end

function Memory:draw()
    local color = Color.white()

    if self.slots == 0 then
        Color.set(color)
        love.graphics.rectangle("line", self.pos.x, self.pos.y, self.w, self.h)
        Color.set(Color.red())
        love.graphics.setFont(self.unavailable_font)
        love.graphics.print("UNAVAILABLE", self.pos.x + self.w / 5, self.pos.y + self.h / 2, -math.pi / 20)
    else
        color.l = 230
        color.s = 140
        color.a = 255
        love.graphics.setFont(self.index_font)
        for i = 1, self.slots do
            local r = math.ceil(i / self.columns) - 1
            local c = i - r * self.columns - 1

            color.a = 255
            Color.set(color)
            love.graphics.rectangle("line", self.pos.x + c * self.ssize, self.pos.y + r * self.ssize, self.ssize, self.ssize)

            color.a = 100
            Color.set(color)
            love.graphics.print(i - 1, self.pos.x + 2 + c * self.ssize, self.pos.y + r * self.ssize)
        end

        color.a = 255
        Color.set(color)
        love.graphics.setFont(self.value_font)
        for i = 1, self.slots do
            local r = math.ceil(i / self.columns) - 1
            local c = i - r * self.columns - 1
            love.graphics.printf(self.vec[i], self.pos.x + 2 + c * self.ssize, self.pos.y + r * self.ssize + self.ssize / 4, self.ssize, "center")
        end
    end
end