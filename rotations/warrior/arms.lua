local _, Xeer = ...

local GUI = {

}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARRIOR |cffADFF2FArms |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/2 - 5/3 - 6/1 - 7/1")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

end

local XeerX = {
	{'@Xeer.Targeting', '!target.alive'},

--{'Charge', 'target.range>8&target.range<=25&target.infront'},

--[[
warrior="Warrior_Arms_T19P"
level=110
race=blood_elf
role=attack
position=back
talents=1332311
artifact=36:0:0:0:0:1136:1:1137:1:1139:1:1142:1:1145:3:1147:3:1148:3:1149:3:1150:3:1356:1
spec=arms

# Gear Summary
# gear_ilvl=842.00
# gear_strength=11138
# gear_stamina=17965
# gear_crit_rating=984
# gear_haste_rating=2229
# gear_mastery_rating=12496
# gear_versatility_rating=2013
# gear_armor=3965
--]]
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
	{'Victory Rush', 'player.health<=70'},
}

local Cooldowns = {
	--actions+=/potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)||target.time_to_die<=26
	--actions+=/blood_fury,if=buff.battle_cry.up||target.time_to_die<=16
	{'Blood Fury', 'player.buff(Battle Cry)'},
	--actions+=/berserking,if=buff.battle_cry.up||target.time_to_die<=11
	{'Berserking', 'player.buff(Battle Cry)'},
	--actions+=/arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40
	--{'Arcane Torrent', 'player.buff(Battle Cry)&talent(6,1)&rage.deficit>40'},
	--actions+=/battle_cry,if=(buff.bloodlust.up|time>=1)&gcd.remains<0.5&(buff.shattered_defenses.up|(cooldown.colossus_smash.remains&cooldown.warbreaker.remains))|target.time_to_die<=10
	{'Battle Cry', '{player.buff(Bloodlust)||xtime>=1}&gcd.remains<0.5&{player.buff(Shattered Defenses)||{cooldown(Colossus Smash).remains>gcd&cooldown(Warbreaker).remains>gcd}}'},
	--actions+=/avatar,if=(buff.bloodlust.up||time>=1)
	{'Avatar', 'talent(3,3)&{player.buff(Bloodlust)||xtime>=1}'},
	--actions+=/use_item,name=gift_of_radiance
	--trinket...
}

