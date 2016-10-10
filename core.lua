Xeer = {
	Version = 0.00001,
	Branch = 'BETA',
	Interface = {
		addonColor = 'ADFF2F',
		Logo = NeP.Interface.Logo -- Temp until i get a logo
	},
	frame = CreateFrame('GameTooltip', 'NeP_ScanningTooltip', UIParent, 'GameTooltipTemplate')
}

-- Core version check
if NeP.Info.Version >= 70.8 then
	NeP.Core.Print('Loaded |T'..Xeer.Interface.Logo..':10:10|t[|cff'..Xeer.Interface.addonColor..'Xeer|r] Combat-Routines v:'..Xeer.Version)
else
	NeP.Core.Print('Failed to load Xeer Combat Routines.\nYour Core is outdated.')
	return
end

local Parse = NeP.DSL.Parse
local Fetch = NeP.Interface.fetchKey

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

NeP.library.register('Xeer', Xeer)

	-- Temp Hack
	function Xeer.Splash()
		NeP.Interface.CreateToggle(
			'AutoTarget',
			'Interface\\Icons\\ability_hunter_snipershot',
			'Auto Target',
			'Automatically target the nearest enemy when target dies or does not exist')
	end

	function Xeer.ClassSetting(key)
		local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
		NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
	end

	function Xeer.dynEval(condition, spell)
		return Parse(condition, spell or '')
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

--[[
function Xeer.Round(num, idp)
	if num then
		local mult = 10^(idp or 0)
		return math.floor(num * mult + 0.5) / mult
	else
		return 0
	end
end
--]]
----------------------------------ToolTips-------------------------------------
--/dump Xeer:Scan_SpellCost('Rip')
function Xeer:Scan_SpellCost(spell)
	local spell = GetSpellID(GetSpellName(spell))
	self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
	self.frame:SetSpellByID(spell)
	for i = 2, self.frame:NumLines() do
		local tooltipText = _G['NeP_ScanningTooltipTextLeft' .. i]:GetText()
		return tooltipText
	end
	return false
end

--/dump Xeer:Scan_IgnorePain()
function Xeer:Scan_IgnorePain()
	for i = 1, 40 do
		local qqq = select(11,UnitBuff('player', i))
		if qqq == 190456 then
			self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
			self.frame:SetUnitBuff('player', i)
			local tooltipText = _G['NeP_ScanningTooltipTextLeft2']:GetText()
			local match = tooltipText:lower():match('of the next.-$')
    	return gsub(match, '%D', '') + 0
		end
	end
	return false
end

--------------------------NeP CombatHelper Targeting --------------------------

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

	function Xeer.Targeting()
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

-------------------------------NeP HoT / DoT API -------------------------------

local function rFilter(expires, duration)
	if expires and expires ~= 0 then
		return (expires - GetTime()) < GetReactionTime()
	end
end

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

 Xeer['UnitHot'] = function(target, spell, owner)
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
	if name and not rFilter(expires, duration) then
		return name, count, expires, caster
	end
end

 Xeer['UnitDot'] = function(target, spell, owner)
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
	if name and not rFilter(expires, duration) then
		return name, count, duration, expires, caster, power
	end
end


--/dump Xeer.getIgnorePain()
function Xeer.getIgnorePain()
		--output
		local matchTooltip = false
		local showPercentage = false
		local simpleOutput = false
		--Rage
    local curRage = UnitPower("player")
    local costs = GetSpellPowerCost(190456)
    local minRage = costs[1].minCost or 20
    local maxRage = costs[1].cost or 60
    local calcRage = math.max(minRage, math.min(maxRage, curRage))

    --attack power
    local apBase, apPos, apNeg = UnitAttackPower("player")

    --Versatility rating
    local vers = 1 + ((GetCombatRatingBonus(29) + GetVersatilityBonus(30)) / 100)

    --Dragon Skin
    --check artifact traits
    local currentRank = 0
    local loaded = true
    if loaded then
        artifactID = NeP.DSL.Conditions['artifact.active_id']()
        if not artifactID then
            NeP.DSL.Conditions['artifact.force_update']()
        end
        local _, traits = NeP.DSL.Conditions['artifact.traits'](artifactID)
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

    --Dragon Scales
    local scales = UnitBuff("player", GetSpellInfo(203581)) and 1.6 or 1

    --Never Surrender
    local curHP = UnitHealth("player")
    local maxHP = UnitHealthMax("player")
    local misPerc = (maxHP - curHP) / maxHP
    local nevSur = select(4, GetTalentInfo(5, 2, 1))
    local nevSurPerc = nevSur and (1 + 0.75 * misPerc) or 1

    --Indomitable
    local indom = select(4, GetTalentInfo(5, 3, 1)) and 1.25 or 1

    --T18
    ---local t18 = UnitBuff("player", GetSpellInfo(12975)) and Xeer.GetNumSetPieces("T18") >= 4 and 2 or 1



    local curIP = select(17, UnitBuff("player", GetSpellInfo(190456))) or 0
    if matchTooltip then
        curIP = curIP / 0.9 --get the tooltip value instead of the absorb
    end

    local maxIP = (apBase + apPos + apNeg) * 18.6 * vers * indom * scales
    if not matchTooltip then
        maxIP = NeP.Core.Round(maxIP * 0.9)
    end

    local newIP = NeP.Core.Round(maxIP * (calcRage / maxRage) * trait * nevSurPerc) --*t18

    local cap = NeP.Core.Round(maxIP * 3)
    if nevSur then
        cap = cap * 1.75
    end

    local diff = cap - curIP

    local castIP = math.min(diff, newIP)

    local castPerc = NeP.Core.Round((castIP / cap) * 100)
    local curPerc = NeP.Core.Round((curIP / cap) * 100)

--[[
    if showPercentage then
        if simpleOutput then
            return string.format("|c%s%.1f%%%%|r", color, curPerc*100)
        end
        return string.format("|c%s%.1f%%%%|r\n%.1f%%%%", color, castPerc*100, curPerc*100)
    end
    if simpleOutput then
        return string.format("|c%s%s|r", color, shortenNumber(curIP))
    end
    return string.format("|c%s%s|r\n%s", color, shortenNumber(castIP), shortenNumber(curIP))
--]]
	return cap, diff, curIP, curPerc, castIP, castPerc, maxIP, newIP, minRage, maxRage, calcRage
--maxIP = 268634.7
end
