local GUI = {

}

local exeOnLoad = function()

end

local _Xeer = {
--[[
warrior="Warrior_Fury_T19P"
level=110
race=tauren
role=attack
position=back
talents=2232133
artifact=35:0:0:0:0:982:1:984:1:985:1:986:1:988:3:990:3:991:3:995:3:996:3:1357:1
spec=fury
]]--
}

local PreCombat = {
--# Executed before combat begins. Accepts non-harmful --actions only.
--actions.precombat=flask,type=countless_armies
--actions.precombat+=/food,type=nightborne_delicacy_platter
--actions.precombat+=/augmentation,type=defiled
--# Snapshot raid buffed stats before combat begins and pre-potting is done.
--actions.precombat+=/snapshot_stats
--actions.precombat+=/potion,name=old_war

}


local Survival = {

}

local Cooldowns = {

--# Executed every time the actor is available.
--actions=auto_attack
--actions+=/charge
--# This is mostly to prevent cooldowns from being accidentally used during movement.
--actions+=/run_action_list,name=movement,if=movement.distance>5
--actions+=/heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)|!raid_event.movement.exists
--actions+=/use_item,name=faulty_countermeasure,if=(spell_targets.whirlwind>1|!raid_event.adds.exists)&((talent.bladestorm.enabled&cooldown.bladestorm.remains=0)|buff.battle_cry.up|target.time_to_die<25)
--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)|target.time_to_die<30
--actions+=/battle_cry,if=(cooldown.odyns_fury.remains=0&(cooldown.bloodthirst.remains=0|(buff.enrage.remains>cooldown.bloodthirst.remains)))
--actions+=/avatar,if=buff.battle_cry.up|(target.time_to_die<(cooldown.battle_cry.remains+10))
--actions+=/bloodbath,if=buff.dragon_roar.up|(!talent.dragon_roar.enabled&(buff.battle_cry.up|cooldown.battle_cry.remains>10))
--actions+=/blood_fury,if=buff.battle_cry.up
--actions+=/berserking,if=buff.battle_cry.up
--actions+=/arcane_torrent,if=rage<rage.max-40
--actions+=/call_action_list,name=two_targets,if=spell_targets.whirlwind=2|spell_targets.whirlwind=3
--actions+=/call_action_list,name=aoe,if=spell_targets.whirlwind>3
--actions+=/call_action_list,name=single_target

}

local Bladestorm = {

--actions.bladestorm=bladestorm,if=buff.enrage.remains>2&(raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets)

}

local AoE = {

--actions.aoe=bloodthirst,if=buff.enrage.down|rage<50
--actions.aoe+=/call_action_list,name=bladestorm
{Bladestorm},

--actions.aoe+=/whirlwind,if=buff.enrage.up
--actions.aoe+=/dragon_roar
--actions.aoe+=/rampage,if=buff.meat_cleaver.up
--actions.aoe+=/bloodthirst
--actions.aoe+=/whirlwind

}


local ST = {

--actions.single_target=bloodthirst,if=buff.fujiedas_fury.up&buff.fujiedas_fury.remains<2
--actions.single_target+=/execute,if=(artifact.juggernaut.enabled&(!buff.juggernaut.up|buff.juggernaut.remains<2))|buff.stone_heart.react
--actions.single_target+=/rampage,if=rage=100&(target.health.pct>20|target.health.pct<20&!talent.massacre.enabled)|buff.massacre.react&buff.enrage.remains<1
--actions.single_target+=/berserker_rage,if=talent.outburst.enabled&cooldown.odyns_fury.remains=0&buff.enrage.down
--actions.single_target+=/dragon_roar,if=!cooldown.odyns_fury.remains<=10|cooldown.odyns_fury.remains<3
--actions.single_target+=/odyns_fury,if=buff.battle_cry.up&buff.enrage.up
--actions.single_target+=/rampage,if=buff.enrage.down&buff.juggernaut.down
--actions.single_target+=/furious_slash,if=talent.frenzy.enabled&(buff.frenzy.down|buff.frenzy.remains<=3)
--actions.single_target+=/raging_blow,if=buff.juggernaut.down&buff.enrage.up
--actions.single_target+=/whirlwind,if=buff.wrecking_ball.react&buff.enrage.up
--actions.single_target+=/execute,if=talent.inner_rage.enabled|!talent.inner_rage.enabled&rage>50
--actions.single_target+=/bloodthirst,if=buff.enrage.down
--actions.single_target+=/raging_blow,if=buff.enrage.down
--actions.single_target+=/execute,if=artifact.juggernaut.enabled
--actions.single_target+=/raging_blow
--actions.single_target+=/bloodthirst
--actions.single_target+=/furious_slash
--actions.single_target+=/call_action_list,name=bladestorm
{Bladestorm},

--actions.single_target+=/bloodbath,if=buff.frothing_berserker.up|(rage>80&!talent.frothing_berserker.enabled)

}

local TwoTargets = {

--actions.two_targets=whirlwind,if=buff.meat_cleaver.down
--actions.two_targets+=/call_action_list,name=bladestorm
{Bladestorm},

--actions.two_targets+=/rampage,if=buff.enrage.down|(rage=100&buff.juggernaut.down)|buff.massacre.up
--actions.two_targets+=/bloodthirst,if=buff.enrage.down
--actions.two_targets+=/raging_blow,if=talent.inner_rage.enabled&spell_targets.whirlwind=2
--actions.two_targets+=/whirlwind,if=spell_targets.whirlwind>2
--actions.two_targets+=/dragon_roar
--actions.two_targets+=/bloodthirst
--actions.two_targets+=/whirlwind

}



local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	
	--actions.movement=heroic_leap
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
}

local inCombat = {

	{Keybinds},
	{_Xeer},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	--actions+=/call_action_list,name=two_targets,if=spell_targets.whirlwind=2|spell_targets.whirlwind=3
	{TwoTargets},
	--actions+=/call_action_list,name=aoe,if=spell_targets.whirlwind>3
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	--actions+=/call_action_list,name=single_target
	{ST, {'target.range < 8', 'target.infront'}}
	
}

local outCombat = {

	{Keybinds},
	{PreCombat},
	
}

NeP.Engine.registerRotation(72, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] WARRIOR - Fury', inCombat, outCombat, exeOnLoad, GUI)