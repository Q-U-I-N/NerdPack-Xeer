local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
 	print('|cffADFF2F --- |rROGUE |cffADFF2FSubtlety |r')
 	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/X - 5/X - 6/1 - 7/1')
 	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
rogue="Rogue_Subtlety_T19M"
level=110
race=night_elf
timeofday=day
role=attack
position=back
talents=2210011
artifact=17:0:0:0:0:851:1:852:3:853:3:854:3:855:3:856:3:857:3:858:3:859:3:860:3:861:1:862:1:863:1:864:1:865:1:866:1:1349:1
spec=subtlety

# Gear Summary
# gear_ilvl=882.31
# gear_agility=15928
# gear_stamina=25309
# gear_crit_rating=6651
# gear_haste_rating=2821
# gear_mastery_rating=7051
# gear_versatility_rating=2750
# gear_armor=2236
--]]
}



local PreCombat = {
	--# Executed before combat begins. Accepts non-harmfulactions only.
	--actions.PreCombat=flask,name=flask_of_the_seventh_demon
	--{'', ''},
	--actions.PreCombat+=/augmentation,name=defiled
	--{'', ''},
	--actions.PreCombat+=/food,name=seedbattered_fish_plate
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.PreCombat+=/snapshot_stats
	--actions.PreCombat+=/stealth
	{'Stealth', '!player.buff(Stealth)||!player.buff(Shadowmeld)'},
	{'Shadowstrike', 'stealthed&target.range<=15&target.infront'},
	--actions.PreCombat+=/potion,name=old_war
	--{'#Old War'},
	--actions.PreCombat+=/marked_for_death,if=raid_event.adds.in>40
	--{'', ''},
	--actions.PreCombat+=/symbols_of_death
	--{'', ''},
}


local Builders = {
 	--actions.Builders=shuriken_storm,if=spell_targets.shuriken_storm>=2
	{'Shuriken Storm', 'player.area(10).enemies>=2'},
 	--actions.Builders+=/gloomblade
	--{'Gloomblade'},
 	--actions.Builders+=/backstab
	{'Backstab'},
}

local Cooldowns ={
 	--Cooldowns=potion,name=old_war,if=buff.bloodlust.up||target.time_to_die<=25||buff.shadow_blades.up
	--{'', ''},
 	--Cooldowns+=/blood_fury,if=stealthed
	{'Blood Fury', 'stealthed'},
 	--Cooldowns+=/berserking,if=stealthed
	{'Berserking', 'stealthed'},
 	--Cooldowns+=/shadow_blades,if=!{Stealthed||buff.shadowmeld.up}
	{'Shadow Blades', '!stealthed||!player.buff(Shadowmeld)'},
 	--Cooldowns+=/goremaws_bite,if=!buff.shadow_dance.up&{{combo_points.deficit>=4-{time<10}*2&energy.deficit>50+talent.vigor.enabled*25-{time>=10}*15}||target.time_to_die<8}
	{'Goremaw\'s Bite', '!player.buff(Shadow Dance)&{{combo_points.deficit>={4-parser_bypass2}*2&energy.deficit>{50+talent(3,3).enabled*25-parser_bypass3}*15}||target.time_to_die<8}'},
	--Cooldowns+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit||{raid_event.adds.in>40&combo_points.deficit>=4+talent.deeper_strategem.enabled+talent.anticipation.enabled}
	{'Marked for Death', 'target.time_to_die<combo_points.deficit||combo_points.deficit>=5'},
}

local Finishers = {
 	--actions.Finishers=enveloping_shadows,if=buff.enveloping_shadows.remains<target.time_to_die&buff.enveloping_shadows.remains<=combo_points*1.8
	{'Enveloping Shadows', 'player.buff(Enveloping Shadows).remains<target.time_to_die&player.buff(Enveloping Shadows).remains<=combo_points*1.8'},
 	--actions.Finishers+=/death_from_above,if=spell_targets.death_from_above>=6
	{'Death from Above', 'player.area(8).enemies>=6'},
 	--actions.Finishers+=/nightblade,target_if=max:target.time_to_die,if=target.time_to_die>8&{{refreshable&{!finality||buff.finality_nightblade.up}}||remains<tick_time}
	{'Nightblade', 'target.time_to_die>8&{{dot.refreshable(Nightblade){!artifact(Finality).enabled||player.buff(Finality: Nightblade)}}||target.dot(Nightblade).remains<target.dot(Nightblade).tick_time}'},
 	--actions.Finishers+=/death_from_above
	{'Death from Above'},
 	--actions.Finishers+=/eviscerate
	{'Eviscerate'},
}

