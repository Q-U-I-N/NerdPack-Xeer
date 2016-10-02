local GUI = {

}

local exeOnLoad = function()

	Xeer.Splash()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHUNTER |cffADFF2FMarksmanship |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/X - 4/3 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface.CreateToggle(
		'xBarrage',
		'Interface\\Icons\\Ability_Hunter_RapidRegeneration',
		'Barrage',
		'ON/OFF using Barrage in rotation if you have talent')


end

local _Xeer = { -- some non-SiMC stuffs

	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},


--[[
hunter="Hunter_MM_T19P"
level=110
race=blood_elf
role=attack
position=ranged_back
talents=1103021
artifact=55:137493:137412:137327:0:307:1:308:1:310:1:312:3:313:3:315:3:318:3:319:3:320:3:322:1:1337:1
spec=marksmanship

# Gear Summary
# gear_ilvl=842.00
# gear_agility=10183
# gear_stamina=17963
# gear_crit_rating=1307
# gear_haste_rating=4499
# gear_mastery_rating=11154
# gear_versatility_rating=898
# gear_armor=2433
# set_bonus=tier19p_mail_2pc=1
summon_pet=cat
--]]

}

local PreCombat = {

	--# Executed before combat begins. Accepts non-harmful actions. only.
 	--actions..precombat=flask,type=flask_of_the_seventh_demon
	--{'', ''},

 	--actions..precombat+=/food,type=nightborne_delicacy_platter
	--{'', ''},

 	--actions..precombat+=/summon_pet
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--{'', ''},

 	--actions..precombat+=/snapshot_stats
	--{'', ''},

 	--actions..precombat+=/potion,name=deadly_grace
	--{'', ''},

 	--actions..precombat+=/augmentation,type=defiled
	--{'', ''},

 	--actions..precombat+=/windburst
	--{'', ''}

}

local Survival = {

}


local Cooldowns = {

 	--actions..cooldowns=potion,name=deadly_grace,if=(buff.trueshot.react&buff.bloodlust.react)||buff.bullseye.react>=23
	--{'', ''},

 	--actions..cooldowns+=/trueshot,if=(buff.bloodlust.react||target.health.pct>20+(cooldown.trueshot.remains+15))||buff.bullseye.react>25
	{'Trueshot', '{buff(Bloodlust)||target.health>20+{spell(Trueshot).cooldown+15}}||buff(Bullseye).stack>25'}

}

local Barrage = {

--actions.+=/barrage
	{'Barrage', 'talent(6,2)'},

}

