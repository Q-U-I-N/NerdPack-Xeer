local _, Xeer = ...

Xeer.Version = '1.6.4'
Xeer.Branch = 'RELEASE'
Xeer.Name = 'NerdPack - Xeer Routines'
Xeer.Author = 'Xeer'
Xeer.addonColor = 'ADFF2F'
Xeer.Logo = 'Interface\\AddOns\\NerdPack-Xeer\\media\\logo.blp'
Xeer.Splash = 'Interface\\AddOns\\NerdPack-Xeer\\media\\splash.blp'

local frame = CreateFrame('GameTooltip', 'NeP_ScanningTooltip', UIParent, 'GameTooltipTemplate')

Xeer.class = select(3,UnitClass("player"))



--[[
	local classTaunt = {
		[1] = 'Taunt',
		[2] = 'Hand of Reckoning',
		[6] = 'Dark Command',
		[10] = 'Provoke',
		[11] = 'Growl',
		[12] = 'Torment'
	}
--]]

	-- Temp Hack
function Xeer.ExeOnLoad()
		Xeer.Splash()

		NeP.Interface:AddToggle({
			key = 'xopener',
			name = 'Opener rotation',
			text = 'Start opener rotation',
			icon = 'Interface\\Icons\\Ability_warrior_charge',
		})
--[[
		NeP.Interface:AddToggle({
			key = 'AutoTarget',
			name = 'Auto Target',
			text = 'Automatically target the nearest enemy when target dies or does not exist',
			icon = 'Interface\\Icons\\ability_hunter_snipershot',
		})
--]]
end

function Xeer.ClassSetting(key)
		local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
		NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
end

function Xeer.Taunt(eval, args)
	local spell = NeP.Engine:Spell(args)
	if not spell then return end
	for i=1,#NeP.OM['unitEnemie'] do
		local Obj = NeP.OM['unitEnemie'][i]
		local Threat = UnitThreatSituation('player', Obj.key)
		if Threat and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
			eval.spell = spell
			eval.target = Obj.key
			return NeP.Engine:STRING(eval)
		end
	end
end


function Xeer.Round(num, idp)
	if num then
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	else
		return 0
	end
end

function Xeer.ShortNumber(number)
    local affixes = { "", "k", "m", "b", }
    local affix = 1
    local dec = 0
    local num1 = math.abs(number)
    while num1 >= 1000 and affix < #affixes do
        num1 = num1 / 1000
        affix = affix + 1
    end
    if affix > 1 then
        dec = 2
        local num2 = num1
        while num2 >= 10 do
            num2 = num2 / 10
            dec = dec - 1
        end
    end
    if number < 0 then
        num1 = - num1
    end
    return string.format("%."..dec.."f"..affixes[affix], num1)
end

--------------------------------------------------------------------------------
--------------------------NeP CombatHelper Targeting ---------------------------
--------------------------------------------------------------------------------
--[[ disabled for now

local NeP_forceTarget = {
	-- WOD DUNGEONS/RAIDS
	[75966] = 100,	-- Defiled Spirit (Shadowmoon Burial Grounds)
  [75911] = 100,	-- Defiled Spirit (Shadowmoon Burial Grounds)
}

local function getTargetPrio(Obj)
	local objectType, _, _, _, _, npc_id, _ = strsplit('-', UnitGUID(Obj))
	local ID = tonumber(npc_id) or '0'
	local prio = 1
	-- Elite
	if NeP.DSL:Get('elite')(Obj) then
		prio = prio + 30
	end
	-- If its forced
	if NeP_forceTarget[tonumber(Obj)] ~= nil then
		prio = prio + NeP_forceTarget[tonumber(Obj)]
	end
	return prio
end

function Xeer.Targeting()
    -- If dont have a target, target is friendly or dead
    if not UnitExists('target') or UnitIsFriend('player', 'target') or UnitIsDeadOrGhost('target') then
        local setPrio = {}
        for GUID, Obj in pairs(NeP.OM:Get('Enemy')) do
            if UnitExists(Obj.key) and Obj.distance <= 40 then
                if (UnitAffectingCombat(Obj.key) or NeP.DSL:Get('isdummy')(Obj.key))
                and NeP.Protected:LineOfSight('player', Obj.key) then
                    setPrio[#setPrio+1] = {
                        key = Obj.key,
                        bonus = getTargetPrio(Obj.key),
                        name = Obj.name
                    }
                end
            end
        end
        table.sort(setPrio, function(a,b) return a.bonus > b.bonus end)
        if setPrio[1] then
            NeP.Protected.Macro('/target '..setPrio[1].key)
        end
    end
end,
}


--]]

