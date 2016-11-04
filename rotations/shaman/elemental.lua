local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FElemental |r')
	print('|cffADFF2F --- |r TOTEM MASTERY FIXED? if no report it to me please!|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/1 - 4/2 - 5/2 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
shaman="Shaman_Elemental_T19P"
level=110
race=orc
role=spell
position=ranged_back
talents=3112212
artifact=40:137365:137272:137365:0:291:1:294:1:295:1:296:1:298:3:300:6:301:3:302:3:303:3:1350:1
spec=elemental

# Gear Summary
# gear_ilvl=843.75
# gear_stamina=17944
# gear_intellect=18697
# gear_crit_rating=10236
# gear_haste_rating=4293
# gear_mastery_rating=2418
# gear_versatility_rating=898
# gear_armor=2433
# set_bonus=tier19p_mail_2pc=1
--]]
}

local Survival = {

}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
 	--actions.precombat=flask,type=whispered_pact
	--{'', ''},
 	--actions.precombat+=/food,name=fishbrul_special
	--{'', ''},
 	--actions.precombat+=/augmentation,type=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
 	--actions.precombat+=/snapshot_stats
	--{'', ''},
 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},
 	--actions.precombat+=/stormkeeper
	{'Stormkeeper'},
 	--actions.precombat+=/totem_mastery
	{'Totem Mastery', '!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)'},
}

local Cooldowns = {
	--# Executed every time the actor is available.
	--# Bloodlust casting behavior mirrors the simulator settings for proxy bloodlust. See options 'bloodlust_percent', and 'bloodlust_time'.
 	--actions=bloodlust,if=target.health.pct<25||time>0.500
	--{'', ''},
	--# In-combat potion is preferentially linked to Ascendance, unless combat will end shortly
 	--actions+=/potion,name=deadly_grace,if=buff.ascendance.up||target.time_to_die<=30
	--{'', ''},
 	--actions+=/totem_mastery,if=buff.resonance_totem.remains<2
	--{'Totem Mastery', 'totem(Totem Mastery).duration<1'},
	{'Totem Mastery', '!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)'},
 	--actions+=/fire_elemental
	{'Fire Elemental', '!talent(6,2)'},
 	--actions+=/storm_elemental
	{'Storm Elemental', 'talent(6,2)'},
 	--actions+=/elemental_mastery
	{'Elemental Mastery', 'talent(6,1)'},
 	--actions+=/blood_fury,if=!talent.ascendance.enabled||buff.ascendance.up||cooldown.ascendance.remains>50
	{'Blood Fury', '!talent(7,1)||player.buff(Ascendance)||spell(Ascendance)cooldown>50'},
 	--actions+=/berserking,if=!talent.ascendance.enabled||buff.ascendance.up
	{'Berserking', '!talent(Ascendance)||player.buff(Ascendance)'}
}

local Interrupts = {
	{'Wind Shear'},
}

local AoE = {
 	--actions.aoe=stormkeeper
	{'Stormkeeper'},
 	--actions.aoe+=/ascendance
	{'Ascendance'},
 	--actions.aoe+=/liquid_magma_totem
	{'Liquid Magma Totem', 'talent(7,3)'},
 	--actions.aoe+=/flame_shock,if=spell_targets.chain_lightning=3&maelstrom>=20,target_if=refreshable
	{'Flame Shock', 'player.maelstrom>=20&target.debuff(Flame Shock).duration<gcd'},
 	--actions.aoe+=/earthquake
	{'Earthquake', 'player.maelstrom>=50', 'cursor.ground'},
 	--actions.aoe+=/lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning=3
	{'Lava Burst', '!player.buff(Lava Surge)'},
 	--actions.aoe+=/lava_beam
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
 	--actions.aoe+=/chain_lightning,target_if=!debuff.lightning_rod.up
	{'Chain Lightning', 'talent(7,2)&!target.debuff(Lightning Rod)'},
 	--actions.aoe+=/chain_lightning
	{'Chain Lightning'},
 	--actions.aoe+=/lava_burst,moving=1
	{'Lava Burst', 'xmoving=1'},
 	--actions.aoe+=/flame_shock,moving=1,target_if=refreshable
	{'Flame Shock', 'xmoving=1&target.debuff(Flame Shock).duration<gcd'}
}