local xCombat = {

	--# Executed every time the actor is available.
 	--actions.+=/arcane_torrent,if=focus.deficit>=30
	{'Arcane Torrent', 'focus.deficit>=30'},

 	--actions.+=/blood_fury
	{'Blood Fury'},

 	--actions.+=/berserking
	{'Berserking'},

 	--actions.+=/call_action_list,name=cooldowns
	{Cooldowns},

 	--actions.+=/a_murder_of_crows
	{'A Murder of Crows', 'talent(6,1)'},

 	--actions.+=/barrage
	{Barrage, 'toggle(xBarrage)'},

 	--actions.+=/piercing_shot,if=!talent.patient_sniper.enabled&focus>50
	{'Piercing Shot', '!talent(4,3)&focus>50'},

 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&(debuff.vulnerability.down||debuff.vulnerability.remains<cast_time)
	{'Windburst', 'area(40).enemies<2&!buff(Marking Targets)&{!target.debuff(Vulnerable)||target.debuff(Vulnerable).remains<spell(Windburst).casttime}'},

 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&focus+cast_regen>90
	{'Windburst', 'area(40).enemies<2&!buff(Marking Targets)&focus+cast_regen>90'},

 	--actions.+=/windburst,if=active_enemies<2&cooldown.sidewinders.charges=0
	{'Windburst', 'area(40).enemies<2&spell(Sidewinders).charges<1'},

 	--actions.+=/arcane_shot,if=!talent.patient_sniper.enabled&active_enemies=1&debuff.vulnerability.react<3&buff.marking_targets.react&debuff.hunters_mark.down
	{'Arcane Shot', '!talent(4,3)&area(40).enemies<2&target.debuff(Vulnerable).stack<3&buff(Marking Targets)&!target.debuff(Hunter\'s Mark)'},

 	--actions.+=/marked_shot,if=!talent.patient_sniper.enabled&debuff.vulnerability.react<3
	{'Marked Shot', '!talent(4,3)&target.debuff(Hunter\'s Mark)&target.debuff(Vulnerable).stack<3'},

 	--actions.+=/marked_shot,if=prev_off_gcd.sentinel
	{'Marked Shot', 'target.debuff(Hunter\'s Mark)'},

 	--actions.+=/sentinel,if=debuff.hunters_mark.down&buff.marking_targets.down
	{'Sentinel', '!target.debuff(Hunter\'s Mark)&!buff(Marking Targets)'},

 	--actions.+=/explosive_shot
	{'Explosive Shot', 'talent(4,1)'},

 	--actions.+=/marked_shot,if=active_enemies>=4&cooldown.sidewinders.charges_fractional>=0.8
	{'Marked Shot', 'area(40).enemies>=4&spell(Sidewinders).charges>=0.8'},

 	--actions.+=/sidewinders,if=active_enemies>1&debuff.hunters_mark.down&(buff.marking_targets.react||buff.trueshot.react||charges=2)
	{'Sidewinders', 'area(40).enemies>1&!target.debuff(Hunter\'s Mark)&{buff(Marking Targets)||buff(Trueshot)||spell(Sidewinders).charges=2}'},

 	--actions.+=/arcane_shot,if=talent.steady_focus.enabled&active_enemies=1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Arcane Shot', '!talent(7,1)&talent(1,2)&area(40).enemies<2&{!buff(Steady Focus)||buff(Steady Focus).remains<2}'},

 	--actions.+=/multishot,if=talent.steady_focus.enabled&active_enemies>1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Multi-Shot', 'talent(1,2)&area(40).enemies>1&{!buff(Steady Focus)||buff(Steady Focus).remains<2}'},

 	--actions.+=/arcane_shot,if=talent.true_aim.enabled&active_enemies=1&(debuff.true_aim.react<1||debuff.true_aim.remains<2)
	{'Arcane Shot', '!talent(7,1)&talent(2,3)&area(40).enemies<2&{target.debuff(True Aim).stack<1||target.debuff(True Aim).remains<2}'},

 	--actions.+=/aimed_shot,if=buff.lock_and_load.up&debuff.vulnerability.remains>gcd.max
	{'Aimed Shot', 'buff(Lock and Load)&target.debuff(Vulnerable).remains>gcd'},

 	--actions.+=/piercing_shot,if=talent.patient_sniper.enabled&focus>80
	{'Piercing Shot', 'talent(4,3)&focus>80'},

 	--actions.+=/marked_shot,if=!talent.sidewinders.enabled&(debuff.vulnerability.remains<2||buff.marking_targets.react)
	{'Marked Shot', '!talent(7,1)&{target.debuff(Vulnerable).remains<2||buff(Marking Targets)}'},

 	--actions.+=/pool_resource,for_next=1,if=talent.sidewinders.enabled&(focus<60&cooldown.sidewinders.charges_fractional<=1.2)
	--TODO: figure out how to pause rotation until have enough resources to cast THIS SKILL(=simc pool_resource)
	{'Sidewinders', 'talent(7,1)&{focus<60&spell(Sidewinders).charges<=1.2}'},

 	--actions.+=/aimed_shot,if=cast_time<debuff.vulnerability.remains&(focus+cast_regen>80||debuff.hunters_mark.down)
	{'Aimed Shot', 'spell(Aimed Shot).casttime<target.debuff(Vulnerable).remains&{focus+cast_regen>80||!target.debuff(Hunter\'s Mark)}'},

 	--actions.+=/marked_shot
	{'Marked Shot', 'target.debuff(Hunter\'s Mark)'},

 	--actions.+=/black_arrow
	{'Black Arrow', 'talent(2,2)'},

	--actions.+=/sidewinders,if=debuff.hunters_mark.down&(buff.marking_targets.remains>6||buff.trueshot.react||charges=2)
	{'Sidewinders', '!target.debuff(Hunter\'s Mark)&{buff(Marking Targets).remains>6||buff(Trueshot)||spell(Sidewinders).charges=2}'},

 	--actions.+=/sidewinders,if=focus<30&charges<=1&recharge_time<=5
	{'Sidewinders', 'focus<30&spell(Sidewinders).charges<=1&spell(Sidewinders).recharge<=5'},

 	--actions.+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Multi-Shot', 'area(40).enemies>1&{!target.debuff(Hunter\'s Mark)&buff(Marking Targets)||focus.timetomax>=2}'},

 	--actions.+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Arcane Shot', '!talent(7,1)&area(40).enemies<2&{!target.debuff(Hunter\'s Mark)&buff(Marking Targets)||focus.timetomax>=2}'},

 	--actions.+=/arcane_shot,if=focus.deficit<10
	{'Arcane Shot', '!talent(7,1)&focus.deficit<10'},

	--test
	--{'Aimed Shot'}

}

local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},

}

local inCombat = {

	--{Keybinds},
	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, {'target.range < 40', 'target.infront'}}

}

local outCombat = {

	{Keybinds},

}

NeP.Engine.registerRotation(254, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] HUNTER - Marksmanship', inCombat, outCombat, exeOnLoad, GUI)
