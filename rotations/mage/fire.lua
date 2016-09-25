local GUI = {

}
local exeOnLoad = function()
	--Xeer.Splash()
end

local Survival = {

}

local Moving = {
	--Scorch as a filler spell when moving.
	{'Scorch'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Talents = {
	--actions.active_talents=flame_on,if=action.fire_blast.charges=0&(cooldown.combustion.remains>40+(talent.kindling.enabled*25)|target.time_to_die.remains<cooldown.combustion.remains)
	--actions.active_talents+=/blast_wave,if=(buff.combustion.down)|(buff.combustion.up&action.fire_blast.charges<1&action.phoenixs_flames.charges<1)
	--actions.active_talents+=/meteor,if=cooldown.combustion.remains>30|(cooldown.combustion.remains>target.time_to_die)|buff.rune_of_power.up
	--actions.active_talents+=/cinderstorm,if=cooldown.combustion.remains<cast_time&(buff.rune_of_power.up|!talent.rune_on_power.enabled)|cooldown.combustion.remains>10*spell_haste&!buff.combustion.up
	--actions.active_talents+=/dragons_breath,if=equipped.132863
	--actions.active_talents+=/living_bomb,if=active_enemies>3&buff.combustion.down
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
	{'Pyroblast', 'buff(Hot Streak)'},
	--actions.combustion_phase+=/fire_blast,if=buff.heating_up.up
	{'Fire Blast', 'buff(Heating Up)'},
	--actions.combustion_phase+=/phoenixs_flames
	{'Phoenixs Flames'},
	--actions.combustion_phase+=/scorch,if=buff.combustion.remains>cast_time
	--actions.combustion_phase+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health<=25&equipped(132454)'},
}

local ROP = {
	--actions.rop_phase=rune_of_power
	{'Rune of Power'},
	--actions.rop_phase+=/pyroblast,if=buff.hot_streak.up
	{'Pyroblast', 'buff(Hot Streak)'},
	--actions.rop_phase+=/call_action_list,name=active_talents
	{Talents},
	--actions.rop_phase+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
	{'Pyroblast', 'buff(Kael\'thas\'s Ultimate Ability)'},
	--actions.rop_phase+=/fire_blast,if=!prev_off_gcd.fire_blast
	--actions.rop_phase+=/phoenixs_flames,if=!prev_gcd.phoenixs_flames
	--actions.rop_phase+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health<=25&equipped(132454)'},
	--actions.rop_phase+=/fireball
	{'Fireball'}
}

local ST = {
	--actions.single_target=pyroblast,if=buff.hot_streak.up&buff.hot_streak.remains<action.fireball.execute_time
	--actions.single_target+=/phoenixs_flames,if=charges_fractional>2.7&active_enemies>2
	--actions.single_target+=/flamestrike,if=talent.flame_patch.enabled&active_enemies>2&buff.hot_streak.react
	--actions.single_target+=/pyroblast,if=buff.hot_streak.up&!prev_gcd.pyroblast
	--actions.single_target+=/pyroblast,if=buff.hot_streak.react&target.health.pct<=25&equipped.132454
	--actions.single_target+=/pyroblast,if=buff.kaelthas_ultimate_ability.react
	--actions.single_target+=/call_action_list,name=active_talents
	{Talents},
	--actions.single_target+=/fire_blast,if=!talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.4|cooldown.combustion.remains<40)&(3-charges_fractional)*(12*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
	--actions.single_target+=/fire_blast,if=talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.5|cooldown.combustion.remains<40)&(3-charges_fractional)*(18*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
	--actions.single_target+=/phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up|buff.incanters_flow.stack>3|talent.mirror_image.enabled)&artifact.phoenix_reborn.enabled&(4-charges_fractional)*13<cooldown.combustion.remains+5|target.time_to_die.remains<10
	{'Phoenixs Flames', '{buff(combustion)|buff(Rune of Power)|buff(Incanters Flow).count>3|talent(3,1)}&spell(Phoenix Reborn).exists&{spell.charges>=2|target.tdd<10}'},
	--actions.single_target+=/phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up)&(4-charges_fractional)*30<cooldown.combustion.remains+5
	{'Phoenixs Flames', '{buff(combustion)|buff(Rune of Power)}&spell.charges>=2'},
	--actions.single_target+=/scorch,if=target.health.pct<=25&equipped.132454
	{'Scorch', 'target.health<=25&equipped(132454)'},
	--actions.single_target+=/fireball
	{'Fireball'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Moving, 'player.moving'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	
	--# Executed every time the actor is available.
	--actions=counterspell,if=target.debuff.casting.react
	--actions+=/time_warp,if=target.health.pct<25|time=0
	--actions+=/shard_of_the_exodar_warp,if=buff.bloodlust.down
	--actions+=/mirror_image,if=buff.combustion.down
	{'Mirror Image', 'buff(Combustion)'},
	--actions+=/rune_of_power,if=cooldown.combustion.remains>40&buff.combustion.down&(cooldown.flame_on.remains<5|cooldown.flame_on.remains>30)&!talent.kindling.enabled|target.time_to_die.remains<11|talent.kindling.enabled&(charges_fractional>1.8|time<40)&cooldown.combustion.remains>40
	--actions+=/call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)|buff.combustion.up
	{Combustion, 'buff(Combustion)'},
	--actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
	{ROP, 'buff(Rune of Power)&!buff(Combustion)'},
	--actions+=/call_action_list,name=single_target
	{ST, 'target.range<=40&target.infront'},
}

local outCombat = {
	{Keybinds},
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=flask_of_the_whispered_pact
	--actions.precombat+=/food,type=the_hungry_magister
	--actions.precombat+=/augmentation,type=defiled
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/mirror_image
	--actions.precombat+=/potion,name=deadly_grace
	--actions.precombat+=/pyroblast
}

NeP.Engine.registerRotation(63, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Mage - Fire', inCombat, outCombat, exeOnLoad, GUI)