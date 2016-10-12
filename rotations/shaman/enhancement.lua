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
}

local Survival = {

}

local Cooldowns = {

}

local xCombat = {
	--# Executed every time the actor is available.
	--actions=wind_shear
	--# Bloodlust casting behavior mirrors the simulator settings for proxy bloodlust. See options 'bloodlust_percent', and 'bloodlust_time'.
	--actions+=/bloodlust,if=target.health.pct<25||time>0.500
	--actions+=/feral_spirit
	{'Feral Spirit'},
	--actions+=/potion,name=old_war,if=pet.feral_spirit.remains>10||pet.frost_wolf.remains>5||pet.fiery_wolf.remains>5||pet.lightning_wolf.remains>5||target.time_to_die<=30
	--actions+=/berserking,if=buff.ascendance.up||!talent.ascendance.enabled||level<100
	{'Berserking', 'player.buff(Ascendance)||!talent(7,1)||player.level<100'},
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/boulderfist,if=buff.boulderfist.remains<gcd||charges_fractional>1.75
	{'Boulderfist', 'player.buff(Boulderfist).duration<gcd||spell(Boulderfist).charges>1.75'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<gcd
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).duration<gcd'},
	--actions+=/flametongue,if=buff.flametongue.remains<gcd
	{'Flametongue', 'player.buff(Flametongue).duration<gcd'},
	--actions+=/windsong
	{'Windsong', 'talent(1,1)'},
	--actions+=/ascendance
	{'Ascendance', 'talent(7,1)'},
	--actions+=/fury_of_air,if=!ticking
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)'},
	--actions+=/doom_winds
	{'Doom Winds'},
	--actions+=/crash_lightning,if=active_enemies>=3
	{'Crash Lightning', 'player.area(8).enemies>=3'},
	--actions+=/windstrike
	--{'', ''},
	--actions+=/stormstrike
	{'StormStrike'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).duration<4.8'},
	--actions+=/flametongue,if=buff.flametongue.remains<4.8
	{'Flametongue', 'target.debuff(Flametongue).duration < 4.8'},
	--actions+=/lightning_bolt,if=talent.overcharge.enabled&maelstrom>=60
	{'Lightning Bolt', 'talent(5,2)&player.maelstrom>=60'},
	--actions+=/lava_lash,if=buff.hot_hand.react
	{'Lava Lash', 'player.buff(Hot Hand)'},
	--actions+=/earthen_spike
	{'Earthen Spike'},
	--actions+=/crash_lightning,if=active_enemies>1||talent.crashing_storm.enabled||(pet.feral_spirit.remains>5||pet.frost_wolf.remains>5||pet.fiery_wolf.remains>5||pet.lightning_wolf.remains>5)
	{'Crash Lightning', 'player.area(8).enemies>1||talent(6,1)||spell(Feral Spirit).cooldown>110'},
	--actions+=/sundering
	{'Sundering'},
	--actions+=/lava_lash,if=maelstrom>=90
	{'Lava Lash', 'player.maelstrom>=90'},
	--actions+=/rockbiter
	{'Rockbiter'},
	--actions+=/flametongue
	{'Flametongue'},
	--actions+=/boulderfist
	{'Boulderfist'}
}

local Ranged = {
	{'Lightning Bolt'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local inCombat = {
	{Keybinds},
	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	--{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{xCombat, {'target.range<8&target.infront'}},
	{Ranged, {'target.range>8&target.range<40&target.infront'}}
}

local outCombat = {
	{Keybinds},
	--{PreCombat}
}

NeP.CR:Add(263, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Shaman - Enhancement', inCombat, outCombat, exeOnLoad)
