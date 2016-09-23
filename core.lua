Xeer = {
	Version = 0.00001,
	Branch = 'BETA',
	Interface = {
		addonColor = 'ff6060',
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
		'ADots',
		'Interface\\Icons\\Ability_creature_cursed_05.png',
		'Automated Dotting',
		'Click here to dot all the things!')
end

function Xeer.ClassSetting(key)
	local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
	NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
end

function Xeer.dynEval(condition, spell)
	return Parse(condition, spell or '')
end

NeP.library.register('Xeer', {

	HolyNova = function(units)
		local minHeal = GetSpellBonusDamage(2) * 1.125
		local total = 0
		for i=1,#NeP.OM['unitFriend'] do
			local Obj = NeP.OM['unitFriend'][i]
			if Obj.distance <= 12 then
				if max(0, Obj.maxHealth - Obj.actualHealth) > minHeal then
					total = total + 1
				end
			end
		end
		return total > units
	end,

	instaKill = function(health)
		local Spell = NeP.Engine.Current_Spell
		if NeP.DSL.Conditions['toggle']('ADots') then
			for i=1,#NeP.OM['unitEnemie'] do
				local Obj = NeP.OM['unitEnemie'][i]
				if NeP.DSL.Conditions['health'](Obj.key) <= health then
					if IsSpellInRange(Spell, Obj.key)
					and NeP.Engine.Infront('player', Obj.key)
					and UnitCanAttack('player', Obj.key) then
						NeP.Engine.Macro('/target '..Obj.key)
						return true
					end
				end
			end
		else
			if NeP.DSL.Conditions['health']('target') <= health then
				if IsSpellInRange(Spell, 'target')
				and NeP.Engine.Infront('player', 'target')
				and UnitCanAttack('player', 'target') then
					return true
				end
			end
		end
		return false
	end,
	
	aoeExecute = function()
		local Spell = "Execute"
		if not IsUsableSpell(Spell) then return false end

		for i=1,#NeP.OM['unitEnemie'] do
			local Obj = NeP.OM['unitEnemie'][i]

			-- exclude the ones we can't hit
			if Obj.distance > 5 then
				return false
			end

			if UnitCanAttack('player', Obj.key)
			and NeP.Engine.Infront('player', Obj.key) 
			and Obj.health < 20 then
				NeP.Engine.ForceTarget = Obj.key
				return true
			end
		end

		return false
	end,

	areaRend = function(maxApplications, refreshAt)
		local Spell = "Rend"
		if not IsUsableSpell(Spell) then return false end
		local currentApplications = 0

		-- loop through all enemies and check if they have rend
		for i=1,#NeP.OM['unitEnemie'] do
			local Obj = NeP.OM['unitEnemie'][i]
			if (UnitAffectingCombat(Obj.key) or Obj.is == 'dummy') then
				if UnitDebuff(Obj.key, Spell, nil, 'PLAYER') then
					currentApplications = currentApplications + 1
				end
			end
		end

		-- check to see if the enemies with rend exceed or equal the max applications wanted
		if currentApplications >= maxApplications then
			return false
		else
			for i=1,#NeP.OM['unitEnemie'] do
				local Obj = NeP.OM['unitEnemie'][i]

				-- exclude the ones that we can't hit
				if Obj.distance > 5 then
					return false
				end

				if (UnitAffectingCombat(Obj.key) or Obj.is == 'dummy') then
					local _,_,_,_,_,_,debuffDuration = UnitDebuff(Obj.key, Spell, nil, 'PLAYER')
					if not debuffDuration or debuffDuration - GetTime() < refreshAt then
						if UnitCanAttack('player', Obj.key)
						and NeP.Engine.Infront('player', Obj.key) then
							NeP.Engine.ForceTarget = Obj.key
							return true
						end
					end
				end
			end
		end

		return false
	end,

	aDot = function(refreshAt)
		local Spell = NeP.Engine.Current_Spell
		if not IsUsableSpell(Spell) then return false end
		local _,_,_, SpellcastingTime = GetSpellInfo(Spell)
		local SpellcastingTime = SpellcastingTime * 0.001

		if NeP.DSL.Conditions['toggle']('ADots') then
			for i=1,#NeP.OM['unitEnemie'] do
				local Obj = NeP.OM['unitEnemie'][i]
				if (UnitAffectingCombat(Obj.key) or Obj.is == 'dummy') then
					local _,_,_,_,_,_,debuffDuration = UnitDebuff(Obj.key, Spell, nil, 'PLAYER')
					if not debuffDuration or debuffDuration - GetTime() < refreshAt then
						if UnitCanAttack('player', Obj.key)
						and NeP.Engine.Infront('player', Obj.key)
						and IsSpellInRange(Spell, Obj.key) then				
							if NeP.DSL.Conditions['ttd'](Obj.key) > ((debuffDuration or 0) + SpellcastingTime)
							or SpellcastingTime < 1 then
								NeP.Engine.ForceTarget = Obj.key
								return true
							end
						end
					end
				end
			end
		else
			local _,_,_,_,_,_,debuffDuration = UnitDebuff('target', Spell, nil, 'PLAYER')
			if not debuffDuration or debuffDuration - GetTime() < refreshAt then
				if IsSpellInRange(Spell, 'target')
				and NeP.Engine.Infront('player', 'target')
				and UnitCanAttack('player', 'target') then
					if NeP.DSL.Conditions['ttd']('target') > ((debuffDuration or 0) + SpellcastingTime)
					or SpellcastingTime < 1 then

						return true
					end
				end
			end
		end
		return false
	end

})

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