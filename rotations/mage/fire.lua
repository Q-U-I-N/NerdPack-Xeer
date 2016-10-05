local GUI = {

}

local exeOnLoad = function()
	Xeer.Splash()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMAGE |cffADFF2FFire |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/X - 3/2 - 4/2 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = { -- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},


--[[
mage="Mage_Fire_T19P"
level=110
race=orc
role=spell
position=back
talents=1022021
artifact=54:133022:137420:133022:0:748:1:749:6:751:3:754:3:755:3:756:3:759:1:762:1:763:1:1340:1
spec=fire

# Gear Summary
# gear_ilvl=843.75
# gear_stamina=17944
# gear_intellect=18697
# gear_crit_rating=10246
# gear_haste_rating=2684
# gear_mastery_rating=4024
# gear_versatility_rating=898
# gear_armor=1570
# set_bonus=tier19p_cloth_2pc=1
--]]

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}


local PreCombat = {
	--actions.precombat=flask,type=flask_of_the_whispered_pact
	--actions.precombat+=/food,type=the_hungry_magister
	--actions.precombat+=/augmentation,type=defiled
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/mirror_image
	--actions.precombat+=/potion,name=deadly_grace
	--actions.precombat+=/pyroblast
}

local Interrupts = {
	{'Counterspell'},
}


local Cooldowns = {
	--# Executed every time the actor is available.
	--actions=counterspell,if=target.debuff.casting.react
	--actions+=/time_warp,if=target.health.pct<25|time=0
	--actions+=/shard_of_the_exodar_warp,if=buff.bloodlust.down
	--actions+=/mirror_image,if=buff.combustion.down
	--actions+=/rune_of_power,if=cooldown.combustion.remains>40&buff.combustion.down&(cooldown.flame_on.remains<5||cooldown.flame_on.remains>30)&!talent.kindling.enabled||target.time_to_die.remains<11||talent.kindling.enabled&(charges_fractional>1.8||time<40)&cooldown.combustion.remains>40
	{'Rune of Power', 'cooldown(Combustion).remains>40&!buff(Combustion)&{cooldown(Flame On).remains<5||cooldown(Flame On).remains>30}&!talent(7,1)||target.time_to_die.remains<11||talent(7,1)&{action(Rune of Power).charges>1.8||time<40}&cooldown(Combustion).remains>40'},
	{'Ice Barrier', '!buff(Ice Barrier)'}
}

local Survival = {

}

local Talents = {
	--actions.active_talents=flame_on,if=action.fire_blast.charges=0&(cooldown.combustion.remains>40+(talent.kindling.enabled*25)||target.time_to_die.remains<cooldown.combustion.remains)
	{'Flame On', 'talent(4,2)&{action(Fire Blast).charges<1&{cooldown(Combustion).remains>65||target.time_to_die<cooldown(Combustion).remains}}'},
	--actions.active_talents+=/blast_wave,if=(buff.combustion.down)||(buff.combustion.up&action.fire_blast.charges<1&action.phoenixs_flames.charges<1)
	{'Blast Wave', 'talent(4,1)&{{!buff(Combustion)}||{buff(Combustion)&action(Fire Blast).charges<1&action(Phoenix\'s Flames).charges<1}}'},
	--actions.active_talents+=/meteor,if=cooldown.combustion.remains>30||(cooldown.combustion.remains>target.time_to_die)||buff.rune_of_power.up
	{'Meteor', 'talent(7,3)&{cooldown(Combustion).remains>30||{cooldown(Combustion).remains>target.time_to_die}||buff(Rune of Power)}'},
	--actions.active_talents+=/cinderstorm,if=cooldown.combustion.remains<cast_time&(buff.rune_of_power.up||!talent.rune_on_power.enabled)||cooldown.combustion.remains>10*spell_haste&!buff.combustion.up
	{'Cinderstorm', 'talent(7,2)&{cooldown(Combustion).remains<action(Cinderstorm).cast_time&{buff(Rune of Power)||!talent(3,2)}||cooldown(Combustion).remains>10*spell_haste&!buff(Combustion)}'},
	--actions.active_talents+=/dragons_breath,if=equipped.132863
	{'Dragon\'s Breath', 'equipped(132863)'},
	--actions.active_talents+=/living_bomb,if=active_enemies>3&buff.combustion.down
	{'Living Bomb', 'talent(6,1)&active_enemies(40)>3&!buff(Combustion)'}
}

