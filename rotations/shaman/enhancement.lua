local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSHAMAN |cffADFF2FEnhancement |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/X - 3/X - 4/3 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
-- Some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
shaman="Shaman_Enhancement_T19P"
level=110
race=orc
role=attack
position=back
talents=3003112
artifact=41:137316:137543:133682:0:899:1:901:1:902:1:903:1:904:1:905:1:906:1:909:3:910:5:911:3:912:3:913:1:1351:1
spec=enhancement

# Gear Summary
# gear_ilvl=843.75
# gear_agility=11083
# gear_stamina=17628
# gear_crit_rating=1510
# gear_haste_rating=4970
# gear_mastery_rating=10279
# gear_armor=2433
--]]
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful --actions only.
	--actions.precombat=flask,type=seventh_demon
	--actions.precombat+=/augmentation,type=defiled
	--actions.precombat+=/food,name=nightborne_delicacy_platter
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=old_war
	--actions.precombat+=/lightning_shield
	{'Ghost Wolf', '!player.buff(Ghost Wolf)'},
}

local Survival = {

}

local Cooldowns = {

}

local Interrupts = {
	{'Wind Shear'},
}

local xCombat = {
	{'Healing Surge', 'player.health<=70&player.maelstrom>=20', 'player'},
	--# Executed every time the actor is available.
	--# Bloodlust casting behavior mirrors the simulator settings for proxy bloodlust. See options 'bloodlust_percent', and 'bloodlust_time'.
	--actions+=/bloodlust,if=target.health.pct<25||time>0.500
	--actions+=/feral_spirit
	{'Feral Spirit', 'toggle(cooldowns)'},
	--actions+=/crash_lightning,if=artifact.alpha_wolf.rank&prev_gcd.feral_spirit
	{'Crash Lightning', 'artifact(Alpha Wolf).enabled&prev_gcd(Feral Spirit)'},
	--actions+=/potion,name=old_war,if=feral_spirit.remains>5|target.time_to_die<=30
	--actions+=/berserking,if=buff.ascendance.up||!talent.ascendance.enabled||level<100
	{'Berserking', 'player.buff(Ascendance)||!talent(7,1)||player.level<100'},
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/crash_lightning,if=talent.crashing_storm.enabled&active_enemies>=3
	{'Crash Lightning', 'talent(6,1)&player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>=3'},
	--actions+=/boulderfist,if=buff.boulderfist.remains<gcd&maelstrom>=50&active_enemies>=3
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd&player.maelstrom<=50&player.area(8).enemies>=3'},
	--actions+=/boulderfist,if=buff.boulderfist.remains<gcd||(charges_fractional>1.75&maelstrom<=100&active_enemies<=2)
	{'Boulderfist', 'player.buff(Boulderfist).remains<gcd||{spell(Boulderfist).charges>1.75&player.maelstrom<=100&player.area(8).enemies<=2}'},
	--actions+=/crash_lightning,if=buff.crash_lightning.remains<gcd&active_enemies>=2
	{'Crash Lightning', 'player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>=2'},
	--actions+=/stormstrike,if=active_enemies>=3&!talent.hailstorm.enabled
	{'Stormstrike', '!talent(4,3)&player.area(8).enemies>=3'},
	--actions+=/stormstrike,if=buff.stormbringer.up
	{'Stormstrike', 'player.buff(Stormbringer)'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<gcd
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd'},
	--actions+=/flametongue,if=buff.flametongue.remains<gcd
	{'Flametongue', 'player.buff(Flametongue).remains<gcd'},
	--actions+=/windsong
	{'Windsong'},
	--actions+=/ascendance
	{'Ascendance'},
	--actions+=/fury_of_air,if=!ticking
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	--actions+=/doom_winds
	{'Doom Winds'},
	--actions+=/crash_lightning,if=active_enemies>=3
	{'Crash Lightning', 'player.area(8).enemies>=3'},
	--actions+=/stormstrike
	{'Stormstrike'},
	--actions+=/lightning_bolt,if=talent.overcharge.enabled&maelstrom>=60
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>=60'},
	--actions+=/lava_lash,if=buff.hot_hand.up
	{'Lava Lash', 'player.buff(Hot Hand)'},
	--actions+=/earthen_spike
	{'Earthen Spike'},
	--actions+=/crash_lightning,if=active_enemies>1|talent.crashing_storm.enabled|feral_spirit.remains>5
	{'Crash Lightning', 'player.area(8).enemies>1||talent(6,1)||spell(Feral Spirit).cooldown>110'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.5'},
	--actions+=/flametongue,if=buff.flametongue.remains<4.8
	{'Flametongue', 'player.buff(Flametongue).remains<4.8'},
	--actions+=/sundering
	{'Sundering'},
	--actions+=/lava_lash,if=maelstrom>=90
	{'Lava Lash', 'player.maelstrom>=90'},
	--actions+=/rockbiter
	--{'Rockbiter'},
	--actions+=/flametongue
	{'Flametongue'},
	--actions+=/boulderfist
	{'Boulderfist'}
}

local Ranged = {
	{'Lightning Bolt'}
}

local Keybinds = {
	{'Lightning Surge Totem', 'keybind(lcontrol)' , 'cursor.ground'},
	-- Pause
	{'%pause', 'keybind(alt)'}

}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=30'},
	--{Survival, 'player.health<100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	--{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{xCombat, 'target.range<8&target.infront'},
	{Ranged, 'target.range>8&target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(263, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Shaman - Enhancement',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
