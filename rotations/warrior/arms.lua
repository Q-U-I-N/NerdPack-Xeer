local GUI = {

}

local exeOnLoad = function()

end

local _Xeer = {
--[[
warrior="Warrior_Arms_T19P"
level=110
race=blood_elf
role=attack
position=back
talents=1332311
artifact=36:0:0:0:0:1136:1:1137:1:1139:1:1142:1:1145:3:1147:3:1148:3:1149:3:1150:3:1356:1
spec=arms
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
--actions=charge
--actions+=/auto_attack
--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)|target.time_to_die<=26
--actions+=/blood_fury,if=buff.battle_cry.up|target.time_to_die<=16
--actions+=/berserking,if=buff.battle_cry.up|target.time_to_die<=11
--actions+=/arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40
--actions+=/battle_cry,if=(buff.bloodlust.up|time>=1)&!gcd.remains&(buff.shattered_defenses.up|(cooldown.colossus_smash.remains&cooldown.warbreaker.remains))|target.time_to_die<=10
--actions+=/avatar,if=(buff.bloodlust.up|time>=1)
--actions+=/use_item,name=gift_of_radiance
--actions+=/hamstring,if=buff.battle_cry_deadly_calm.remains>cooldown.hamstring.remains
--actions+=/heroic_leap,if=debuff.colossus_smash.up
--actions+=/rend,if=remains<gcd
--# The tl;dr of this line is to spam focused rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused rage immediately after mortal strike. 
--# In game, if focused rage is used the same instant as mortal strike, rage will be deducted for focused rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
--actions+=/focused_rage,if=buff.battle_cry_deadly_calm.remains>cooldown.focused_rage.remains&(buff.focused_rage.stack<3|!cooldown.mortal_strike.up)&((!buff.focused_rage.react&prev_gcd.mortal_strike)|!prev_gcd.mortal_strike)
--actions+=/colossus_smash,if=debuff.colossus_smash.down
--actions+=/warbreaker,if=debuff.colossus_smash.down
--actions+=/ravager
--actions+=/overpower,if=buff.overpower.react
--actions+=/run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
--actions+=/run_action_list,name=aoe,if=spell_targets.whirlwind>=2&!talent.sweeping_strikes.enabled
--actions+=/run_action_list,name=execute,if=target.health.pct<=20
--actions+=/run_action_list,name=single,if=target.health.pct>20

}

local AoE = {

--actions.aoe=mortal_strike
--actions.aoe+=/execute,if=buff.stone_heart.react
--actions.aoe+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
--actions.aoe+=/warbreaker,if=buff.shattered_defenses.down
--actions.aoe+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up|rage.deficit<50)&(!talent.focused_rage.enabled|buff.battle_cry_deadly_calm.up|buff.cleave.up)
--actions.aoe+=/rend,if=remains<=duration*0.3
--actions.aoe+=/bladestorm
--actions.aoe+=/cleave
--actions.aoe+=/whirlwind,if=rage>=60
--actions.aoe+=/shockwave
--actions.aoe+=/storm_bolt

}

local Cleave = {

--actions.cleave=mortal_strike
--actions.cleave+=/execute,if=buff.stone_heart.react
--actions.cleave+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
--actions.cleave+=/warbreaker,if=buff.shattered_defenses.down
--actions.cleave+=/focused_rage,if=buff.shattered_defenses.down
--actions.cleave+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up|rage.deficit<50)&(!talent.focused_rage.enabled|buff.battle_cry_deadly_calm.up|buff.cleave.up)
--actions.cleave+=/rend,if=remains<=duration*0.3
--actions.cleave+=/bladestorm
--actions.cleave+=/cleave
--actions.cleave+=/whirlwind,if=rage>=100|buff.focused_rage.stack=3
--actions.cleave+=/shockwave
--actions.cleave+=/storm_bolt

}

local Execute = {

--actions.execute=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack=3
--actions.execute+=/execute,if=buff.battle_cry_deadly_calm.up
--actions.execute+=/colossus_smash,if=buff.shattered_defenses.down
--actions.execute+=/warbreaker,if=buff.shattered_defenses.down&rage<=30
--actions.execute+=/execute,if=buff.shattered_defenses.up&rage>22|buff.shattered_defenses.down
--# --actions.single+=/heroic_charge,if=rage.deficit>=40&(!cooldown.heroic_leap.remains|swing.mh.remains>1.2)
--#Remove the --# above to run out of melee and charge back in for rage.
--actions.execute+=/bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets


}

local ST = {

--actions.single=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack>=1&buff.battle_cry.remains<gcd
--actions.single+=/colossus_smash,if=buff.shattered_defenses.down
--actions.single+=/warbreaker,if=buff.shattered_defenses.down&cooldown.mortal_strike.remains<gcd
--actions.single+=/focused_rage,if=((!buff.focused_rage.react&prev_gcd.mortal_strike)|!prev_gcd.mortal_strike)&buff.focused_rage.stack<3&(buff.shattered_defenses.up|cooldown.colossus_smash.remains)
--actions.single+=/mortal_strike
--actions.single+=/execute,if=buff.stone_heart.react
--actions.single+=/slam,if=buff.battle_cry_deadly_calm.up|buff.focused_rage.stack=3|rage.deficit<=30
--actions.single+=/execute,if=equipped.archavons_heavy_hand
--actions.single+=/slam,if=equipped.archavons_heavy_hand
--actions.single+=/focused_rage,if=equipped.archavons_heavy_hand
--# --actions.single+=/heroic_charge,if=rage.deficit>=40&(!cooldown.heroic_leap.remains|swing.mh.remains>1.2)
--#Remove the --# above to run out of melee and charge back in for rage.
--actions.single+=/bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets


}

local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
	
}

local inCombat = {

	{Keybinds},
	{_Xeer},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	--actions+=/run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
	{Cleave},
	--actions+=/run_action_list,name=aoe,if=spell_targets.whirlwind>=2&!talent.sweeping_strikes.enabled
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	--actions+=/run_action_list,name=execute,if=target.health.pct<=20
	{Execute},
	--actions+=/run_action_list,name=single,if=target.health.pct>20
	{ST, {'target.range < 8', 'target.infront'}}
	
}

local outCombat = {

	{Keybinds},
	{PreCombat},
	
}

NeP.Engine.registerRotation(71, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] WARRIOR - Arms', inCombat, outCombat, exeOnLoad, GUI)