--------------------------------------------------------------------------------
----------------------------------ToolTips--------------------------------------
--------------------------------------------------------------------------------

--/dump Xeer.Scan_SpellCost('Rip')
function Xeer.Scan_SpellCost(spell)
	local spell = NeP.Core:GetSpellID(NeP.Core:GetSpellName(spell))
	frame:SetOwner(UIParent, 'ANCHOR_NONE')
	frame:SetSpellByID(spell)
	for i = 2, frame:NumLines() do
		local tooltipText = _G['NeP_ScanningTooltipTextLeft' .. i]:GetText()
		return tooltipText
	end
	return false
end

--/dump Xeer.Scan_IgnorePain()
function Xeer.Scan_IgnorePain()
	for i = 1, 40 do
		local qqq = select(11,UnitBuff('player', i))
		if qqq == 190456 then
			frame:SetOwner(UIParent, 'ANCHOR_NONE')
			frame:SetUnitBuff('player', i)
			local tooltipText = _G['NeP_ScanningTooltipTextLeft2']:GetText()
			local match = tooltipText:lower():match('of the next.-$')
    	return gsub(match, '%D', '') + 0
		end
	end
	return false
end

--------------------------------------------------------------------------------
-------------------------------NeP HoT / DoT API -------------------------------
--------------------------------------------------------------------------------

local function oFilter(owner, spell, spellID, caster)
	if not owner then
		if spellID == tonumber(spell) and (caster == 'player' or caster == 'pet') then
			return false
		end
	elseif owner == 'any' then
		if spellID == tonumber(spell) then
			return false
		end
	end
	return true
end

function Xeer.UnitHot(target, spell, owner)
	local name, count, caster, expires, spellID
	if tonumber(spell) then
		local go, i = true, 0
		while i <= 40 and go do
			i = i + 1
			name,_,_,count,_,duration,expires,caster,_,_,spellID = _G['UnitBuff'](target, i)
			go = oFilter(owner, spell, spellID, caster)
		end
	else
		name,_,_,count,_,duration,expires,caster = _G['UnitBuff'](target, spell)
	end
	-- This adds some random factor
		return name, count, expires, caster
end

function Xeer.UnitDot(target, spell, owner)
	local name, count, caster, expires, spellID, power
	if tonumber(spell) then
		local go, i = true, 0
		while i <= 40 and go do
			i = i + 1
			name,_,_,count,_,duration,expires,caster,_,_,spellID,_,_,_,power = _G['UnitDebuff'](target, i)
			go = oFilter(owner, spell, spellID, caster)
		end
	else
		name,_,_,count,_,duration,expires,caster = _G['UnitDebuff'](target, spell)
	end
	-- This adds some random factor
		return name, count, duration, expires, caster, power
end

--------------------------------------------------------------------------------
-------------------------------- WARRIOR ---------------------------------------
--------------------------------------------------------------------------------

--/dump Xeer.getIgnorePain()
function Xeer.getIgnorePain()
		--output
		local matchTooltip = false
		local showPercentage = false
		local simpleOutput = false
		--Rage
    local curRage = UnitPower('player')
    local costs = GetSpellPowerCost(190456)
    local minRage = costs[1].minCost or 20
    local maxRage = costs[1].cost or 60
    local calcRage = math.max(minRage, math.min(maxRage, curRage))

    --attack power
    local apBase, apPos, apNeg = UnitAttackPower('player')

    --Versatility rating
    local vers = 1 + ((GetCombatRatingBonus(29) + GetVersatilityBonus(30)) / 100)