local Combustion = {
	--actions.combustion_phase=rune_of_power,if=buff.combustion.down
	{'Rune of Power', '!buff(Combustion)'},
	--actions.combustion_phase+=/call_action_list,name=active_talents
	{Talents},
	--actions.combustion_phase+=/combustion
	{'Combustion'},
	--actions.combustion_phase+=/potion,name=deadly_grace
	--actions.combustion_phase+=/blood_fury
	{'Blood Fury'},
	--actions.combustion_phase+=/berserking
	{'Berserking'},
	--actions.combustion_phase+=/arcane_torrent
	{'Arcane Torrent'},
	--actions.combustion_phase+=/pyroblast,if=buff.hot_streak.up
	{'Pyroblast', 'buff(Hot Streak!)'},
	--actions.combustion_phase+=/fire_blast,if=buff.heating_up.up
	{'Fire Blast', 'buff(Heating Up)'},
	--actions.combustion_phase+=/phoenixs_flames
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped'},
	--actions.combustion_phase+=/scorch,if=buff.combustion.remains>cast_time
	{'Scorch', 'buff(Combustion).remains>cast_time'},
	--actions.combustion_phase+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health.<=25&equipped(132454)'}
}

local RoP = {
	--actions.rop_phase=rune_of_power
	{'Rune of Power'},
	--actions.rop_phase+=/pyroblast,if=buff.hot_streak.up
	{'Pyroblast', 'buff(Hot Streak!)'},
	--actions.rop_phase+=/call_action_list,name=active_talents
	{Talents},
	--actions.rop_phase+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
	{'Pyroblast', 'buff(Kael\'thas\'s Ultimate Ability).react'},
	--actions.rop_phase+=/fire_blast,if=!prev_off_gcd.fire_blast
	{'Fire Blast', '!prev_off_gcd(Fire Blast)'},
	--actions.rop_phase+=/phoenixs_flames,if=!prev_gcd.phoenixs_flames
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped&!prev_gcd(Phoenix\'s Flames)'},
	--actions.rop_phase+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health<=25&equipped(132454)'},
	--actions.rop_phase+=/fireball
	{'Fireball'}
}

local MainRotation = {
	--actions.single_target=pyroblast,if=buff.hot_streak.up&buff.hot_streak.remains<action.fireball.execute_time
	{'Pyroblast', 'buff(Hot Streak!)&buff(Hot Streak!).remains<action(Fireball.execute_time)'},
	--actions.single_target+=/phoenixs_flames,if=charges_fractional>2.7&active_enemies>2
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped&{action(Phoenix\'s Flames).charges>2.7&active_enemies(40)>2}'},
	--actions.single_target+=/flamestrike,if=talent.flame_patch.enabled&active_enemies>2&buff.hot_streak.react
	{'Flamestrike', 'talent(6,3)&active_enemies>2&buff(Hot Streak!)'},
	--actions.single_target+=/pyroblast,if=buff.hot_streak.up&!prev_gcd.pyroblast
	{'Pyroblast', 'buff(Hot Streak!)&!prev_gcd(Pyroblast)'},
	--actions.single_target+=/pyroblast,if=buff.hot_streak.react&target.health.pct<=25&equipped.132454
	{'Pyroblast', 'buff(Hot Streak!)&target.health<=25&equipped(132454)'},
	--actions.single_target+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
	{'Pyroblast', 'buff(Kael\'thas\'s Ultimate Ability)'},
	--actions.single_target+=/call_action_list,name=active_talents
	{Talents},
	--actions.single_target+=/fire_blast,if=!talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled||charges_fractional>1.4||cooldown.combustion.remains<40)&(3-charges_fractional)*(12*spell_haste)<cooldown.combustion.remains+3||target.time_to_die.remains<4
	{'Fire Blast', '!talent(7,1)&buff(Heating Up)&{!talent(3,2)||action(Fire Blast).charges>1.4||cooldown(Combustion).remains<40}&{3-action(Fire Blast).charges}*{12*spell_haste}<=cooldown(Combustion).remains||target.time_to_die.remains<4'},
	--actions.single_target+=/fire_blast,if=talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled||charges_fractional>1.5||cooldown.combustion.remains<40)&(3-charges_fractional)*(18*spell_haste)<cooldown.combustion.remains+3||target.time_to_die.remains<4
	{'Fire Blast', 'talent(7,1)&buff(Heating Up)&{!talent(3,2)||action(Fire Blast).charges>1.5||{cooldown(Combustion).remains<40}}&{3-action(Fire Blast).charges}*{18*spell_haste}<=cooldown(Combustion).remains||target.time_to_die.remains<4'},
