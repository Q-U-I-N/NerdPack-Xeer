local _, Xeer = ...

local GUI = {

}

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
 	--actions.precombat+=/food,type=nightborne_delicacy_platter
	--{'', ''},
 	--actions.precombat+=/summon_pet
	--{'', ''},
	--actions.precombat+=/potion,name=prolonged_power,if=active_enemies>2
 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},
 	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
	--actions.precombat+=/volley,if=talent.volley.enabled
 	--actions.precombat+=/windburst
	--{'', ''},
}

local Cooldowns = {
 	--actions.cooldowns=potion,name=prolonged_power,if=spell_targets.multishot>2&{{buff.trueshot.up&buff.bloodlust.up}||buff.bullseye.stack>=23||target.time_to_die<62}
		--{'', ''},
 	--actions.cooldowns+=/potion,name=deadly_grace,if={buff.trueshot.up&buff.bloodlust.up}||buff.bullseye.stack>=23||target.time_to_die<31
		--{'', ''},
 	--actions.cooldowns+=/trueshot,if=time<5||buff.bloodlust.up||target.time_to_die>={cooldown+duration}||buff.bullseye.stack>25||target.time_to_die<16
		{'Trueshot', 'xtime<5||player.buff(Bloodlust)||target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||player.buff(Bullseye).stack>25||target.time_to_die<16'},
}

local TargetDie = {
 	--actions.TargetDie=marked_shot
	{'Marked Shot'},
 	--actions.TargetDie+=/windburst
	{'Windburst'},
 	--actions.TargetDie+=/aimed_shot,if=debuff.vulnerable.remains>execute_time&target.time_to_die>execute_time
	{'Aimed Shot', 'target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&target.time_to_die>action(Aimed Shot).execute_time'},
 	--actions.TargetDie+=/sidewinders
	{'Sidewinders'},
 	--actions.TargetDie+=/aimed_shot
	{'Aimed Shot'},
 	--actions.TargetDie+=/arcane_shot
	{'Arcane Shot'},
}