local Opener = {
	{'Charge'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Focused Rage'},
	{'Battle Cry'},
	{'Avatar'},
	{'Mortal Strike'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Slam'},
	{'Focused Rage'},
	{'Colossus Smash'},
	{'Slam'},
	{'Focused Rage'},
	{'Mortal Strike'},
	{'Slam'},
}

local Util = {
	{Cooldowns, 'toggle(cooldowns)'},
	--actions+=/hamstring,if=buff.battle_cry_deadly_calm.remains>cooldown.hamstring.remains
	--{'Hamstring', 'player.buff(Battle Cry)&talent(6,1)&!target.debuff(Hamstring)'},	--waste of player.rage i would say unless ... it's PvP, maybe?
	--actions+=/heroic_leap,if=debuff.colossus_smash.up
	--manual usage of leap via ctrl keybind...
	--actions+=/rend,if=remains<gcd
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<gcd'},
	--# The tl;dr of this line is to spam focused player.rage inside battle cry, the added nonsense is to help modeling the difficulty of timing focused player.rage immediately after mortal strike.
	--# In game, if focused player.rage is used the same instant as mortal strike, player.rage will be deducted for focused player.rage, the buff is immediately consumed, but it does not buff the damage of mortal strike.
	--actions+=/focused_rage,if=buff.battle_cry_deadly_calm.remains>cooldown.focused_rage.remains&(buff.focused_rage.stack<3||!cooldown.mortal_strike.up)&((!buff.focused_rage.up&prev_gcd.mortal_strike)||!prev_gcd.mortal_strike)
	{'Focused Rage', 'player.buff(Battle Cry)&talent(6,1)&player.buff(Focused Rage).stack<3'},
	--actions+=/colossus_smash,if=debuff.colossus_smash.down
	{'Colossus Smash', '!target.debuff(Colossus Smash)'},
	--actions+=/warbreaker,if=debuff.colossus_smash.down
	{'Warbreaker', 'artifact(Warbreaker).equipped&!target.debuff(Colossus Smash)'},
	--actions+=/ravager
	{'Ravager', 'talent(7,3)'},
	--actions+=/overpower,if=buff.overpower.up
	{'Overpower', 'player.buff(Overpower!)'}
}

local AoE = {
	--actions.aoe=mortal_strike
	{'Mortal Strike', 'player.buff(Focused Rage).stack>=2'},
	--actions.aoe+=/execute,if=buff.stone_heart.up
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--actions.aoe+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	--actions.aoe+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	--actions.aoe+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	--actions.aoe+=/rend,if=remains<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<=4.5'},
	--actions.aoe+=/bladestorm
	{'Bladestorm'},
	--actions.aoe+=/cleave
	{'Cleave'},
	--+actions.aoe+=/execute,if=rage>90
	{'Execute', 'player.rage>=90'},
	--actions.aoe+=/whirlwind,if=rage>=40
	{'Whirlwind', 'player.rage>=40'},
	--actions.aoe+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	--actions.aoe+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}
}

local Cleave = {
	--actions.cleave=mortal_strike
	{'Mortal Strike', 'player.buff(Focused Rage).stack>=2'},
	--actions.cleave+=/execute,if=buff.stone_heart.up
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},
	--actions.cleave+=/colossus_smash,if=buff.shattered_defenses.down&buff.precise_strikes.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)&!player.buff(Precise Strikes)'},
	--actions.cleave+=/warbreaker,if=buff.shattered_defenses.down
	{'Warbreaker', '!player.buff(Shattered Defenses)'},
	--actions.cleave+=/focused_rage,if=buff.shattered_defenses.down
	{'Focused Rage', '!player.buff(Shattered Defenses)'},
	--actions.cleave+=/whirlwind,if=talent.fervor_of_battle.enabled&(debuff.colossus_smash.up||rage.deficit<50)&(!talent.focused_rage.enabled||buff.battle_cry_deadly_calm.up||buff.cleave.up)
	{'Whirlwind', 'talent(3,1)&{target.debuff(Colossus Smash)||rage.deficit<50}&{!talent(5,3)||{player.buff(Battle Cry)&talent(6,1)}||player.buff(Cleave)}'},
	--actions.cleave+=/rend,if=remains<=duration*0.3
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<=4.5'},
	--actions.cleave+=/bladestorm
	{'Bladestorm'},
	--actions.cleave+=/cleave
	{'Cleave'},
	--actions.cleave+=/whirlwind,if=player.rage>=100||buff.focused_rage.stack=3
	{'Whirlwind', 'player.rage>=100||player.buff(Focused Rage).stack=3'},
	--actions.cleave+=/shockwave
	{'Shockwave', 'talent(2,1)'},
	--actions.cleave+=/storm_bolt
	{'Storm Bolt', 'talent(2,2)'}
}

local Execute = {
	--actions.execute=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack=3
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack=3'},
	--actions.execute+=/execute,if=buff.battle_cry_deadly_calm.up
	{'Execute', 'player.buff(Battle Cry)&talent(6,1)'},
	--actions.execute+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	--actions.execute+=/warbreaker,if=buff.shattered_defenses.down&player.rage<=30
	{'Warbreaker', '!player.buff(Shattered Defenses)&player.rage<=30'},
	--actions.execute+=/execute,if=buff.shattered_defenses.up&player.rage>22
	{'Execute', 'player.buff(Shattered Defenses)&player.rage>22'},
	--actions.execute+=/execute,if=buff.shattered_defenses.down&((equipped.archavons_heavy_hand&rage>40)|!equipped.archavons_heavy_hand)
	{'Execute', '!player.buff(Shattered Defenses)&{{xequipped(137060)&rage>40}||!xequipped(137060)}'},
	--actions.execute+=/mortal_strike,if=equipped.archavons_heavy_hand
	{'Mortal Strike', 'xequipped(137060)'},
 	--actions.execute+=/execute,if=buff.shattered_defenses.down
	{'Execute', '!player.buff(Shattered Defenses)'},
	--actions.execute+=/bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets
  {'Bladestorm'},
}

