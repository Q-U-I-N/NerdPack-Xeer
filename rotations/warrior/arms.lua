local GUI = {

}

local exeOnLoad = function()

	--Xeer.Splash()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARRIOR |cffADFF2FArms |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/3 - 6/1 - 7/1")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local _Xeer = {

	{'@Xeer.Targeting()' , '!target.alive'},

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

	--# Executed before combat begins. Accepts non-harmful 	--actions only.
	--actions.precombat=flask,type=countless_armies
	--actions.precombat+=/food,type=nightborne_delicacy_platter
	--actions.precombat+=/augmentation,type=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=old_war

}


local Survival = {

-- {'', ''},

}

local Cooldowns = {

-- {'', ''},

}


local Util = {

	--# Executed every time the actor is available.
	
	--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)||target.time_to_die<=26
	
	--actions+=/blood_fury,if=buff.battle_cry.up||target.time_to_die<=16
	{'Blood Fury', 'buff(Battle Cry)'},
	
	--actions+=/berserking,if=buff.battle_cry.up||target.time_to_die<=11
	{'Berserking', 'buff(Battle Cry)'},
	
	--actions+=/arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40
	{'Arcane Torrent', 'buff(Battle Cry)&talent(6,1)&rage<60'},
	
	--actions+=/battle_cry,if=(buff.bloodlust.up||time>=1)&!gcd.remains&(buff.shattered_defenses.up||(cooldown.colossus_smash.remains&cooldown.warbreaker.remains))||target.time_to_die<=10
	{'Battle Cry', '{buff(Bloodlust)||combat(player).time>1}&{buff(Shattered Defenses)||{spell(Colossus Smash).cooldown>gcd&spell(Warbreaker).cooldown>gcd}}'},
	
	--actions+=/avatar,if=(buff.bloodlust.up||time>=1)
	{'Avatar', 'buff(Bloodlust)||combat(player).time>1'},
	
	--actions+=/use_item,name=gift_of_radiance
	--trinket... 
	
	--actions+=/hamstring,if=buff.battle_cry_deadly_calm.remains>cooldown.hamstring.remains
	--{'Hamstring', 'buff(Battle Cry)&talent(6,1)&!target.debuff(Hamstring)'}, 
	--waste of rage i would say unless ... it's PvP, maybe?
	
	--actions+=/heroic_leap,if=debuff.colossus_smash.up
	--manual usage of leap... seriously
	
	--actions+=/rend,if=remains<gcd
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<=gcd'},
	
	--# The tl;dr of this line is to spam focused rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused rage immediately after mortal strike. 
	--# In game, if focused rage is used the same instant as mortal strike, rage will be deducted for focused rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
	--actions+=/focused_rage,if=buff.battle_cry_deadly_calm.remains>cooldown.focused_rage.remains&(buff.focused_rage.stack<3||!cooldown.mortal_strike.up)&((!buff.focused_rage.react&prev_gcd.mortal_strike)||!prev_gcd.mortal_strike)
	{'Focused Rage', 'buff(Battle Cry)&talent(6,1)&buff(Focused Rage).count<3'},
	
	--actions+=/colossus_smash,if=debuff.colossus_smash.down
	{'Colossus Smash', '!target.debuff(Colossus Smash)'},
	
	--actions+=/warbreaker,if=debuff.colossus_smash.down
	{'Warbreaker', '!target.debuff(Colossus Smash)'},
	
	--actions+=/ravager
	{'Ravager', 'talent(7,3)'},
	
	--actions+=/overpower,if=buff.overpower.react
	{'Overpower', 'buff(Overpower)'}


}

local AoE = {

	--actions.aoe=mortal_strike
	{'Mortal Strike'},
	
	--actions.aoe+=/execute,if=buff.stone_heart.react
	{'Execute', 'buff(Ayala\'s Stone Heart)'},
	
	--actions.aoe+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!buff(Shattered Defenses)&!buff(Precise Strikes)'},
	
	--actions.aoe+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', '!buff(Shattered Defenses)'},

	--actions.aoe+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage>50}&{!talent(5,3)||{buff(Battle Cry)&talent(6,1)}||buff(Cleave)}'},
	
	--actions.aoe+=/rend,if=remains<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<=4.5'},
	
	--actions.aoe+=/bladestorm
	{'Bladestorm'},
	
	--actions.aoe+=/cleave
	{'Cleave'},
	
	--actions.aoe+=/whirlwind,if=rage>=60
	{'Whirlwind', 'rage>=60'},
	
	--actions.aoe+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	
	--actions.aoe+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}

}

