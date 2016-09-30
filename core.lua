Xeer = {
	Version = 0.00001,
	Branch = 'BETA',
	Interface = {
		addonColor = 'ADFF2F',
		Logo = NeP.Interface.Logo -- Temp until i get a logo
	},
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

NeP.library.register('Xeer', {

	Targeting = function()
		local exists = UnitExists('target')
		local hp = UnitHealth('target')
		if exists == false or (exists == true and hp < 1) then
			for i=1,#NeP.OM.unitEnemie do
				local Obj = NeP.OM.unitEnemie[i]	
				if Obj.distance <= 10 then
					RunMacroText('/tar ' .. Obj.key)
					return true
				end
			end
		end
	end
})
	
--[[
	AutoTaunt = function()
		local _,_,class = UnitClass('player')
		spell = classTaunt[class]
		local spellCooldown = NeP.DSL.Get('spell.cooldown')('player', spell)
		if spellCooldown > 0 then
			return false
		end
		for i=1,#NeP.OM.unitEnemie do
			local Obj = NeP.OM.unitEnemie[i]	
			local Threat = UnitThreatSituation('player', Obj.key)
			if Threat ~= nil and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
				NeP.Engine.Cast_Queue(spell, Obj.key)
				return true
			end
		end
	end
--]]


--[[	
--/dump NeP.DSL.Conditions['focus_deficit']('player')
NeP.DSL.RegisterConditon('rage_deficit', function(target)
	local max = UnitPowerMax(target, SPELL_POWER_RAGE)
	local curr = UnitPower(target, SPELL_POWER_RAGE)
	return (max - curr)
end)

NeP.DSL.RegisterConditon('focus_deficit', function(target)
	local max = UnitPowerMax(target, SPELL_POWER_FOCUS)
	local curr = UnitPower(target, SPELL_POWER_FOCUS)
	return (max - curr)
end)
--]]

--/dump NeP.DSL.Conditions['deficit']('player')
NeP.DSL.RegisterConditon('deficit', function(target, spell)
	local max = UnitPowerMax(target)
	local curr = UnitPower(target)
	return (max - curr)
end)

NeP.DSL.RegisterConditon('equipped', function(target, item)
	if IsEquippedItem(item) == true then return true else return false end
end)

NeP.DSL.RegisterConditon('execute_time', function(target, spell)
--TODO:fix for rogues and feral form
	local GCD = math.floor((1.5 / ((GetHaste() / 100) + 1)) * 10^3 ) / 10^3	
	local name, rank, icon, cast_time, min_range, max_range = GetSpellInfo(spell)
	local ctt = math.floor((cast_time / 1000) * 10^3 ) / 10^3
		if ctt > GCD then
			return ctt
		else
			return GCD
		end
end)

NeP.DSL.RegisterConditon('xinfront.enemies', function(unit, distance)
	local total = 0
	if not UnitExists(unit) then return total end
	for i=1, #NeP.OM['unitEnemie'] do
		local Obj = NeP.OM['unitEnemie'][i]
		if UnitExists(Obj.key) and (UnitAffectingCombat(Obj.key) or isDummy(Obj.key))
		and NeP.Engine.Distance(unit, Obj.key) <= tonumber(distance) then
			if NeP.Engine.Infront('player', Obj.key) then
				total = total +1
			end
		end
	end
	return total
end)

NeP.DSL.RegisterConditon('xmoving', function(target)
	local speed, _ = GetUnitSpeed(target)
		if speed ~= 0 then
			return 1 
		else
			return 0
		end
end)

NeP.DSL.RegisterConditon('cast_regen', function(target, spell)
	local regen = select(2, GetPowerRegen(target))
	local _, _, _, cast_time = GetSpellInfo(spell)
	return math.floor(((regen * cast_time) / 1000) * 10^3 ) / 10^3
end)

---------------------------------SIMC NAMES---------------------------------
--[[
NeP.DSL.RegisterConditon("buff.stack", function(target, spell)
	local buff,stack,_,caster = NeP.APIs['UnitBuff'](target, spell)
	if not not buff and (caster == 'player' or caster == 'pet') then
		return stack
	end
	return 0
end)

NeP.DSL.RegisterConditon("buff.remains", function(target, spell)
	local buff,_,expires,caster = NeP.APIs['UnitBuff'](target, spell)
	if buff and (caster == 'player' or caster == 'pet') then
		return (expires - GetTime())
	end
	return 0
end)

NeP.DSL.RegisterConditon("debuff.stack", function(target, spell)
	local debuff,stack,_,caster = NeP.APIs['UnitDebuff'](target, spell)
	if not not debuff and (caster == 'player' or caster == 'pet') then
		return stack
	end
	return 0
end)

NeP.DSL.RegisterConditon("debuff.remains", function(target, spell)
	local debuff,_,expires,caster = NeP.APIs['UnitDebuff'](target, spell)
	if debuff and (caster == 'player' or caster == 'pet') then
		return (expires - GetTime())
	end
	return 0
end)
]]--