--[[
    --Dragon Skin
    --check artifact traits
    local currentRank = 0
    local loaded = true
    if loaded then
        artifactID = NeP.DSL:Get('artifact.active_id')()
        if not artifactID then
            NeP.DSL:Get['artifact.force_update']()
        end
        local _, traits = NeP.DSL:Get('artifact.traits')(artifactID)
        if traits then
            for _,v in ipairs(traits) do
                if v.spellID == 203225 then
                    currentRank = v.currentRank
                    break
                end
            end
        end
    end
    local trait = 1 + 0.02 * currentRank
--]]

    --Dragon Scales
    local scales = UnitBuff('player', GetSpellInfo(203581)) and 1.6 or 1

    --Never Surrender
    local curHP = UnitHealth('player')
    local maxHP = UnitHealthMax('player')
    local misPerc = (maxHP - curHP) / maxHP
    local nevSur = select(4, GetTalentInfo(5, 2, 1))
    local nevSurPerc = nevSur and (1 + 0.75 * misPerc) or 1

    --Indomitable
    local indom = select(4, GetTalentInfo(5, 3, 1)) and 1.25 or 1

		--T18
    local t18 = UnitBuff("player", GetSpellInfo(12975)) and Xeer.GetNumberSetPieces("T18") >= 4 and 2 or 1

    local curIP = select(17, UnitBuff('player', GetSpellInfo(190456))) or 0
    if matchTooltip then
        curIP = curIP / 0.9 --get the tooltip value instead of the absorb
    end

    local maxIP = (apBase + apPos + apNeg) * 18.6 * vers * indom * scales
    if  not matchTooltip then --some TODO notes so i wont forget fix it:
        --maxIP = Xeer.Round(maxIP * 0.9) - missing dragon skin arti passive -> * trait!!! missing 0.02-0.06
				maxIP = Xeer.Round(maxIP * 1.04) -- tooltip value my test with 2/3 dragon skin
				--maxIP = Xeer.Round((maxIP * 0.9) * trait) -- need enable after got arti lib again
    end

    local newIP = Xeer.Round(maxIP * (calcRage / maxRage) * 1 * nevSurPerc * t18) --*t18 *trait instead 1

    local cap = Xeer.Round(maxIP * 3)
    if nevSur then
        cap = cap * 1.75
    end

    local diff = cap - curIP

    local castIP = math.min(diff, newIP)

    local castPerc = Xeer.Round((castIP / cap) * 100)
    local curPerc = Xeer.Round((curIP / cap) * 100)

--[[
    if showPercentage then
        if simpleOutput then
            return string.format('|c%s%.1f%%%%|r', color, curPerc*100)
        end
        return string.format('|c%s%.1f%%%%|r\n%.1f%%%%', color, castPerc*100, curPerc*100)
    end
    if simpleOutput then
        return string.format('|c%s%s|r', color, shortenNumber(curIP))
    end
    return string.format('|c%s%s|r\n%s', color, shortenNumber(castIP), shortenNumber(curIP))
--]]
	return cap, diff, curIP, curPerc, castIP, castPerc, maxIP, newIP, minRage, maxRage, calcRage
--maxIP = 268634.7
end

--set bonuses
--/dump Xeer.GetNumberSetPieces('T18', 'WARRIOR')
function Xeer.GetNumberSetPieces(set, class)
    class = class or select(2, UnitClass("player"))
    local pieces = Xeer.sets[class][set] or {}
    local counter = 0
    for _, itemID in ipairs(pieces) do
        if IsEquippedItem(itemID) then
            counter = counter + 1
        end
    end
    return counter
end

Xeer.sets = {
    ["WARRIOR"] = {
        ["T18"] = {
            124319,
            124329,
            124334,
            124340,
            124346,
        },
    },
}

--------------------------------------------------------------------------------
-------------------------------- WARLOCK ---------------------------------------
--------------------------------------------------------------------------------


