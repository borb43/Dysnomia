--make banning modifiers work with custom pools
old_enhancement_roll = SMODS.poll_enhancement
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.poll_enhancement(args) --enhancements
    if args.ignore_bans then
        if not args.options then --allows ignoring bans with default pool
            args.options = {}
            for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
                if v.in_pool and type(v.in_pool) == "function" then
                    if v:in_pool() then
                        args.options[#args.options+1] = v
                    end
                end
            end
            return old_enhancement_roll(args)
        else
            return old_enhancement_roll(args)
        end
    elseif args.options then --check if options was filled in, if so trim it to remove banned keys
        local to_ban = {}
        for k, v in pairs(args.options) do
            if G.GAME.banned_keys[k] or G.GAME.banned_keys[v] then
                to_ban[#to_ban + 1] = k
            elseif type(v) == "table" then
                if G.GAME.banned_keys[v.key] then
                    to_ban[#to_ban + 1] = k
                end
            end
        end
        for _, v in ipairs(to_ban) do
            args.options[v] = nil
        end
        if #args.options == 0 then
            return nil
        else
            return old_enhancement_roll(args)
        end
    else --return default function if ignore_bans was false or nil and options wasnt filled in
        return old_enhancement_roll(args)
    end
end

