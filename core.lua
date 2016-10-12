Xeer = {
		Version = 0.01,
		Branch = 'BETA',
		Name = 'NerdPack- Xeer Routines',
		Author = 'Xeer',
		Interface = {
			addonColor = 'ADFF2F',
			Logo = 'Interface\\AddOns\\NerdPack-Xeer\\media\\logo.blp',
			Splash = 'Interface\\AddOns\\NerdPack-Xeer\\media\\splash.blp'
		},
		frame = CreateFrame('GameTooltip', 'NeP_ScanningTooltip', UIParent, 'GameTooltipTemplate')
}

--local frame = CreateFrame('GameTooltip', 'NeP_ScanningTooltip', UIParent, 'GameTooltipTemplate')
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
	Xeer.ExeOnLoad = function()
		Xeer.Splash()
		NeP.Interface:AddToggle({
			key = 'AutoTarget',
			name = 'Auto Target',
			text = 'Automatically target the nearest enemy when target dies or does not exist',
			icon = 'Interface\\Icons\\ability_hunter_snipershot',
		})
	end

	Xeer.ClassSetting = function(key)
		local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
		NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
	end
--[[
	Xeer.dynEval(condition, spell)
		return Parse(condition, spell or '')
	end
--]]
	Xeer.Taunt = function(eval, args)
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


Xeer.Round = function(num, idp)
	if num then
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	else
		return 0
	end
end

Xeer.ShortNumber = function(number)
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

----------------------------------ToolTips-------------------------------------
--/dump Xeer.Scan_SpellCost('Rip')
Xeer.Scan_SpellCost = function(spell)
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
Xeer.Scan_IgnorePain = function()
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

--------------------------NeP CombatHelper Targeting --------------------------
--[[
	local NeP_forceTarget = {
		-- WOD DUNGEONS/RAIDS
		[75966] = 100,	-- Defiled Spirit (Shadowmoon Burial Grounds)
		[76220] = 100,	-- Blazing Trickster (Auchindoun Normal)
		[76222] = 100,	-- Rallying Banner (UBRS Black Iron Grunt)
		[76267] = 100,	-- Solar Zealot (Skyreach)
		[76518] = 100,	-- Ritual of Bones (Shadowmoon Burial Grounds)
		[77252] = 100,	-- Ore Crate (BRF Oregorger)
		[77665] = 100,	-- Iron Bomber (BRF Blackhand)
		[77891] = 100,	-- Grasping Earth (BRF Kromog)
		[77893] = 100,	-- Grasping Earth (BRF Kromog)
		[86752] = 100,	-- Stone Pillars (BRF Mythic Kromog)
		[78583] = 100,	-- Dominator Turret (BRF Iron Maidens)
		[78584] = 100,	-- Dominator Turret (BRF Iron Maidens)
		[79504] = 100,	-- Ore Crate (BRF Oregorger)
		[79511] = 100,	-- Blazing Trickster (Auchindoun Heroic)
		[81638] = 100,	-- Aqueous Globule (The Everbloom)
		[86644] = 100,	-- Ore Crate (BRF Oregorger)
		[94873] = 100,	-- Felfire Flamebelcher (HFC)
		[90432] = 100,	-- Felfire Flamebelcher (HFC)
		[95586] = 100,	-- Felfire Demolisher (HFC)
		[93851] = 100,	-- Felfire Crusher (HFC)
		[90410] = 100,	-- Felfire Crusher (HFC)
		[94840] = 100,	-- Felfire Artillery (HFC)
		[90485] = 100,	-- Felfire Artillery (HFC)
		[93435] = 100,	-- Felfire Transporter (HFC)
		[93717] = 100,	-- Volatile Firebomb (HFC)
		[188293] = 100,	-- Reinforced Firebomb (HFC)
		[94865] = 100,	-- Grasping Hand (HFC)
		[93838] = 100,	-- Grasping Hand (HFC)
		[93839] = 100,	-- Dragging Hand (HFC)
		[91368] = 100,	-- Crushing Hand (HFC)
		[94455] = 100,	-- Blademaster Jubei'thos (HFC)
		[90387] = 100,	-- Shadowy Construct (HFC)
		[90508] = 100,	-- Gorebound Construct (HFC)
		[90568] = 100,	-- Gorebound Essence (HFC)
		[94996] = 100,	-- Fragment of the Crone (HFC)
		[95656] = 100,	-- Carrion Swarm (HFC)
		[91540] = 100,	-- Illusionary Outcast (HFC)
	}

	local function getTargetPrio(Obj)
		local objectType, _, _, _, _, _id, _ = strsplit('-', UnitGUID(Obj))
		local ID = tonumber(_id) or '0'
		local prio = 1
		-- Elite
		if NeP.DSL.Conditions['elite'](Obj) then
			prio = prio + 30
		end
		-- If its forced
		if NeP_forceTarget[tonumber(Obj)] ~= nil then
			prio = prio + NeP_forceTarget[tonumber(Obj)]
		end
		return prio
	end

	Xeer.Targeting()
		-- If dont have a target, target is friendly or dead
		if not UnitExists('target') or UnitIsFriend('player', 'target') or UnitIsDeadOrGhost('target') then
			local setPrio = {}
			for i=1,#NeP.OM['unitEnemie'] do
				local Obj = NeP.OM['unitEnemie'][i]
				if UnitExists(Obj.key) and Obj.distance <= 40 then
					if (UnitAffectingCombat(Obj.key) or isDummy(Obj.key))
					and NeP.Engine.LineOfSight('player', Obj.key) then
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
				NeP.Engine.Macro('/target '..setPrio[1].key)
			end
		end
	end
--]]

-------------------------------NeP HoT / DoT API -------------------------------

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

Xeer.UnitHot = function(target, spell, owner)
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

Xeer.UnitDot = function(target, spell, owner)
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


-------------------------------- WARRIOR ---------------------------------------

--/dump Xeer.getIgnorePain()
Xeer.getIgnorePain = function()
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
        artifactID = NeP.DSL:Get['artifact.active_id']()
        if not artifactID then
            NeP.DSL:Get['artifact.force_update']()
        end
        local _, traits = NeP.DSL:Get['artifact.traits'](artifactID)
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
Xeer.GetNumberSetPieces = function(set, class)
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
