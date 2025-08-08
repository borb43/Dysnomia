--talisman compat
to_big = to_big or function(x) return x end

if not Dysnomia then Dysnomia = {} end

function Card:is_category(pool)
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

assert(SMODS.load_file("lib/improvebans.lua"))()
