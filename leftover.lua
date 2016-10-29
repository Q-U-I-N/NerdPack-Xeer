14:59 [30455] = 24.350649350578, -- Ice Lance

14:59 [30455] = 26.455026454899, -- Ice Lance

14:59 [30455] = 25.728987993035, -- Ice Lance

14:59 [30455] = 23.076923076871, -- Ice Lance

14:59 [30455] = 25.000000000061, -- Ice Lance

14:59 [30455] = 23.076923077001, -- Ice Lance

14:59 [30455] = 26.455026455069, -- Ice Lance

14:59 [30455] = 27.272727272583, -- Ice Lance

14:59 [30455] = 24.311183144311, -- Ice Lance

14:59 [30455] = 23.659305993622, -- Ice Lance

14:58 [30455] = 27.272727272583, -- Ice Lance

14:58 [30455] = 29.013539651847, -- Ice Lance

14:58 [30455] = 25.728987993195, -- Ice Lance

14:58 [30455] = 27.272727272763, -- Ice Lance

14:58 [30455] = 25.728987993035, -- Ice Lance

14:58 [30455] = 25.000000000061, -- Ice Lanc

14:59 [30455] = 24.350649350578, -- Ice Lance

14:59 [30455] = 26.455026454899, -- Ice Lance

14:59 [30455] = 25.728987993035, -- Ice Lance

14:59 [30455] = 23.076923076871, -- Ice Lance

14:59 [30455] = 25.000000000061, -- Ice Lance

14:59 [30455] = 23.076923077001, -- Ice Lance

14:59 [30455] = 26.455026455069, -- Ice Lance

14:59 [30455] = 27.272727272583, -- Ice Lance

14:59 [30455] = 24.311183144311, -- Ice Lance

14:59 [30455] = 23.659305993622, -- Ice Lance

14:58 [30455] = 27.272727272583, -- Ice Lance

14:58 [30455] = 29.013539651847, -- Ice Lance

14:58 [30455] = 25.728987993195, -- Ice Lance

14:58 [30455] = 27.272727272763, -- Ice Lance

14:58 [30455] = 25.728987993035, -- Ice Lance

14:58 [30455] = 25.000000000061, -- Ice Lanc

--/dump NeP.DSL:Get('incdmg')('player', '10')
--/dump NeP.DSL:Get('incdmg_phys')('player', '10')
--/dump NeP.DSL:Get('incdmg_magic')('player', '10')

--[[
function Xeer.get_active_demon_count()
	--print('Xeer.get_active_demon_count')
    if(IsPetActive()) then
        return Xeer.demon_count + 1
    else
        return Xeer.demon_count
    end
end

function Xeer.sort_demons()
	--print('Xeer.sort_demons')
    Xeer.demons_sorted = {}
    local counter = 1
    for i, v in Xeer.SPairs(Xeer.active_demons, Xeer.SortComperator) do
        if (v ~= nil) then
            if (Xeer.sort_contains(v) == - 1) then
                Xeer.demons_sorted[counter] = {}
                Xeer.demons_sorted[counter].name = v.name
                Xeer.demons_sorted[counter].time = v.time
                Xeer.demons_sorted[counter].guid = v.guid
                Xeer.demons_sorted[counter].counter = 1
                counter = counter + 1
            else
                Xeer.demons_sorted[Xeer.sort_contains(v)].counter = Xeer.demons_sorted[Xeer.sort_contains(v)].counter + 1
            end
        end
    end
    Xeer.sorted_demon_count = #Xeer.demons_sorted
end

function Xeer.sort_contains(demon)
	--print('Xeer.sort_contains')
    for key,v in pairs(Xeer.demons_sorted) do
        if (v.name == demon.name and v.time == demon.time) then
            return key
        end
    end
    return - 1
end


function Xeer.SPairs(t, order)
	--print('Xeer.SPairs')
    local keys = {}
    for k in pairs(t) do keys[#keys + 1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]] --[[
       end
   end
end

function Xeer.SortComperator(t,a,b)
	--print('Xeer.SortComperator')
   return Xeer.get_remaining_time(t[b].name, t[b].time) > Xeer.get_remaining_time(t[a].name, t[a].time)
end




Xeer.pets = {
        ["Wild Imp"] = {55659, 99737, 113266},
				["Dreadstalker"] = {98035, 99738, 99736, 91907},
				["Imp"] = {416},
				["Felhunter"] = {417},
				["Succubus"] = {1863},
				["Felguard"] = {103673},
				["Darkglare"] = {103673},
				["Doomguard"] = {78158, 11859},
				["Infernal"] = {78217, 89},
				["Voidwalker"] = {1860},
}
Xeer.perma2 = {}
Xeer.perma2[416] = "Imp"
Xeer.perma2[417] = "Felhunter"
Xeer.perma2[1863] = "Succubus"
Xeer.perma2[17252] = "Felguard"
Xeer.perma2[78158] = "Doomguard"
Xeer.perma2[78217] = "Infernal"
Xeer.perma2[1860] = "Voidwalker"

function Xeer.locale()
	if GetLocale() == "enUS" then
		return 1
	end
	if GetLocale() == "ruRU" then
	return 2
	end
end

Xeer.durations = {}
Xeer.durations["Дикие бесы"] = 12
Xeer.durations["Зловещие охотники"] = 12
Xeer.durations["Бес"] = 25
Xeer.durations["Охотника скверны"] = 25
Xeer.durations["Суккуб"] = 25
Xeer.durations["Страж Скверны"] = 25
Xeer.durations["Созерцатель Тьмы"] = 12
Xeer.durations["Страж Ужаса"] = 25
Xeer.durations["Инфернал"] = 25
Xeer.durations["Демон Бездны"] = 25

--Xeer.demons_sorted = {}
--Xeer.sorted_demon_count = 0
--Xeer.minions = {"Дикие бесы", "Зловещие охотники", "Бес", "Охотника скверны", "Суккуб", "Страж Скверны", "Созерцатель Тьмы", "Страж Ужаса", "Инфернал", "Демон Бездны"}

--]]