Xeer.durations = {}
Xeer.durations["Wild Imp"] = 12
Xeer.durations["Dreadstalker"] = 12
Xeer.durations["Imp"] = 25
Xeer.durations["Felhunter"] = 25
Xeer.durations["Succubus"] = 25
Xeer.durations["Felguard"] = 25
Xeer.durations["Darkglare"] = 12
Xeer.durations["Doomguard"] = 25
Xeer.durations["Infernal"] = 25
Xeer.durations["Voidwalker"] = 25

Xeer.active_demons = {}
Xeer.empower = 0
Xeer.demon_count = 0

Xeer.minions = {"Wild Imp", "Dreadstalker", "Imp", "Felhunter", "Succubus", "Felguard", "Darkglare", "Doomguard", "Infernal", "Voidwalker"}

function Xeer.update_demons()
	--print('Xeer.update_demons')
    for key,value in pairs(Xeer.active_demons) do
        if (Xeer.is_demon_dead(Xeer.active_demons[key].name, Xeer.active_demons[key].time)) then
            Xeer.active_demons[key] = nil
            Xeer.demon_count = Xeer.demon_count - 1
            --Xeer.sort_demons()
        end
    end
end

function Xeer.is_demon_empowered(guid)
	--print('Xeer.is_demon_empowered')
    if (Xeer.active_demons[guid].empower_time ~= 0 and GetTime() -  Xeer.active_demons[guid].empower_time <= 12) then
        return true
    end
    return false
end

function Xeer.Empower()
	--print('Xeer.Empower')
	if Xeer.demon_count == 0 and UnitExists("pet") then
		Xeer.empower = NeP.DSL:Get('buff.remains')('pet','Demonic Empowerment')
		return Xeer.empower
	end
	if Xeer.demon_count > 0 then
		for _,v in pairs(Xeer.active_demons) do
			if Xeer.is_demon_empowered(v.guid) then
					emp1 = Xeer.get_remaining_time('Empower', v.empower_time)
					emp2 = NeP.DSL:Get('buff.remains')('pet','Demonic Empowerment')
					if emp1 < emp2 then
						Xeer.empower = emp1
					else
						Xeer.empower = emp2
					end
			else
				Xeer.empower = 0
			end
		end
	end
return Xeer.empower
end

function Xeer.count_active_demon_type(demon)
	--print('Xeer.count_active_demon_type')
	local count = 0
    for _,v in pairs(Xeer.active_demons) do
        if v.name == demon then
          count = count + 1
        end
    end
		return count
end

function Xeer.remaining_duration(demon)
	--print('Xeer.remaining_duration')
		for _,v in pairs(Xeer.active_demons) do
        if v.name == demon then
				  return Xeer.get_remaining_time(v.name, v.time)
        end
		end
end

function Xeer.implosion_cast()
	--print('Xeer.implosion_cast')
    for key,v in pairs(Xeer.active_demons) do
			if (Xeer.active_demons[key].name == "Wild Imp") then
      --  if (Xeer.active_demons[key].name == "Дикие бесы") then
            Xeer.active_demons[key] = nil
            Xeer.demon_count = Xeer.demon_count - 1
            --Xeer.sort_demons()
        end
    end
end

function Xeer.is_demon_dead(name, spawn)
	--print('Xeer.is_demon_dead')
    if (Xeer.get_remaining_time(name, spawn) <= 0) then
        return true
    end
    return false
end

function Xeer.get_remaining_time(name, spawn)
	--print('Xeer.get_remaining_time')
	if name == 'Empower' then
		 return 12 - (GetTime() - spawn)
	else
    return Xeer.durations[name] - (GetTime() - spawn)
	end
end


function Xeer.IsMinion(name)
	--print('Xeer.IsMinion')
    for i = 1, #Xeer.minions do
        if (name == Xeer.minions[i]) then
            return true
        end
    end
    return false
end

--------------------------------------------------------------------------------
-------------------------------- TRAVEL SPEED-----------------------------------
--------------------------------------------------------------------------------

-- List of know spells travel speed. Non charted spells will be considered traveling 40 yards/s
-- To recover travel speed, open up /eventtrace, calculate difference between SPELL_CAST_SUCCESS and SPELL_DAMAGE events