local TrueshotAoE = {
 	--actions.TrueshotAoE=marked_shot
	{'Marked Shot'},
	--actions.TrueshotAoE+=/barrage,if=!talent.patient_sniper.enabled
	{'Barrage', '!talent(4,3)&toggle(xBarrage)'},
 	--actions.TrueshotAoE+=/piercing_shot
	{'Piercing Shot'},
 	--actions.TrueshotAoE+=/explosive_shot
	{'Explosive Shot'},
 	--actions.TrueshotAoE+=/aimed_shot,if={!talent.patient_sniper.enabled|talent.trick_shot.enabled}&spell_targets.multishot=2&buff.lock_and_load.up&execute_time<debuff.vulnerable.remains
	{'Aimed Shot', '{!talent(4,3)||talent(7,3)}&target.area(8).enemies=1&player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
 	--actions.TrueshotAoE+=/multishot
  {'Multi-Shot'},
}

local Non_Patient_Sniper = {
 	--actions.Non_Patient_Sniper=windburst
	{'Windburst'},
 	--actions.Non_Patient_Sniper+=/piercing_shot,if=focus>=100
	{'Piercing Shot', 'player.focus>=100'},
 	--actions.Non_Patient_Sniper+=/sentinel,if=debuff.hunters_mark.down&focus>30&buff.trueshot.down
	{'Sentinel', '!target.debuff(Hunter\'s Mark)&player.focus>30&!player.buff(Trueshot)'},
 	--actions.Non_Patient_Sniper+=/sidewinders,if=debuff.vulnerable.remains<gcd&time>6
	{'Sidewinders', 'target.debuff(Vulnerable).remains<gcd&xtime>6'},
 	--actions.Non_Patient_Sniper+=/aimed_shot,if=buff.lock_and_load.up&spell_targets.barrage<3
	{'Aimed Shot', 'player.buff(Lock and Load)&player.area(40).enemies.infront<3'},
 	--actions.Non_Patient_Sniper+=/marked_shot
	{'Marked Shot'},
 	--actions.Non_Patient_Sniper+=/explosive_shot
	{'Explosive Shot'},
 	--actions.Non_Patient_Sniper+=/sidewinders,if={{buff.marking_targets.up||buff.trueshot.up}&focus.deficit>70}||charges_fractional>=1.9
	{'Sidewinders', '{{player.buff(Marking Targets)||player.buff(Trueshot)}&focus.deficit>70}||action(Sidewinders).charges>=1.9'},
 	--actions.Non_Patient_Sniper+=/arcane_shot,if=!variable.use_multishot&{buff.marking_targets.up||{talent.steady_focus.enabled&{buff.steady_focus.down||buff.steady_focus.remains<2}}}
	{'Arcane Shot', '!variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
 	--actions.Non_Patient_Sniper+=/multishot,if=variable.use_multishot&{buff.marking_targets.up||{talent.steady_focus.enabled&{buff.steady_focus.down||buff.steady_focus.remains<2}}}
	{'Multi-Shot', 'variable.use_multishot&{player.buff(Marking Targets)||{talent(1,2)&{!player.buff(Steady Focus)||player.buff(Steady Focus).remains<2}}}'},
 	--actions.Non_Patient_Sniper+=/aimed_shot,if=!talent.piercing_shot.enabled||cooldown.piercing_shot.remains>3
	{'Aimed Shot', '!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>3}'},
 	--actions.Non_Patient_Sniper+=/arcane_shot,if=!variable.use_multishot
	{'Arcane Shot', '!variable.use_multishot'},
 	--actions.Non_Patient_Sniper+=/multishot,if=variable.use_multishot
	{'Multi-Shot', 'variable.use_multishot'},
}

local Opener = {
 	--actions.Opener=a_murder_of_crows
		{'A Murder of Crows'},
 	--actions.Opener+=/trueshot
		{'True Shot'},
 	--actions.Opener+=/piercing_shot
		{'Piercing Shot'},
 	--actions.Opener+=/explosive_shot
		{'Explosive Shot'},
 	--actions.Opener+=/barrage,if=!talent.patient_sniper.enabled
		{'Barrage', '!talent(4,3)&toggle(xBarrage)'},
 	--actions.Opener+=/arcane_shot,line_cd=16&!talent.patient_sniper.enabled
		{'Arcane Shot', 'line_cd(Arcane Shot)>16&!talent(4,3)'},
 	--actions.Opener+=/sidewinders,if={buff.marking_targets.down&buff.trueshot.remains<2}||{charges_fractional>=1.9&focus<80}
		{'Sidewinders', '{!player.buff(Marking Targets)&player.buff(Trueshot).remains<2}||{Action(Sidewinders).charges>=1.9&player.focus<80}'},
 	--actions.Opener+=/marked_shot
		{'Marked Shot'},
 	--actions.Opener+=/barrage,if=buff.bloodlust.up
		{'Barrage', 'player.buff(Bloodlust)&toggle(xBarrage)'},
 	--actions.Opener+=/aimed_shot,if={buff.lock_and_load.up&execute_time<debuff.vulnerable.remains}||focus>90&!talent.patient_sniper.enabled&talent.trick_shot.enabled
		{'Aimed Shot', '{player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains}||player.focus>90&!talent(4,3)&talent(7,3)'},
 	--actions.Opener+=/aimed_shot,if=buff.lock_and_load.up&execute_time<debuff.vulnerable.remains
		{'Aimed Shot', 'player.buff(Lock and Load)&action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
 	--actions.Opener+=/black_arrow
		{'Black Arrow'},
 	--actions.Opener+=/barrage
		{'Barrage', 'toggle(xBarrage)'},
 	--actions.Opener+=/arcane_shot
		{'Arcane Shot'},
 	--actions.Opener+=/aimed_shot,if=execute_time<debuff.vulnerable.remains
		{'Aimed Shot', 'action(Aimed Shot).execute_time<target.debuff(Vulnerable).remains'},
 	--actions.Opener+=/sidewinders
		{'Sidewinders'},
 	--actions.Opener+=/aimed_shot
		{'Aimed Shot'},
}

local Patient_Sniper = {
 	--actions.Patient_Sniper=marked_shot,cycle_targets=1,if={talent.sidewinders.enabled&talent.barrage.enabled&spell_targets>2}||debuff.hunters_mark.remains<2||{{debuff.vulnerable.up||talent.sidewinders.enabled}&debuff.vulnerable.remains<gcd}
		{'Marked Shot', '{talent(7,1)&talent(6,2)&player.area(40).enemies.infront>2}||target.debuff(Hunter\'s Mark).remains<2||{{target.debuff(Vulnerable)||talent(7,1)}&target.debuff(Vulnerable).remains<gcd)}'},
 	--actions.Patient_Sniper+=/windburst,if=talent.sidewinders.enabled&{debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&focus+{focus.regen*debuff.hunters_mark.remains}>=50}}||buff.trueshot.up
		{'Windburst', 'talent(7,1)&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=50}}||player.buff(Trueshot)'},
 	--actions.Patient_Sniper+=/sidewinders,if=buff.trueshot.up&{{buff.marking_targets.down&buff.trueshot.remains<2}||{charges_fractional>=1.9&{focus.deficit>70||spell_targets>1}}}
		{'Sidewinders', 'player.buff(Trueshot)&{{!player.buff(Marking Targets&player.buff(Trueshot).remains<2)}||{action(Sidewinders).charges>=1.9&{focus.deficit>70||player.area(40).enemies.infront>1}}}'},
 	--actions.Patient_Sniper+=/multishot,if=buff.marking_targets.up&debuff.hunters_mark.down&variable.use_multishot&focus.deficit>2*spell_targets+gcd*focus.regen
		{'Multi-Shot', 'player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
 	--actions.Patient_Sniper+=/aimed_shot,if=buff.lock_and_load.up&buff.trueshot.up&debuff.vulnerable.remains>execute_time
		{'Aimed Shot', 'player.buff(Lock and Load)&player.buff(Trueshot)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
 	--actions.Patient_Sniper+=/marked_shot,if=buff.trueshot.up&!talent.sidewinders.enabled
		{'Marked Shot', 'player.buff(Trueshot)&!talent(7,1)'},
 	--actions.Patient_Sniper+=/arcane_shot,if=buff.trueshot.up
		{'Arcane Shot', 'player.buff(Trueshot)'},
 	--actions.Patient_Sniper+=/aimed_shot,if=debuff.hunters_mark.down&debuff.vulnerable.remains>execute_time
		{'Aimed Shot', '!target.debuff(Hunter\'s Mark)&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time'},
 	--actions.Patient_Sniper+=/aimed_shot,if=talent.sidewinders.enabled&debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&{buff.lock_and_load.up||{focus+debuff.hunters_mark.remains*focus.regen>=80&focus+focus.regen*debuff.vulnerable.remains>=80}}&{!talent.piercing_shot.enabled||cooldown.piercing_shot.remains>5||focus>120}
		{'Aimed Shot', 'talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>=80&player.focus+focus.regen*target.debuff(Vulnerable).remains>=80}}&{!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>5}||player.focus>120}'},
 	--actions.Patient_Sniper+=/aimed_shot,if=!talent.sidewinders.enabled&debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&{buff.lock_and_load.up||{buff.trueshot.up&focus>=80}||{buff.trueshot.down&focus+debuff.hunters_mark.remains*focus.regen>=80&focus+focus.regen*debuff.vulnerable.remains>=80}}&{!talent.piercing_shot.enabled||cooldown.piercing_shot.remains>5||focus>120}
		{'Aimed Shot', '!talent(7,1)&target.debuff(Hunter\'s Mark).remains>action(Aimed Shot).execute_time&target.debuff(Vulnerable).remains>action(Aimed Shot).execute_time&{player.buff(Lock and Load)||{player.buff(Trueshot)&player.focus>=80}||{!player.buff(Trueshot)&player.focus+target.debuff(Hunter\'s Mark).remains*focus.regen>=80&player.focus+focus.regen*target.debuff(Vulnerable).remains>=80}}&{!talent(7,2)||{talent(7,2)&cooldown(Piercing Shot).remains>5}||player.focus>120}'},
 	--actions.Patient_Sniper+=/windburst,if=!talent.sidewinders.enabled&focus>80&{debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&focus+{focus.regen*debuff.hunters_mark.remains}>=50}}
		{'Windburst', '!talent(7,1)&player.focus>80{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Windburst).execute_time&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=50}}'},
 	--actions.Patient_Sniper+=/marked_shot,if={talent.sidewinders.enabled&spell_targets>1}||focus.deficit<50||buff.trueshot.up||{buff.marking_targets.up&{!talent.sidewinders.enabled||cooldown.sidewinders.charges_fractional>=1.2}}
		{'Marked Shot', '{talent(7,1)&player.area(40).enemies.infront>1}||focus.deficit<50||player.buff(Trueshot)||{player.buff(Marking Targets)&{!talent(7,1)||cooldown(Sidewinders).charges>=1.2}}'},
 	--actions.Patient_Sniper+=/piercing_shot,if=focus>80
		{'Piercing Sho', 'player.focus>80'},
 	--actions.Patient_Sniper+=/sidewinders,if=variable.safe_to_build&{{buff.trueshot.up&focus.deficit>70}||charges_fractional>=1.9}
		{'Sidewinders', 'variable.safe_to_build&{{player.buff(Trueshot)&focus.deficit>70}||action(Sidewinders).charges>=1.9}'},
 	--actions.Patient_Sniper+=/sidewinders,if={buff.marking_targets.up&debuff.hunters_mark.down&buff.trueshot.down}||{cooldown.sidewinders.charges_fractional>1&target.time_to_die<11}
		{'Sidewinders', '{player.buff(Marking Targets)&!target.debuff(Hunter\'s Mark)&!player.buff(Trueshot)}||{cooldown(Sidewinders).charges>1&target.time_to_die<11}'},
 	--actions.Patient_Sniper+=/arcane_shot,if=variable.safe_to_build&!variable.use_multishot&focus.deficit>5+gcd*focus.regen
		{'Arcane Shot', 'variable.safe_to_build&!variable.use_multishot&focus.deficit>5+gcd*focus.regen'},
 	--actions.Patient_Sniper+=/multishot,if=variable.safe_to_build&variable.use_multishot&focus.deficit>2*spell_targets+gcd*focus.regen
		{'Multi-Shot', 'variable.safe_to_build&variable.use_multishot&focus.deficit>2*target.area(8).enemies+gcd*focus.regen'},
 	--actions.Patient_Sniper+=/aimed_shot,if=debuff.vulnerable.down&focus>80&cooldown.windburst.remains>focus.time_to_max
		{'Aimed Shot', '!target.debuff(Vulnerable)&focus>80&cooldown(Windburst).remains>focus.time_to_max'},
}

 local xCombat = {
 	--actions+=/arcane_torrent,if=focus.deficit>=30&{!talent.sidewinders.enabled||cooldown.sidewinders.charges<2}
	 	{'Arcane Torrent', 'focus.deficit>=30&{!talent(7,1)||cooldown(Sidewinders).charges<2}'},
 	--actions+=/blood_fury
	 	{'Blood Fury'},
 	--actions+=/berserking
	 	{'Berserking'},
 	--actions+=/call_action_list,name=open,if=active_enemies=1&time<=15
	 	{Opener, 'player.area(40).enemies=1&xtime<=15'},
 	--actions+=/a_murder_of_crows,if={target.time_to_die>=cooldown+duration||target.health.pct<20}&{debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&focus+{focus.regen*debuff.vulnerable.remains}>=60&focus+{focus.regen*debuff.hunters_mark.remains}>=60}}
	 	{'A Murder of Crows', '{target.time_to_die>=75||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=60&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=60}}'},
 	--actions+=/call_action_list,name=cooldowns
	 	{Cooldowns, 'toggle(cooldowns)'},
 	--actions+=/call_action_list,name=TrueshotAoE,if={target.time_to_die>=cooldown+duration||target.health.pct<20}&{debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&focus+{focus.regen*debuff.vulnerable.remains}>=60&focus+{focus.regen*debuff.hunters_mark.remains}>=60}}
	 	{TrueshotAoE, '{target.time_to_die>={180-artifact(Quick Shot).rank*10+15}||target.health<20&target.boss}&{!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(A Murder of Crows).execute_time&target.debuff(Vulnerable).remains>target.action(A Murder of Crows).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=60&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=60}}'},
 	--actions+=/black_arrow,if=debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&focus+{focus.regen*debuff.vulnerable.remains}>=70&focus+{focus.regen*debuff.hunters_mark.remains}>=70}
	 	{'Black Arrow', '!target.debuff(Hunter\'s Mark)||{target.debuff(Hunter\'s Mark).remains>action(Black Arrow).execute_time&target.debuff(Vulnerable).remains>target.action(Black Arrow).execute_time&focus+{focus.regen*target.debuff(Vulnerable).remains}>=70&focus+{focus.regen*target.debuff(Hunter\'s Mark).remains}>=70}}'},
 	--actions+=/barrage,if={target.time_to_20pct>10||target.health.pct<=20||spell_targets>1}&{{buff.trueshot.down||{target.health.pct<=20&buff.bullseye.stack<29}||spell_targets>1}&debuff.hunters_mark.down||{debuff.hunters_mark.remains>execute_time&debuff.vulnerable.remains>execute_time&focus+{focus.regen*debuff.vulnerable.remains}>=90&focus+{focus.regen*debuff.hunters_mark.remains}>=90}}
	 	{'Barrage', 'toggle(xBarrage)'},
 	--actions+=/call_action_list,name=TargetDie,if=target.time_to_die<6&active_enemies=1
	 	{TargetDie},
 	--actions+=/call_action_list,name=Patient_Sniper,if=talent.patient_sniper.enabled
	 	{Patient_Sniper},
 	--actions+=/call_action_list,name=Non_Patient_Sniper,if=!talent.patient_sniper.enabled
		{Non_Patient_Sniper},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Survival = {

}

local Interrupts = {
	{'Counter Shot'},
}

local inCombat = {
	--{Keybinds},
	--{Survival, 'player.health < 100'},
	--{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=30'},
	--{Cooldowns, 'toggle(cooldowns)'},
	{xCombat,'target.range<40&target.infront'},
}

local outCombat = {
	{Keybinds},
	--{PreCombat}
}

NeP.CR:Add(254, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] HUNTER - Marksmanship',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
