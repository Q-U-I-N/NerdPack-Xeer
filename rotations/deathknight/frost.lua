local _, Xeer = ...

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print("|cffADFF2F ---------------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rDEATH KNIGHT |cffADFF2FFrost (MACHINEGUN =v required talets v=) |r")
	print("|cffADFF2F --- |rFf you want use MACHINEGUN =v required talets v= AND enable toggle button) |r")
	print("|cffADFF2F --- |rRecommended Talents:  1/2 - 2/2 - 3/3 - 4/X - 5/X - 6/1 - 7/3")
	print("|cffADFF2F ---------------------------------------------------------------------------|r")

	NeP.Interface:AddToggle({
		key = 'xMACHINEGUN',
		name = 'MACHINEGUN',
		text = 'ON/OFF using MACHINEGUN rotation',
		icon = 'Interface\\Icons\\Inv_misc_2h_farmscythe_a_01',
	})

end

local _Xeer = {
	--{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},


--[[
deathknight="Death_Knight_Frost_T19P"
level=110
race=blood_elf
role=attack
position=back
talents=2230021
artifact=12:137308:133684:137308:0:108:3:109:3:110:6:113:3:119:1:120:1:122:1:123:1:1090:3:1332:1
spec=frost

# Gear Summary
# gear_ilvl=843.75
# gear_strength=9960
# gear_stamina=17629
# gear_crit_rating=7427
# gear_haste_rating=5600
# gear_mastery_rating=2677
# gear_versatility_rating=1952
# gear_armor=3965
# set_bonus=tier19p_plate_2pc=1
--]]
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,name=countless_armies
	--{'', ''},
 	--actions.precombat+=/food,name=the_hungry_magister
	--{'', ''},
 	--actions.precombat+=/augmentation,name=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
 	--actions.precombat+=/snapshot_stats
--	{'', ''},
 	--actions.precombat+=/potion,name=old_war
	--{'', ''},
}


local Survival = {
 {'Death Strike', 'player.health<=75&player.buff(Dark Succor)'},
}

local BoS_check = {
	--actions.generic+=/horn_of_winter,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
	{'Horn of Winter', 'talent(2,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
 	--actions.generic+=/horn_of_winter,if=!talent.breath_of_sindragosa.enabled
	{'Horn of Winter', 'talent(2,2)&!talent(7,2)'},
 	--actions.generic+=/frost_strike,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
	{'Frost Strike', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
 	--actions.generic+=/frost_strike,if=!talent.breath_of_sindragosa.enabled
	{'Frost Strike', '!talent(7,2)'},
 	--actions.generic+=/empower_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
	{'Empower Rune Weapon', 'talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
 	--actions.generic+=/empower_rune_weapon,if=!talent.breath_of_sindragosa.enabled
	{'Empower Rune Weapon', '!talent(7,2)'},
	--actions.generic+=/hungering_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
	{'Hungering Rune Weapon', 'talent(3,2)&talent(7,2)&cooldown(Breath of Sindragosa).remains>15'},
 	--actions.generic+=/hungering_rune_weapon,if=!talent.breath_of_sindragosa.enabled
	{'Hungering Rune Weapon', 'talent(3,2)&!talent(7,2)'},
}

local Cooldowns = {
	--# Executed every time the actor is available.
 	--actions+=/blood_fury,if=!talent.breath_of_sindragosa.enabled||dot.breath_of_sindragosa.ticking
	{'Blood Fury', '!talent(7,2)||target.dot(Breath of Sindragosa).ticking'},
 	--actions+=/berserking,if=buff.pillar_of_frost.up
	{'Berserking', 'player.buff(Pillar of Frost)'},
 	--actions+=/use_item,slot=finger2
	--{'', ''},
 	--actions+=/use_item,slot=trinket1
	--{'', ''},
 	--actions+=/potion,name=old_war
	--{'', ''},
	--actions+=/pillar_of_frost
	{'Pillar of Frost'},
 	--actions+=/sindragosas_fury,if=buff.pillar_of_frost.up
	{'Sindragosa\'s Fury', 'player.buff(Pillar of Frost)&target.debuff(Rune of Razorice).count=>5'},
 	--actions+=/obliteration
	{'Obliteration'},
 	--actions+=/breath_of_sindragosa,if=runic_power>=50
	{'Breath of Sindragosa', 'talent(7,2)&runic_power>=50'},
	{BoS_check},
}

local Core = {
	--actions.core+=/frostscythe,if=!talent.breath_of_sindragosa.enabled&(buff.killing_machine.react||spell_targets.frostscythe>=4)
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine).react||player.area(8).enemies>=4}'},
 	--actions.core=remorseless_winter,if=artifact.frozen_soul.enabled
	{'Remorseless Winter', 'artifact(Frozen Soul).enabled'},
 	--actions.core+=/glacial_advance
	{'Glacial Advance', 'talent(7,3)'},
 	--actions.core+=/frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine).react'},
 	--actions.core+=/remorseless_winter,if=spell_targets.remorseless_winter>=2||talent.gathering_storm.enabled
	{'Remorseless Winter', 'player.area(8).enemies>=2||talent(6,3)'},
 	--actions.core+=/obliterate,if=buff.killing_machine.react
	{'Obliterate', 'player.buff(Killing Machine).react'},
 	--actions.core+=/obliterate
	{'Obliterate'},
 	--actions.core+=/remorseless_winter
	{'Remorseless Winter'},
 	--actions.core+=/frostscythe,if=talent.frozen_pulse.enabled
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
 	--actions.core+=/howling_blast,if=talent.frozen_pulse.enabled
	{'Howling Blast', 'talent(2,2)'},
}