--***
	{'Fire Blast', 'talent(7,1)&buff(Heating Up)&{!talent(3,2)||spell(Fire Blast).charges>1.5||{spell(Combustion).cooldown<40}}&{3 - spell(Fire Blast).charges} * {18 * spell_haste}<=spell(Combustion).cooldown||target.ttd<4'},
--***
	--actions.single_target+=/phoenixs_flames,if=(buff.combustion.up||buff.rune_of_power.up||buff.incanters_flow.stack>3||talent.mirror_image.enabled)&artifact.phoenix_reborn.enabled&(4-charges_fractional)*13<cooldown.combustion.remains+5||target.time_to_die.remains<10
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped&{{buff(Combustion)||buff(Rune of Power)||buff(Incanter\'s Flow).stack>3||talent(3,1)}&{4-action(Phoenix\'s Flames).charges} * 13<cooldown(Combustion).remains + 5||target.time_to_die.remains<10}'},
	--actions.single_target+=/phoenixs_flames,if=(buff.combustion.up||buff.rune_of_power.up)&(4-charges_fractional)*30<cooldown.combustion.remains+5
	{'Phoenix\'s Flames', 'artifact(Phoenix\'s Flames).equipped&{{buff(Combustion)||buff(Rune of Power)}&{4 - action(Phoenix\'s Flames).charges} * 30<cooldown(Combustion).remains + 5}'},
	--actions.single_target+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health<=25&equipped(132454)'},
	--actions.single_target+=/fireball
	{'Fireball'}
}

local xCombat = {
	--actions+=/call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)||buff.combustion.up
	{Combustion, 'cooldown(Combustion).remains<=action(Rune of Power).cast_time||buff(Combustion).'},
	--actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
	{RoP, 'buff(Rune of Power)&!buff(Combustion)'},
	--actions+=/call_action_list,name=single_target
	{MainRotation}
}

local Moving = {
	{'Ice Floes', '!buff(Ice Floes)'},
	{xCombat, 'buff(Ice Floes)'},
	--Scorch as a filler spell when moving.
	{'Scorch', '!buff(Ice Floes)'}
}

local inCombat = {
	{Keybinds},
	--{Interrupts, {'target.interruptAt(50)', 'toggle(Interrupts)', 'target.infront', 'target.range<40'}},
	--{Cooldowns, 'toggle(cooldowns)'},
	--{Survival, 'player.health < 100'},
	--{Moving, 'xmoving=1'},
	--{xCombat, {'target.range<40', 'target.infront'}}
	--{'Scorch', '{18 * player.haste}<spell(Combustion).cooldown'},
	{'Fire Blast', 'talent(7,1)&buff(Heating Up)&{!talent(3,2)||spell(Fire Blast).charges>1.5||{spell(Combustion).cooldown<40}}&{3-spell(Fire Blast).charges}*{18*haste}<=spell(Combustion).cooldown||target.ttd<4'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.Engine.registerRotation(63, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] MAGE - Fire', inCombat, outCombat, exeOnLoad, GUI)