local Stealth_Cooldowns = {
 	--actions.Stealth_Cooldowns=shadow_dance,if=charges_fractional>=2.65
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>=2.65'},
 	--actions.Stealth_Cooldowns+=/vanish
	{'Vanish', '!stealthed'},
 	--actions.Stealth_Cooldowns+=/shadow_dance,if=charges>=2&combo_points<=1
	{'Shadow Dance', '!stealthed&cooldown(Shadow Dance).charges>=2&combo_points<=1'},
 	--actions.Stealth_Cooldowns+=/pool_resource,for_next=1,extra_amount=40-variable.ssw_er
 	--actions.Stealth_Cooldowns+=/shadowmeld,if=energy>=40-variable.ssw_er&energy.deficit>10
	{'Shadowmeld', 'player.energy>=40-variable.ssw_er&energy.deficit>10'},
 	--actions.Stealth_Cooldowns+=/shadow_dance,if=combo_points<=1
	{'Shadow Dance', '!stealthed&combo_points<=1'},
}

local Stealthed = {
 	--actions.Stealthed=symbols_of_death,if=buff.shadowmeld.down&{{buff.symbols_of_death.remains<target.time_to_die-4&buff.symbols_of_death.remains<=buff.symbols_of_death.duration*0.3}||{equipped.shadow_satyrs_walk&energy.time_to_max<0.25}}
	{'Symbols of Death', '!player.buff(Shadowmeld)&{{player.buff(Symbols of Death).remains<target.time_to_die-4&player.buff(Symbols of Death).remains<=player.buff(Symbols of Death).duration*0.3}||{xequipped(137032)&energy.time_to_max<0.25}}'},
 	--actions.Stealthed+=/call_action_list,name=Finishers,if=combo_points>=5
	{Finishers, 'combo_points>=5'},
 	--actions.Stealthed+=/shuriken_storm,if=buff.shadowmeld.down&{{combo_points.deficit>=3&spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk}||buff.the_dreadlords_deceit.stack>=29}
	{'Shuriken Storm', '!player.buff(Shadowmeld)&{{combo_points.deficit>=3&player.area(10).enemies>=2+talent(6,1).enabled+xequipped(137032)}||player.buff(The Dreadlord\'s Deceit).stack>=29}'},
 	--actions.Stealthed+=/shadowstrike
	{'Shadowstrike'},
}

local xCombat = {
	{Cooldowns, 'toggle(cooldowns)'},
	--# Fully switch to the Stealthed Rotation {by doing so, it forces pooling if nothing is available}
 	--actions+=/run_action_list,name=Stealthed,if=stealthed||buff.shadowmeld.up
	{Stealthed, 'stealthed||player.buff(Shadowmeld)'},
 	--actions+=/call_action_list,name=Finishers,if=combo_points>=5||{combo_points>=4&spell_targets.shuriken_storm>=3&spell_targets.shuriken_storm<=4}
	{Finishers, 'combo_points>=5||{combo_points>=4&player.area(10).enemies>=3&player.area(10).enemies<=4}'},
	--actions+=/call_action_list,name=Stealth_Cooldowns,if=combo_points.deficit>=2+talent.premeditation.enabled&{variable.ed_threshold||{cooldown.shadowmeld.up&!cooldown.vanish.up&cooldown.shadow_dance.charges<=1}||target.time_to_die<12||spell_targets.shuriken_storm>=5}
	{Stealth_Cooldowns, 'combo_points.deficit>=2+talent(6,1).enabled&{variable.ed_threshold||{cooldown(Shadowmeld).up&!cooldown(Vanish).up&cooldown(Shadow Dance).charges<=1}||target.time_to_die<12||player.area(10).enemies>=5}'},
 	--actions+=/call_action_list,name=Builders,if=variable.ed_threshold
	{Builders, 'variable.ed_threshold'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Interrupts = {
	{'Kick'},
	{'Cheap Shot', 'cooldown(Kick).remains>gcd'},
	{'Kidney Shot', 'cooldown(Kick).remains>gcd'},
	{'Blind', 'cooldown(Kick).remains>gcd'},
}

local Survival ={
	{'Crimson Vial', 'player.health<=70'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(47)&toggle(interrupts)&target.infront&target.range<8'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(261, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] ROGUE - Subtlety',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
