local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()

	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FDemonology |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {

	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},



	--[[
warlock="Warlock_Demonology_T19P"
level=110
race=troll
role=spell
position=back
talents=2201032
artifact=37:137549:137492:133764:0:1170:1:1171:3:1173:2:1176:6:1177:3:1178:3:1180:1:1182:1:1183:1:1185:1:1354:1
spec=demonology
]]		--

}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
 	--actions.precombat=flask,type=whispered_pact
 	--actions.precombat+=/food,type=azshari_salad
 	--actions.precombat+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	{'Summon Felguard', '!pet.exists&!talent(6,1)'},
 	--actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
	{'Summon Infernal', '!pet.exists&talent(6,1)&artifact(Lord of Flames).rank>0'},
 	--actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>=3
	{'Summon Infernal', '!pet.exists&talent(6,1)&player.area(30).enemies>=3'},
 	--actions.precombat+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies<3&artifact.lord_of_flames.rank=0
	{'Summon Doomguard', '!pet.exists&talent(6,1)&player.area(30).enemies<3&artifact(Lord of Flames).rank=0'},
 	--actions.precombat+=/augmentation,type=defiled
 	--actions.precombat+=/snapshot_stats
 	--actions.precombat+=/potion,name=deadly_grace
 	--actions.precombat+=/demonic_empowerment
	{'Demonic Empowerment', '!prev_gcd(Demonic Empowerment)&pet.exists&warlock.empower<action(Demonic Empowerment).cast_time+gcd'},
 	--actions.precombat+=/demonbolt,if=talent.demonbolt.enabled
	--{'', ''},
 	--actions.precombat+=/shadow_bolt,if=!talent.demonbolt.enabled
	--{'', ''},
}