local Travel_Chart = {
	[116] = 25, -- Frostbolt
	[11366] = 52, -- Pyroblast
	[29722] = 18, -- Incinerate
	[30455] = 39, -- Ice Lance
	[105174] = 33, -- Hand of Gul'dan
	[120644] = 10, -- Halo
	[122121] = 25, -- Divine Star
	[127632] = 19, -- Cascade
	[210714] = 38, -- Icefury
	[51505] = 38.0902, -- Lava Burst
	[205181] = 32.737266, -- Shadowflame
--...etc
};

-- Return the time a spell will need to travel to the current target
function Xeer.TravelTime(spellID)
	TravelSpeed = Travel_Chart[spellID] or 40
	return NeP.DSL:Get("distance")('target') / TravelSpeed
end

--[[

--Travel Time Track Listener--
Xeer.TTTL_table = {}
Xeer.TTTL_enable = false


--/dump NeP.DSL:Get('tttlz')()
function Xeer.TTTL_calc_tt()
			for k,v in pairs(Xeer.TTTL_table) do
	        if k and v.finish then
					  v.travel_time = v.finish - v.start
						if v.travel_time ~= 0 then
							v.travel_speed = v.distance / v.travel_time
							local write_it = "["..v.spellID.."] = "..v.travel_speed..", -- "..v.name.."\n"
							print(write_it)
							--WriteFile('testwrite.lua', write_it, true)
						end
						wipe(Xeer.TTTL_table)
	        end
			end
end
--]]

--------------------------------------------------------------------------------
-------------------------------- LISTENER --------------------------------------
--------------------------------------------------------------------------------

NeP.Listener:Add('Xeer_Listener', 'COMBAT_LOG_EVENT_UNFILTERED', function(timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount, ...)

	if Xeer.class == 9 then
    if (combatevent == "SPELL_SUMMON" and sourceName == UnitName("player")) then
			if (Xeer.IsMinion(destName)) then
            Xeer.active_demons[destGUID] = {}
            Xeer.active_demons[destGUID].guid = destGUID
            Xeer.active_demons[destGUID].name = destName
            Xeer.active_demons[destGUID].time = GetTime()
            Xeer.active_demons[destGUID].empower_time = 0
            Xeer.active_demons[destGUID].duration = Xeer.durations[destName]
            Xeer.demon_count = Xeer.demon_count + 1
            --Xeer.sort_demons()
        end
    end

    if ((combatevent == "SPELL_AURA_APPLIED" or combatevent == "SPELL_AURA_REFRESH") and spellID == 193396 and sourceName == UnitName("player")) then
			print('Demonic Empowerment')
				if(Xeer.IsMinion(destName)) then
            Xeer.active_demons[destGUID].empower_time = GetTime()
        end
    end

    if (combatevent == "SPELL_CAST_SUCCESS" and spellID == 196277 and sourceName == UnitName("player")) then
			print('Implosion')
				Xeer.implosion_cast()
    end
	Xeer.update_demons()
	return true
	end
end)

--[[
NeP.Listener:Add('Xeer_Listener2', 'COMBAT_LOG_EVENT_UNFILTERED', function(timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount, ...)
	if Xeer.TTTL_enable == true then
		if (combatevent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player")) then
			if uniqID == nil then uniqID = 0 end
				uniqID = uniqID + 1
				Xeer.TTTL_table[uniqID] = {}
				Xeer.TTTL_table[uniqID].name = spellName
				Xeer.TTTL_table[uniqID].spellID = spellID
				Xeer.TTTL_table[uniqID].start = GetTime()
				Xeer.TTTL_table[uniqID].distance = NeP.DSL:Get('range')('target')
				mirror_name = spellName
    end
		if (combatevent == "SPELL_DAMAGE" and spellName == mirror_name and sourceName == UnitName("player")) then
			Xeer.TTTL_table[uniqID].finish = GetTime()
			Xeer.TTTL_table[uniqID].travel_time = 0
			Xeer.TTTL_table[uniqID].travel_speed = 0
			Xeer.TTTL_calc_tt()
    end
	end
end)
--]]

NeP.Library:Add('Xeer', Xeer)
