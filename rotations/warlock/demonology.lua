local GUI = {

}

local exeOnLoad = function()

	Xeer.Splash()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FDemonology |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print("|cffADFF2F ----------------------------------------------------------------------|r")
	
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
]]	--

}

local PreCombat = {

--# Executed before combat begins. Accepts non-harmful actions only.
--actions.precombat=flask,type=whispered_pact
--actions.precombat+=/food,type=azshari_salad

--actions.precombat+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
{'', ''},

--actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
{'', ''},

--actions.precombat+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>=3
{'', ''},

--actions.precombat+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies<3&artifact.lord_of_flames.rank=0
{'', ''},

--actions.precombat+=/augmentation,type=defiled
--actions.precombat+=/snapshot_stats
--actions.precombat+=/potion,name=deadly_grace
--actions.precombat+=/demonic_empowerment
{'', ''},

--actions.precombat+=/demonbolt,if=talent.demonbolt.enabled
{'', ''},

--actions.precombat+=/shadow_bolt,if=!talent.demonbolt.enabled
{'', ''},

}


local Survival = {

-- {'', ''},

}

local Cooldowns = {

-- {'', ''},

}

local Util = {

--# Executed every time the actor is available.
--actions=implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&buff.demonic_synergy.remains
--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=3&buff.demonic_synergy.remains
--actions+=/implosion,if=wild_imp_count<=4&wild_imp_remaining_duration<=action.shadow_bolt.execute_time&spell_targets.implosion>1
--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=4&spell_targets.implosion>2
--actions+=/shadowflame,if=debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time
--actions+=/service_pet,if=cooldown.summon_doomguard.remains<=gcd&soul_shard>=2
--actions+=/service_pet,if=cooldown.summon_doomguard.remains>25
--actions+=/summon_doomguard,if=talent.grimoire_of_service.enabled&prev.service_felguard&spell_targets.infernal_awakening<3
--actions+=/summon_doomguard,if=talent.grimoire_of_synergy.enabled&spell_targets.infernal_awakening<3
--actions+=/summon_infernal,if=talent.grimoire_of_service.enabled&prev.service_felguard&spell_targets.infernal_awakening>=3
--actions+=/summon_infernal,if=talent.grimoire_of_synergy.enabled&spell_targets.infernal_awakening>=3
--actions+=/call_dreadstalkers,if=!talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)
--actions+=/hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
--actions+=/summon_darkglare,if=prev_gcd.hand_of_guldan
--actions+=/summon_darkglare,if=prev_gcd.call_dreadstalkers
--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=3
--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=1&buff.demonic_calling.react
--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains>2
--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&prev_gcd.summon_darkglare
--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3
--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react
--actions+=/hand_of_guldan,if=soul_shard>=3&prev_gcd.call_dreadstalkers
--actions+=/hand_of_guldan,if=soul_shard>=5&cooldown.summon_darkglare.remains<=action.hand_of_guldan.cast_time
--actions+=/hand_of_guldan,if=soul_shard>=4&cooldown.summon_darkglare.remains>2
--actions+=/demonic_empowerment,if=wild_imp_no_de>3|prev_gcd.hand_of_guldan
--actions+=/demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
--actions+=/felguard:felstorm
--actions+=/doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
--actions+=/arcane_torrent
--actions+=/berserking
--actions+=/blood_fury
--actions+=/soul_harvest
--actions+=/potion,name=deadly_grace,if=buff.soul_harvest.remains|target.time_to_die<=45|trinket.proc.any.react
--actions+=/shadowflame,if=charges=2
--actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
--actions+=/life_tap,if=mana.pct<=30
--actions+=/demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
--actions+=/demonwrath,moving=1,chain=1,interrupt=1
--actions+=/demonbolt
--actions+=/shadow_bolt
--actions+=/life_tap

}







local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	

}

local inCombat = {

	{Keybinds},
	{_Xeer},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	
	
	----actions+=/call_action_list,name=single_target
	{ST, {'target.range < 8', 'target.infront'}}
	
}

local outCombat = {

	{Keybinds},
	{PreCombat},
	
}

NeP.Engine.registerRotation(266, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] WARLOCK - Demonology', inCombat, outCombat, exeOnLoad, GUI)