local ST = {
	--actions.single=mortal_strike,if=buff.battle_cry.up&buff.focused_rage.stack>=1&buff.battle_cry.remains<gcd
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack>=1&cooldown(Battle Cry).remains<gcd'},
	--actions.single+=/colossus_smash,if=buff.shattered_defenses.down
	{'Colossus Smash', '!player.buff(Shattered Defenses)'},
	--actions.single+=/warbreaker,if=buff.shattered_defenses.down&cooldown.mortal_strike.remains<gcd
	{'Warbreaker', '!player.buff(Shattered Defenses)&cooldown(Mortal Strike).remains<gcd'},
	--actions.single+=/focused_rage,if=(((!buff.focused_rage.up&prev_gcd.mortal_strike)|!prev_gcd.mortal_strike)&buff.focused_rage.stack<3&(buff.shattered_defenses.up|cooldown.colossus_smash.remains))&player.rage>60
	{'Focused Rage', '{{{!player.buff(Focused Rage)&prev_gcd(Mortal Strike)}||!prev_gcd(Mortal Strike)}&player.buff(Focused Rage).stack<3&{player.buff(Shattered Defenses)||cooldown(Colossus Smash).remains>gcd}}&player.rage>60'},
	--actions.single+=/mortal_strike
	{'Mortal Strike', 'player.buff(Focused Rage).stack>=1'},
	--actions.single+=/execute,if=buff.stone_heart.up
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'},

	--Whirlwind instead Slam if "Fevor of Battle" is picked
	--{'Whirlwind', 'talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<=30}'},
	--actions.single+=/slam,if=buff.battle_cry_deadly_calm.up||buff.focused_rage.stack=3||rage.deficit<=30
	--{'Slam', '!talent(3,1)&{{player.buff(Battle Cry)&talent(6,1)}||player.buff(Focused Rage).stack=3||rage.deficit<=30}'},
	{'Mortal Strike', '!talent(5,3)'},
	--actions.single+=/whirlwind,if=spell_targets.whirlwind>1
	{'Whirlwind', 'player.area(8).enemies>1||talent(3,1)&player.rage>=45'},
	--actions.single+=/slam,if=spell_targets.whirlwind=1
	{'Slam', '!talent(3,1)&player.area(8).enemies=1&player.rage>=32'},
	--actions.single+=/execute,if=equipped.archavons_heavy_hand
	{'Execute', 'xequipped(137060)'},
	--actions.single+=/focused_rage,if=equipped.archavons_heavy_hand
	{'Focused Rage', 'xequipped(137060)'},
	--actions.single+=/bladestorm,interrupt=1,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>desired_targets
	{'Bladestorm'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&cooldown(Pummel).remains>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	--{XeerX},
	{Survival, 'player.health<100'},
	--{Cooldowns, 'toggle(cooldowns)&target.range<8'},
	{Util, 'target.range<8'},
	--actions+=/run_action_list,name=cleave,if=spell_targets.whirlwind>=2&talent.sweeping_strikes.enabled
	{Cleave, 'toggle(aoe)&player.area(8).enemies>=2&talent(1,3)'},
	--actions+=/run_action_list,name=aoe,if=spell_targets.whirlwind>=5&!talent.sweeping_strikes.enabled
	{AoE, 'toggle(aoe)&player.area(8).enemies>=5&!talent(1,3)'},
	--actions+=/run_action_list,name=execute,target_if=target.health.pct<=20&spell_targets.whirlwind<5
	{Execute, 'target.range<8&target.infront&target.health<=20&player.area(8).enemies<5'},
	--actions+=/run_action_list,name=single,if=target.health.pct>20
	{ST, 'target.range<8&target.infront&target.health>20'}
}


local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(71, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] WARRIOR - Arms',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})

--[[
TODO:

Opener:
Charge
Focused Rage -> Colossus Smash
Focused Rage -> Battle Cry
Avatar
Mortal Strike
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc)
Focused Rage -> Colossus Smash (Slam if Tactician didn’t proc, or if you have Shattered Defenses)
Focused Rage -> Mortal Strike (Slam if Tactician didn’t proc)

Standard Rotation/Priority list:
Above 20%:
Use Colossus Smash and Mortal Strike on cooldown (Don't overwrite Shattered Defenses).
If you get a Colossus Smash proc, do Colossus Smash Focused Rage -> Mortal Strike.
Use slam when above 32 rage and both Colossus Smash and Mortal Strike are on cd.
Use Focused Rage to not avoid ragecapping (about 25 rage from cap).

Below 20%:
Use Colossus Smash on CD (Don't overwrite Shattered Defenses) -> 22 (18 with Dauntless and 3/3 PS) rage
Execute with the Shattered Defenses -> spam Execute when you don’t have Shattered Defenses.
Use Focused Rage if you're about to rage cap (about 25 rage from cap), save Focused Rage stacks for Battle Cry.

Battle Cry Rotation:
Above 20%:
Colossus Smash -> Battle Cry
Focused Rage
Mortal Strike -> Focused Rage
Colossus Smash (Slam if no Colossus Smash) -> Focused Rage
Colossus Smash (Slam if no Colossus Smash, or Shattered Defenses proc) -> Mortal Strike (Colossus Smash if Mortal Strike isn't up and no Shattered Defenses buff, Slam if neither Colossus Smash/Mortal Strike is up)
Below 20%:
Colossus Smash -> Battle Cry
Execute
Focused Rage -> Execute
Focused Rage -> Execute
Focused Rage -> x3 Focused Rage
Mortal Strike (Only use Colossus Smash if the debuff isn’t on the target. 2 Executes are more damage than 1 Colossus Smash + 1 Shattered Defenses Execute)
--]]
