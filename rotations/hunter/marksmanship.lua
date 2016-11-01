local _, Xeer = ...

local exeOnLoad = function()

	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHUNTER |cffADFF2FMarksmanship |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/X - 4/3 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

		NeP.Interface:AddToggle({
			key = 'xBarrage',
			name = 'Barrage',
			text = 'ON/OFF using Barrage in rotation if you have talent',
			icon = 'Interface\\Icons\\Ability_Hunter_RapidRegeneration',
		})
end

local _Xeer = {
-- some non-SiMC stuffs
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
  --# Executed before combat begins. Accepts non-harmfulactions only.
 	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--{'', ''},
 	--actions.precombat+=/food,type=fishbrul_special
	--{'', ''},
 	--actions.precombat+=/summon_pet
	--{'', ''},
 	--actions.precombat+=/snapshot_stats
	--{'', ''},
 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},
 	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
 	--actions.precombat+=/windburst
	--{'', ''},
}

local Survival = {

}

local Interrupts = {
	{'Counter Shot'},
}

local Cooldowns = {
 	--actions.cooldowns=potion,name=deadly_grace,if=(buff.trueshot.react&buff.bloodlust.react)|buff.bullseye.stack>=23|target.time_to_die<31
	--{'', ''},
 	--actions.cooldowns+=/trueshot,if=buff.bloodlust.react|target.time_to_die>=(cooldown+30)|buff.bullseye.stack>25|target.time_to_die<16
	{'Trueshot', 'player.buff(Bloodlust)||target.time_to_die>=(cooldown(Trueshot).remains+30)||player.buff(Bullseye).stack>25||target.time_to_die<16'},
}

local Barrage = {
--actions.+=/barrage
	{'Barrage', 'talent(6,2)'},
}

local SW = {
	{'Sidewinders'},
}

