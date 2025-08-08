function Card:is_category(pool) --check if a card has a specified category assigned in its definition or an outside table
    if self.config.category and type(self.config.category) == "table" then
        if self.config.category[pool] then
            return true
        end
    elseif pool and type(pool) == "table" then
        if pool[self.config.center.key] then
            return true
        end
    end
end