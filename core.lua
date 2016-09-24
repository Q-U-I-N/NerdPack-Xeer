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


function Xeer.ClassSetting(key)
	local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
	NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
end

function Xeer.dynEval(condition, spell)
	return Parse(condition, spell or '')
end

NeP.library.register('Xeer', Xeer)

function Xeer.Targeting()
	local exists = UnitExists("target")
	local hp = UnitHealth("target")
	if exists == false or (exists == true and hp < 1) then
		for i=1,#NeP.OM.unitEnemie do
			local Obj = NeP.OM.unitEnemie[i]	
			if Obj.distance <= 10 then
				RunMacroText("/tar " .. Obj.key)
				return true
			end
		end
	end
end

function Xeer.AoETaunt()
	--Warrior
	if select(3,UnitClass("player")) == 1 then 
		local spell = "Taunt"
	end
	--Paladin
	if select(3,UnitClass("player")) == 2 then 
		local spell = "Hand of Reckoning"
	end
	--Death Knight
	if select(3,UnitClass("player")) == 6 then 
		local spell = "Dark Command"
	end
	--Monk
	if select(3,UnitClass("player")) == 10 then 
		local spell = "Provoke"
	end
	--Druid
	if select(3,UnitClass("player")) == 11 then 
		local spell = "Growl"
	end
	--Demon Hunter
	if select(3,UnitClass("player")) == 12 then 
		local spell = "Torment"
	end
	local spellCooldown = NeP.DSL.Conditions['spell.cooldown']("player", spell)
	if spellCooldown > 0 then
		return false
	end
	for i=1,#NeP.OM.unitEnemie do
		local Obj = NeP.OM.unitEnemie[i]	
		local Threat = UnitThreatSituation("player", Obj.key)
		if Threat ~= nil and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
			NeP.Engine.Cast_Queue(spell, Obj.key)
			return true
		end
	end
end

NeP.DSL.RegisterConditon("petinmelee", function(target)
	if target then
		if IsHackEnabled then 
			return NeP.Engine.Distance('pet', target) < (UnitCombatReach('pet') + UnitCombatReach(target) + 1.5)
		else
			-- Unlockers wich dont have UnitCombatReach like functions...
			return NeP.Engine.Distance('pet', target) < 5
		end
	end
	return 0
end)

NeP.DSL.RegisterConditon("castwithin", function(target, spell)
	local SpellID = select(7, GetSpellInfo(spell))
	for k, v in pairs( NeP.ActionLog.log ) do
		local id = select(7, GetSpellInfo(v.description))
		if (id and id == SpellID and v.event == "Spell Cast Succeed") or tonumber( k ) == 20 then
			return tonumber( k )
		end
	end
	return 20
end)