local ST = {
 	--actions.single=ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60||buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
	{'Ascendance', 'target.debuff(Flame Shock).duration>player.buff(Ascendance).duration&{combat(player).time>=60||player.buff(Bloodlust)}&spell(Lava Burst).cooldown>0&!player.buff(Stormkeeper)'},
 	--actions.single+=/flame_shock,if=!ticking
	{'Flame Shock', '!target.debuff(Flame Shock)'},
 	--actions.single+=/flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
	{'Flame Shock', 'player.maelstrom>=20&target.debuff(Flame Shock).duration<player.buff(Ascendance).duration&spell(Ascendance).cooldown+player.buff(Ascendance).duration<=target.debuff(Flame Shock).duration'},
 	--actions.single+=/earth_shock,if=maelstrom>=92
	{'Earth Shock', 'player.maelstrom>=92'},
 	--actions.single+=/icefury,if=raid_event.movement.in<5
	--{'Icefury', 'talent(5,3)'},
 	--actions.single+=/lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react||buff.ascendance.up)
	{'Lava Burst', 'target.debuff(Flame Shock).duration>action(Lava Burst).cast_time&{spell(Lava Burst).cooldown=0||player.buff(Ascendance)}'},
 	--actions.single+=/elemental_blast
	{'Elemental Blast', '(4,1)'},
 	--actions.single+=/earthquake_totem,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake Totem', '{player.buff(Echoes of the Great Sundering)&totem(Earthquake Totem).duration<1}', 'target.ground'},
	--actions.single+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', 'player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<gcd'},
 	--actions.single+=/frost_shock,if=talent.icefury.enabled&buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)||buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack))
	{'Frost Shock', 'talent(5,3)&player.buff(Icefury)&{player.maelstrom>=20||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).stack}}'},
 	--actions.single+=/frost_shock,moving=1,if=buff.icefury.up
	{'Frost Shock', 'xmoving=1&player.buff(Icefury)'},
 	--actions.single+=/earth_shock,if=maelstrom>=86
	{'Earth Shock', 'player.maelstrom>=86'},
 	--actions.single+=/icefury,if=maelstrom<=70&raid_event.movement.in>30&((talent.ascendance.enabled&cooldown.ascendance.remains>buff.icefury.duration)||!talent.ascendance.enabled)
	{'Icefury', 'talent(5,3)&player.maelstrom<=70&{{talent(7,1)&spell(Ascendance).cooldown>player.buff(Icefury).duration}||!talent(7,1)}'},
 	--actions.single+=/liquid_magma_totem,if=raid_event.adds.count<3||raid_event.adds.in>50
	--{'Liquid Magma Totem', '...'},
 	--actions.single+=/stormkeeper,if=(talent.ascendance.enabled&cooldown.ascendance.remains>10)||!talent.ascendance.enabled
	{'Stormkeeper', '{talent(7,1)&spell(Ascendance).cooldown>10}||!talent(7,1)'},
 	--actions.single+=/totem_mastery,if=buff.resonance_totem.remains<10||(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
	--{'Totem Mastery', 'totem(Totem Mastery).duration<1||{!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Totem Mastery', 'totem(Totem Mastery).duration<1'},
 	--actions.single+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)&player.area(40).enemies>1'},
 	--actions.single+=/lightning_bolt,if=buff.power_of_the_maelstrom.up,target_if=!debuff.lightning_rod.up
	{'Lightning Bolt', 'talent(7,2)&player.buff(Power of the Maelstrom)&!target.debuff(Lightning Rod)'},
 	--actions.single+=/lightning_bolt,if=buff.power_of_the_maelstrom.up
	{'Lightning Bolt', '!talent(7,2)&player.buff(Power of the Maelstrom)'},
 	--actions.single+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1,target_if=!debuff.lightning_rod.up
	{'Chain Lightning', 'talent(7,2)&player.area(40).enemies>1&!target.debuff(Lightning Rod)'},
 	--actions.single+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
	{'Chain Lightning', '!talent(7,2)&player.area(40).enemies>1'},
 	--actions.single+=/lightning_bolt,target_if=!debuff.lightning_rod.up
	{'Lightning Bolt', '!talent(7,2)&!target.debuff(Lightning Rod)'},
 	--actions.single+=/lightning_bolt
	{'Lightning Bolt', 'talent(7,2)'},
 	--actions.single+=/flame_shock,moving=1,target_if=refreshable
	{'Flame Shock', 'xmoving=1&target.debuff(Flame Shock).duration<gcd'},
 	--actions.single+=/earth_shock,moving=1
	{'Earth Shock', 'xmoving=1'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=30'},
	--{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	--actions+=/run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2||spell_targets.lava_beam>2)
	{AoE, 'toggle(aoe)&player.area(40).enemies>2'},
	--actions+=/run_action_list,name=single
	{ST, 'target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	--{PreCombat}
}

NeP.CR:Add(262, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Shaman - Elemental',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