local IcyTalons = {
 	--actions.icytalons=frost_strike,if=buff.icy_talons.remains<1.5
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
 	--actions.icytalons+=/howling_blast,target_if=!dot.frost_fever.ticking
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
 	--actions.icytalons+=/howling_blast,if=buff.rime.react
	{'Howling Blast', 'player.buff(Rime).react'},
 	--actions.icytalons+=/frost_strike,if=runic_power>=80||buff.icy_talons.stack<3
	{'Frost Strike', 'runic_power>=80||player.buff(Icy Talons).stack<3'},
 	--actions.icytalons+=/call_action_list,name=core
	{Core},
	{BoS_check},
}

local BoS = {
 	--actions.bos=howling_blast,target_if=!dot.frost_fever.ticking
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
 	--actions.bos+=/call_action_list,name=core
	{Core},
 	--actions.bos+=/horn_of_winter
	{'Horn of Winter', 'talent(2,3)'},
 	--actions.bos+=/empower_rune_weapon,if=runic_power<=70
	{'Empower Rune Weapon', 'runic_power<=70'},
 	--actions.bos+=/hungering_rune_weapon
	{'Hungering Rune Weapon', 'talent(3,2)'},
 	--actions.bos+=/howling_blast,if=buff.rime.react
	{'Howling Blast', 'player.buff(Rime).react'},
}

local Generic = {
 	--actions.generic=howling_blast,target_if=!dot.frost_fever.ticking
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
 	--actions.generic+=/howling_blast,if=buff.rime.react
	{'Howling Blast', 'player.buff(Rime).react'},
 	--actions.generic+=/frost_strike,if=runic_power>=80
	{'Frost Strike', 'runic_power>=80'},
 	--actions.generic+=/call_action_list,name=core
	{Core},
	{BoS_check},
}

local Shatter = {
 	--actions.shatter=frost_strike,if=debuff.razorice.stack=5
	{'Frost Strike', ''},
 	--actions.shatter+=/howling_blast,target_if=!dot.frost_fever.ticking
	{'Howling Blast', ''},
 	--actions.shatter+=/howling_blast,if=buff.rime.react
	{'Howling Blast', ''},
 	--actions.shatter+=/frost_strike,if=runic_power>=80
	{'Frost Strike', ''},
 	--actions.shatter+=/call_action_list,name=core
	{Core},
	{BoS_check},
}

local MACHINEGUN = {
 	--actions.icytalons=frost_strike,if=buff.icy_talons.remains<1.5
	{'Frost Strike', 'player.buff(Icy Talons).remains<1.5'},
 	--actions.icytalons+=/howling_blast,target_if=!dot.frost_fever.ticking
	{'Howling Blast', '!target.dot(Frost Fever).ticking'},
 	--actions.icytalons+=/howling_blast,if=buff.rime.react
	{'Howling Blast', 'player.buff(Rime).react'},
 	--actions.icytalons+=/frost_strike,if=runic_power>=80||buff.icy_talons.stack<3
	{'Frost Strike', 'runic_power>=80||player.buff(Icy Talons).stack<3'},
	--actions.core+=/frostscythe,if=!talent.breath_of_sindragosa.enabled&(buff.killing_machine.react||spell_targets.frostscythe>=4)
	{'Frostscythe', 'talent(6,1)&!talent(7,2)&{player.buff(Killing Machine).react||player.area(8).enemies>=4}'},
 	--actions.core=remorseless_winter,if=artifact.frozen_soul.enabled
	{'Remorseless Winter', 'artifact(Frozen Soul).enabled'},
 	--actions.core+=/glacial_advance
	{'Glacial Advance', 'talent(7,3)'},
 	--actions.core+=/frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
	{'Frost Strike', 'player.buff(Obliteration)&!player.buff(Killing Machine).react'},
 	--actions.core+=/remorseless_winter,if=spell_targets.remorseless_winter>=2||talent.gathering_storm.enabled
	{'Remorseless Winter', 'player.area(8).enemies>=2||talent(6,3)'},
	--actions.core+=/remorseless_winter
	{'Remorseless Winter'},
 	--actions.core+=/obliterate,if=buff.killing_machine.react
	{'Obliterate', '!talent(6,1)&player.buff(Killing Machine).react'},
 	--actions.core+=/obliterate
	{'Obliterate', 'talent(6,1)&!player.buff(Killing Machine).react'},
 	--actions.core+=/frostscythe,if=talent.frozen_pulse.enabled
	{'Frostscythe', 'talent(6,1)&talent(2,2)'},
}

local xCombat = {
	--actions+=/run_action_list,name=bos,if=dot.breath_of_sindragosa.ticking
	{BoS, 'target.dot(Breath of Sindragosa).ticking'},
 	--actions+=/call_action_list,name=shatter,if=talent.shattering_strikes.enabled
	{Shatter, 'talent(1,1)'},
 	--actions+=/call_action_list,name=icytalons,if=talent.icy_talons.enabled
	{IcyTalons, 'talent(1,2)'},
 	--actions+=/call_action_list,name=generic,if=(!talent.shattering_strikes.enabled&!talent.icy_talons.enabled)
	{Generic, '!talent(1,1)&!talent(1,2)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Interrupts = {
	{'Mind Freeze'},
	{'Arcane Torrent', 'target.range<=8&spell(Mind Freeze).cooldown>gcd&!prev_gcd(Mind Freeze)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=15'},
	--{_Xeer},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)&target.range<8'},
	{MACHINEGUN, 'toggle(xMACHINEGUN)&target.range<8&target.infront'},
	{xCombat, '!toggle(xMACHINEGUN)&target.range<8&target.infront'}
}

local outCombat = {
	{Keybinds},
	--{PreCombat},
}
NeP.CR:Add(251, '[|cff'..Xeer.addonColor..'Xeer|r] Death Knight - Frost', inCombat, outCombat, exeOnLoad)