local xCombat = {
	--# Executed every time the actor is available.
 	--actions.+=/arcane_torrent,if=focus.deficit>=30
	--{'Arcane Torrent', 'focus.deficit>=30'},
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
 	--actions.+=/piercing_shot,if=!talent.patient_sniper.enabled&player.focus>50
	{'Piercing Shot', '!talent(4,3)&player.focus>50'},
 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&(debuff.vulnerable.down||debuff.vulnerable.remains<cast_time)
	{'Windburst', 'player.area(40).enemies<2&!player.buff(Marking Targets)&{!target.debuff(Vulnerable)||target.debuff(Vulnerable).remains<action(Windburst).cast_time}'},
 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&player.focus+player.cast_regen>90
	{'Windburst', 'player.area(40).enemies<2&!player.buff(Marking Targets)&player.focus+player.cast_regen>90'},
 	--actions.+=/windburst,if=active_enemies<2&cooldown.sidewinders.charges=0
	{'Windburst', 'player.area(40).enemies<2&cooldown(Sidewinders).charges<1'},
 	--actions.+=/arcane_shot,if=!talent.patient_sniper.enabled&active_enemies=1&debuff.vulnerable.stack<3&buff.marking_targets.react&debuff.hunters_mark.down
	{'Arcane Shot', '!talent(4,3)&{player.area(40).enemies<2&target.debuff(Vulnerable).stack<3&player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)}'},
 	--actions.+=/marked_shot,if=!talent.patient_sniper.enabled&debuff.vulnerable.stack<3
	{'Marked Shot', '!talent(4,3)&{target.debuff(Hunter\'s Mark)&target.debuff(Vulnerable).stack<3}'},
 	--actions.+=/marked_shot,if=prev_off_gcd.sentinel
	{'Marked Shot', 'target.debuff(Hunter\'s Mark)'},
 	--actions.+=/sentinel,if=debuff.hunters_mark.down&buff.marking_targets.down
	{'Sentinel', '!target.debuff(Hunter\'s Mark)&!player.buff(Marking Targets)'},
 	--actions.+=/explosive_shot
	{'Explosive Shot', 'talent(4,1)'},
 	--actions.+=/marked_shot,if=active_enemies>=4&cooldown.sidewinders.charges_fractional>=0.8
	{'Marked Shot', 'player.area(40).enemies>=4&cooldown(Sidewinders).charges>=0.8'},
 	--actions.+=/sidewinders,if=active_enemies>1&debuff.hunters_mark.down&(buff.marking_targets.react||buff.trueshot.react||charges=2)
	{'Sidewinders', 'player.area(40).enemies>1&!target.debuff(Hunter\'s Mark)&{player.buff(Marking Targets)||player.buff(Trueshot)||cooldown(Sidewinders).charges=2}'},
 	--actions.+=/arcane_shot,if=talent.steady_focus.enabled&active_enemies=1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Arcane Shot', 'talent(1,2)&player.area(40).enemies<2&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}'},
 	--actions.+=/multishot,if=talent.steady_focus.enabled&active_enemies>1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Multi-Shot', 'talent(1,2)&player.area(40).enemies>1&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}'},
 	--actions.+=/arcane_shot,if=talent.true_aim.enabled&active_enemies=1&(debuff.true_aim.stack<1||debuff.true_aim.remains<2)
	{'Arcane Shot', 'talent(2,3)&player.area(40).enemies<2&{target.debuff(True Aim).stack<1||target.debuff(True Aim).remains<2}'},
 	--actions.+=/aimed_shot,if=buff.lock_and_load.up&debuff.vulnerable.remains>gcd.max
	{'Aimed Shot', 'player.buff(Lock and Load)&target.debuff(Vulnerable).remains>gcd'},
 	--actions.+=/piercing_shot,if=talent.patient_sniper.enabled&player.focus>80
	{'Piercing Shot', 'talent(4,3)&player.focus>80'},
 	--actions.+=/marked_shot,if=!talent.sidewinders.enabled&(debuff.vulnerable.remains<2||buff.marking_targets.react)
	{'Marked Shot', '!talent(7,1)&{target.debuff(Vulnerable).remains<2||player.buff(Marking Targets)}'},
 	--actions.+=/pool_resource,for_next=1,if=talent.sidewinders.enabled&(player.focus<60&cooldown.sidewinders.charges_fractional<=1.2)
	{SW, 'talent(7,1)&{player.focus<60&cooldown(Sidewinders).charges<=1.2}'},
 	--actions.+=/aimed_shot,if=cast_time<debuff.vulnerable.remains&(player.focus+player.cast_regen>80||debuff.hunters_mark.down)
	{'Aimed Shot', 'cooldown(Aimed Shot).casttime<target.debuff(Vulnerable).remains&{player.focus+player.cast_regen>80||!target.debuff(Hunter\'s Mark)}'},
 	--actions.+=/marked_shot
	{'Marked Shot', 'target.debuff(Hunter\'s Mark)'},
 	--actions.+=/black_arrow
	{'Black Arrow', 'talent(2,2)'},
	--actions.+=/sidewinders,if=debuff.hunters_mark.down&(buff.marking_targets.remains>6||buff.trueshot.react||charges=2)
	{'Sidewinders', '!target.debuff(Hunter\'s Mark)&{player.buff(Marking Targets).remains>6||player.buff(Trueshot)||cooldown(Sidewinders).charges=2}'},
 	--actions.+=/sidewinders,if=player.focus<30&charges<=1&recharge_time<=5
	{'Sidewinders', 'player.focus<30&cooldown(Sidewinders).charges<=1&cooldown(Sidewinders).recharge<=5'},
 	--actions.+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Multi-Shot', 'player.area(40).enemies>1&{!target.debuff(Hunter\'s Mark)&player.buff(Marking Targets)||focus.time_to_max>=2}'},
 	--actions.+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Arcane Shot', 'player.area(40).enemies<2&{!target.debuff(Hunter\'s Mark)&player.buff(Marking Targets)||focus.time_to_max>=2}'},
 	--actions.+=/arcane_shot,if=focus.deficit<10
	{'Arcane Shot', 'focus.deficit<10'}
}

local Opener = {
 	--actions.open=a_murder_of_crows
	{'A Murder of Crows', 'talent(6,1)'},
 	--actions.open+=/trueshot
	{'Trueshot'},
 	--actions.open+=/sidewinders,if=(buff.marking_targets.down&buff.trueshot.remains<2)|(charges_fractional>=1.9&focus<80)
	{'', ''},
 	--actions.open+=/marked_shot
	{'', ''},
 	--actions.open+=/aimed_shot,if=buff.lock_and_load.up&execute_time<debuff.vulnerable.remains
	{'', ''},
 	--actions.open+=/black_arrow
	{'', ''},
 	--actions.open+=/barrage
	{'', ''},
 	--actions.open+=/aimed_shot,if=execute_time<debuff.vulnerable.remains
	{'', ''},
 	--actions.open+=/sidewinders
	{'', ''},
 	--actions.open+=/aimed_shot
	{'', ''},
 	--actions.open+=/arcane_shot
	{'', ''},
}

local TargetDie = {
 	--actions.targetdie=marked_shot
	{'Marked Shot'},
 	--actions.targetdie+=/windburst
	{'Windburst'},
 	--actions.targetdie+=/aimed_shot,if=execute_time<debuff.vulnerable.remains
	{'Aimed Shot', 'action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
 	--actions.targetdie+=/sidewinders
	{'Sidewinders'},
 	--actions.targetdie+=/aimed_shot
	{'Aimed Shot'},
 	--actions.targetdie+=/arcane_shot
	{'Arcane Shot'},
}

local TrueshotAoE = {
 	--actions.trueshotaoe=marked_shot
	{'Marked Shot'},
 	--actions.trueshotaoe+=/piercing_shot
	{'Piercing Shot'},
 	--actions.trueshotaoe+=/barrage
	{'Barrage'},
 	--actions.trueshotaoe+=/explosive_shot
	{'Explosive Shot'},
 	--actions.trueshotaoe+=/aimed_shot,if=active_enemies=2&buff.lock_and_load.up&execute_time<debuff.vulnerable.remains
	{'Aimed Shot', 'player.area(40).enemies=2&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
 	--actions.trueshotaoe+=/multishot
  {'Multi-Shot'},
}

 local xCombat = {
  --# Executed every time the actor is available.
 	--actions+=/blood_fury
	{'Blood Fury'},
 	--actions+=/berserking
	{'Berserking'},
 	--actions+=/call_action_list,name=open,if=time<=15&talent.sidewinders.enabled&active_enemies=1
	{Opener, 'talent(7,1)&{xtime<=15&player.area(40).enemies=1}'},
 	--actions+=/call_action_list,name=cooldowns
	{Cooldowns, 'toggle(cooldowns)'},
 	--actions+=/a_murder_of_crows,if=debuff.hunters_mark.down
	{'', ''},
 	--actions+=/call_action_list,name=trueshotaoe,if=active_enemies>1&!talent.sidewinders.enabled&buff.trueshot.up
	{TrueshotAoE, 'talent(7,1)&{player.area(40).enemies>1}'},
 	--actions+=/barrage,if=debuff.hunters_mark.down
	{'', ''},
 	--actions+=/black_arrow,if=debuff.hunters_mark.down
	{'', ''},
 	--actions+=/a_murder_of_crows,if=(target.health.pct>30|target.health.pct<=20)&debuff.vulnerable.remains>execute_time&debuff.hunters_mark.remains>execute_time&focus+(focus.regen*debuff.vulnerable.remains)>60&focus+(focus.regen*debuff.hunters_mark.remains)>=60
	{'', ''},
 	--actions+=/barrage,if=debuff.vulnerable.remains>execute_time&debuff.hunters_mark.remains>execute_time&focus+(focus.regen*debuff.vulnerable.remains)>90&focus+(focus.regen*debuff.hunters_mark.remains)>=90
	{'', ''},
 	--actions+=/black_arrow,if=debuff.vulnerable.remains>execute_time&debuff.hunters_mark.remains>execute_time&focus+(focus.regen*debuff.vulnerable.remains)>70&focus+(focus.regen*debuff.hunters_mark.remains)>=70
	{'', ''},
 	--actions+=/piercing_shot,if=!talent.patient_sniper.enabled&focus>50
	{'', ''},
 	--actions+=/windburst,if=(!talent.patient_sniper.enabled|talent.sidewinders.enabled)&(debuff.hunters_mark.down|debuff.hunters_mark.remains>execute_time&focus+(focus.regen*debuff.hunters_mark.remains)>50)
	{'', ''},
 	--actions+=/windburst,if=talent.patient_sniper.enabled&!talent.sidewinders.enabled&((debuff.vulnerable.down|debuff.vulnerable.remains<2)|(debuff.hunters_mark.up&buff.marking_targets.up&debuff.vulnerable.down))
	{'', ''},
 	--actions+=/call_action_list,name=targetdie,if=target.time_to_die<6&active_enemies=1
	{TargetDie, 'target.time_to_die<6&player.area(40).enemies=1'},
 	--actions+=/sidewinders,if=(debuff.hunters_mark.down|(buff.marking_targets.down&buff.trueshot.down))&((buff.trueshot.react&focus<80)|charges_fractional>=1.9)
	{'', ''},
 	--actions+=/sentinel,if=debuff.hunters_mark.down&(buff.marking_targets.down|buff.trueshot.up)
	{'', ''},
 	--actions+=/marked_shot,target=2,if=!talent.patient_sniper.enabled&debuff.vulnerable.stack<3
	{'', ''},
 	--actions+=/arcane_shot,if=!talent.patient_sniper.enabled&spell_targets.barrage=1&debuff.vulnerable.stack<3&((buff.marking_targets.up&debuff.hunters_mark.down)|buff.trueshot.up)
	{'', ''},
 	--actions+=/multishot,if=!talent.patient_sniper.enabled&spell_targets.barrage>1&debuff.vulnerable.stack<3&((buff.marking_targets.up&debuff.hunters_mark.down)|buff.trueshot.up)
	{'', ''},
 	--actions+=/arcane_shot,if=talent.steady_focus.enabled&spell_targets.barrage=1&(buff.steady_focus.down|buff.steady_focus.remains<2)
	{'', ''},
 	--actions+=/multishot,if=talent.steady_focus.enabled&spell_targets.barrage>1&(buff.steady_focus.down|buff.steady_focus.remains<2)
	{'', ''},
 	--actions+=/explosive_shot
	{'', ''},
 	--actions+=/marked_shot,if=!talent.patient_sniper.enabled|(talent.barrage.enabled&spell_targets.barrage>2)
	{'', ''},
 	--actions+=/aimed_shot,if=debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&(buff.lock_and_load.up|(focus+debuff.hunters_mark.remains*focus.regen>=80&focus+focus.regen*debuff.vulnerable.remains>=80))
	{'', ''},
 	--actions+=/aimed_shot,if=debuff.hunters_mark.down&debuff.vulnerable.remains>execute_time&(talent.sidewinders.enabled|buff.marking_targets.down|(debuff.hunters_mark.remains>execute_time+gcd&focus+5+focus.regen*debuff.hunters_mark.remains>80))
	{'', ''},
 	--actions+=/marked_shot,if=debuff.hunters_mark.remains<1|debuff.vulnerable.remains<1|spell_targets.barrage>1|buff.trueshot.up
	{'', ''},
 	--actions+=/marked_shot,if=buff.marking_targets.up&(!talent.sidewinders.enabled|cooldown.sidewinders.charges_fractional>=1.2)
	{'', ''},
 	--actions+=/sidewinders,if=buff.marking_targets.up&debuff.hunters_mark.down&(focus<=80|(debuff.vulnerable.remains<2&cooldown.windburst.remains>3&cooldown.sidewinders.charges_fractional>=1.2))
	{'', ''},
 	--actions+=/piercing_shot,if=talent.patient_sniper.enabled&focus>80
	{'', ''},
 	--actions+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
	{'', ''},
 	--actions+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react|focus.time_to_max>=2)
	{'', ''},
 	--actions+=/aimed_shot,if=debuff.vulnerable.down&focus>80&cooldown.windburst.remains>3
	{'', ''},
 	--actions+=/multishot,if=spell_targets.barrage>2
	{'', ''},
}



local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	--{Keybinds},	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	--{xCombat, {'target.range < 40', 'target.infront', '!channeling(Barrage)'}}
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=30'},
	{xCombat, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	--{PreCombat}
}

NeP.CR:Add(254, '[|cff'..Xeer.addonColor..'Xeer|r] HUNTER - Marksmanship', inCombat, outCombat, exeOnLoad)