local Cleave = {

	--actions.cleave=mortal_strike
	{'Mortal Strike'},
	
	--actions.cleave+=/execute,if=buff.stone_heart.react
	{'Execute', 'buff(Ayala\'s Stone Heart)'},
	
	--actions.cleave+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!buff(Shattered Defenses)&!buff(Precise Strikes)'},
	
	--actions.cleave+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', '!buff(Shattered Defenses)'},
	
	--actions.cleave+=/focused_rage,if=buff.shattered_defenses.down
	{'Focused Rage', '!buff(Shattered Defenses)'},
	
	--actions.cleave+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage>50}&{!talent(5,3)||{buff(Battle Cry)&talent(6,1)}||buff(Cleave)}'},
	
	--actions.cleave+=/rend,if=remains<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).duration<=4.5'},
	
	--actions.cleave+=/bladestorm
	{'Bladestorm'},
	
	--actions.cleave+=/cleave
	{'Cleave'},
	
	--actions.cleave+=/whirlwind,if=rage>=100||buff.focused_rage.stack=3
	{'Whirlwind', 'rage>=100||buff(Focused Rage).count=3'},
	
	--actions.cleave+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	
	--actions.cleave+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}
	
}

local Execute = {

	--actions.execute=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack=3
	{'Mortal Strike', 'buff(Battle Cry)&buff(Focused Rage).count=3'},
	
	--actions.execute+=/execute,if=buff.battle_cry_deadly_calm.up
	{'Execute', 'buff(Battle Cry)&talent(6,1)'},
	
	--actions.execute+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!buff(Shattered Defenses)'},
	
	--actions.execute+=/warbreaker,if=buff.shattered_defenses.down&rage<=30
	{'Warbreaker', '!buff(Shattered Defenses)&rage<=30'},
	
	--actions.execute+=/execute,if=buff.shattered_defenses.up&rage>22||buff.shattered_defenses.down
	{'Execute', '{buff(Shattered Defenses)&rage>22}||!buff(Shattered Defenses)'}	

}

local ST = {

	--actions.single=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack>=1&buff.battle_cry.remains<gcd
	{'Mortal Strike', 'buff(Battle Cry)&buff(Focused Rage).count>=1&spell(Battle Cry).cooldown<gcd'},
	
	--actions.single+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!buff(Shattered Defenses)'},
	
	--actions.single+=/warbreaker,if=buff.shattered_defenses.down&cooldown.mortal_strike.remains<gcd
	{'Warbreaker', '!buff(Shattered Defenses)&spell(Mortal Strike).cooldown<gcd'},
	
	--actions.single+=/focused_rage,if=((!buff.focused_rage.react&prev_gcd.mortal_strike)||!prev_gcd.mortal_strike)&buff.focused_rage.stack<3&(buff.shattered_defenses.up||cooldown.colossus_smash.remains)
	{'Focused Rage', '!buff(Focused Rage)||buff(Focused Rage).count<3&{buff(Shattered Defenses)||spell(Colossus Smash).cooldown>gcd}'},
	
	--actions.single+=/mortal_strike
	{'Mortal Strike'},
	
	--actions.single+=/execute,if=buff.stone_heart.react
	{'Execute', 'buff(Ayala\'s Stone Heart)'},
	
	--actions.single+=/slam,if=buff.battle_cry_deadly_calm.up||buff.focused_rage.stack=3||rage.deficit<=30
	{'Slam', '{buff(Battle Cry)&talent(6,1)}||buff(Focused Rage).count=3||rage>=70'},
	
	--actions.single+=/execute,if=equipped.archavons_heavy_hand
	{'Execute', 'equipped(137060)'},
	
	--actions.single+=/slam,if=equipped.archavons_heavy_hand
	{'Slam', 'equipped(137060)'},
	
	--actions.single+=/focused_rage,if=equipped.archavons_heavy_hand
	{'Focused Rage', 'equipped(137060)'}
	
}

local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
	
}

local inCombat = {

	{Keybinds},
	{_Xeer},
	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	
	--actions=charge
	{'Charge', 'target.range>8&target.range<=25&target.infront'},
	
	{Util, 'target.range<8'},
	
	--actions+=/run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
	{Cleave, 'player.area(8).enemies>=2&talent(1,3)'},
	
	--actions+=/run_action_list,name=aoe,if=spell_targets.whirlwind>=2&!talent.sweeping_strikes.enabled
	{AoE, 'player.area(8).enemies>=2&!talent(1,3)'},
	
	--actions+=/run_action_list,name=execute,if=target.health.pct<=20
	{Execute, {'target.range < 8', 'target.infront', 'target.health<=20'}},
	
	--actions+=/run_action_list,name=single,if=target.health.pct>20
	{ST, {'target.range<8', 'target.infront', 'target.health>20'}}
	
}

local outCombat = {

	{Keybinds},
	{PreCombat}
	
}

NeP.Engine.registerRotation(71, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] WARRIOR - Arms', inCombat, outCombat, exeOnLoad, GUI)