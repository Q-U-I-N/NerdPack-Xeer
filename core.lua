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
		local Threat = UnitThreatSituation("player", Obj.key)
		if Threat and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
			eval.spell = spell
			eval.target = Obj.key
			return NeP.Engine:STRING(eval)
		end
	end
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
--------------------------NeP CombatHelper Targeting --------------------------