local xCombat = {
	--# Executed every time the actor is available.
 	--actions=implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&buff.demonic_synergy.remains
	{'Implosion', 'talent(2,3)&{warlock(Wild Imp).remaining_duration<=action(Shadow Bolt).execute_time&player.buff(Demonic Synergy).remains}'},
 	--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=3&buff.demonic_synergy.remains
	{'Implosion', 'talent(2,3)&{prev_gcd(Hand of Gul\'dan)&warlock(Wild Imp).remaining_duration<=3&player.buff(Demonic Synergy).remains}'},
 	--actions+=/implosion,if=wild_imp_count<=4&wild_imp_remaining_duration<=action.shadow_bolt.execute_time&spell_targets.implosion>1
	{'Implosion', 'talent(2,3)&{warlock(Wild Imp).count<=4&warlock(Wild Imp).remaining_duration<=action(Shadow Bolt).execute_time&target.area(8).enemies>1}'},
 	--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=4&spell_targets.implosion>2
	{'Implosion', 'talent(2,3)&{prev_gcd(Hand of Gul\'dan)&warlock(Wild Imp).remaining_duration<=4&target.area(8).enemies>2}'},
 	--actions+=/shadowflame,if=debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time
	{'Shadowflame', 'talent(2,1)&{target.debuff(Shadowflame)stack>0&target.debuff(Shadowflame)remains<action(Shadow Bolt).cast_time+travel_time(Shadow Flame)}'},
	--actions+=/service_pet,if=cooldown.summon_doomguard.remains<=gcd&soul_shard>=2
	{'Grimoire: Felguard', 'talent(6,2)&{cooldown(Summon Doomguard).remains<=gcd&soul_shard>=2}'},
 	--actions+=/service_pet,if=cooldown.summon_doomguard.remains>25
	{'Grimoire: Felguard', 'talent(6,2)&{cooldown(Summon Doomguard).remains>25}'},
 	--actions+=/summon_doomguard,if=talent.grimoire_of_service.enabled&prev.service_felguard&spell_targets.infernal_awakening<3
	{'Summon Doomguard', 'talent(6,2)&{prev(Grimoire: Felguard)&target.area(10).enemies<3}'},
 	--actions+=/summon_doomguard,if=talent.grimoire_of_synergy.enabled&spell_targets.infernal_awakening<3
	{'Summon Doomguard', 'talent(6,3)&target.area(10).enemies<3'},
 	--actions+=/summon_infernal,if=talent.grimoire_of_service.enabled&prev.service_felguard&spell_targets.infernal_awakening>=3
	{'Summon Infernal', 'talent(6,2)&{prev(Grimoire: Felguard)&target.area(10).enemies>=3}'},
 	--actions+=/summon_infernal,if=talent.grimoire_of_synergy.enabled&spell_targets.infernal_awakening>=3
	{'Summon Infernal', 'talent(6,3)&target.area(10).enemies>=3'},
 	--actions+=/call_dreadstalkers,if=!talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)
	{'Call Dreadstalkers', '!talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}'},
 	--actions+=/hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&soul_shard>=4&!talent(7,1)'},
 	--actions+=/summon_darkglare,if=prev_gcd.hand_of_guldan
	{'Summon Darkglare', 'talent(7,1)&{prev_gcd(Hand of Gul\'dan)}'},
 	--actions+=/summon_darkglare,if=prev_gcd.call_dreadstalkers
	{'Summon Darkglare', 'talent(7,1)&{Call Dreadstalkers}'},
 	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains>5&soul_shard<3}'},
 	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=3
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains<=action(Summon Darkglare).cast_time&soul_shard>=3}'},
 	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=1&buff.demonic_calling.up
	{'Summon Darkglare', 'talent(7,1)&{cooldown(Call Dreadstalkers).remains<=action(Summon Darkglare).cast_time&soul_shard>=1&player.buff(Demonic Calling)}'},
 	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains>2
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains>2'},
 	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&prev_gcd.summon_darkglare
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&prev_gcd(Summon Darkglare)'},
 	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains<=action(Call Dreadstalkers.cast_time)&soul_shard>=3'},
 	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.up
	{'Call Dreadstalkers', 'talent(7,1)&{target.area(8).enemies<3||!talent(2,3)}&cooldown(Summon Darkglare).remains<=action(Call Dreadstalkers.cast_time)&soul_shard>=1&player.buff(Demonic Calling)'},
 	--actions+=/hand_of_guldan,if=soul_shard>=3&prev_gcd.call_dreadstalkers
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&soul_shard>=3&prev_gcd(Call Dreadstalkers)'},
 	--actions+=/hand_of_guldan,if=soul_shard>=5&cooldown.summon_darkglare.remains<=action.hand_of_guldan.cast_time
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&talent(7,1)&{soul_shard>=5&cooldown(Summon Darkglare).remains<=action(Hand of Gul\'dan).cast_time}'},
 	--actions+=/hand_of_guldan,if=soul_shard>=4&cooldown.summon_darkglare.remains>2
	{'Hand of Gul\'dan', '!prev_gcd(Hand of Gul\'dan)&talent(7,1)&{soul_shard>=4&cooldown(Summon Darkglare).remains>2}'},
 	--actions+=/demonic_empowerment,if=wild_imp_no_de>3|prev_gcd.hand_of_guldan
 	--actions+=/demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0 -- pets without empower
	{'Demonic Empowerment', '!prev_gcd(Demonic Empowerment)&warlock.empower<action(Demonic Empowerment).cast_time+gcd'},
	--action(Demonic Empowerment).cast_time+gcd
 	--actions+=/felguard:felstorm
	{'Command Demon', 'pet_range<8'},
 	--actions+=/doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
	{'Doom', '!talent(4,1)&target.time_to_die>target.dot(Doom).duration&{!target.dot(Doom).ticking||target.dot(Doom).remains<target.dot(Doom).duration*0.3}'},
 	--actions+=/shadowflame,if=charges=2
	{'Shadowflame', 'action(Shadowflame).charges=2'},
 	--actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
	{'Thal\'kiel\'s Consumption', '{warlock(Dreadstalkers).remaining_duration>action(Thal\'kiel\'s Consumption).execute_time||talent(2,3)&target.area(8).enemies=>3}&warlock(Wild Imp).count>3&warlock(Wild Imp).remaining_duration>action(Thal\'kiel\'s Consumption).execute_time'},
 	--actions+=/life_tap,if=mana.pct<=30
	{'Life Tap', 'mana.pct<=30'},
 	--actions+=/demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
	{'Demonwrath', 'xmoving=0&target.area(10).enemies>=3'},
 	--actions+=/demonwrath,moving=1,chain=1,interrupt=1
	{'Demonwrath', 'xmoving=1'},
 	--actions+=/demonbolt
	{'Demonbolt', 'talent(7,2)'},
 	--actions+=/shadow_bolt
	{'Shadow Bolt', '!talent(7,2)'},
 	--actions+=/life_tap
	{'Life Tap', 'mana.pct<=50'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Interrupts = {
	--{'Arcane Torrent', 'target.range<=8'},
}

local Survival = {

}

local Cooldowns = {
	--actions+=/berserking
	--{'Berserking'},
 	--actions+=/blood_fury
	--{'Blood Fury'},
 	--actions+=/soul_harvest
	{'Soul Harvest', 'talent(4,3)'},
 	--actions+=/potion,name=deadly_grace,if=buff.soul_harvest.remains|target.time_to_die<=45|trinket.proc.any.up
	--{'', ''},
}

local inCombat = {
	{Keybinds},
	--{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<40'},
	--{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
 	--actions+=/call_action_list,name=single_target
	{xCombat, {'target.range<40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(266, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] WARLOCK - Demonology',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
