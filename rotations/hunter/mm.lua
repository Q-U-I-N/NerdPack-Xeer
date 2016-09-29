local GUI = {

}

local exeOnLoad = function()
	Xeer.Splash()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHUNTER |cffADFF2FMarksmanship |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/X - 4/3 - 5/X - 6/2 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')	
			
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
]]--
	
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
	{'', ''}

}

local xCombat = {

	--# Executed every time the actor is available.
 	--actions.+=/arcane_torrent,if=focus.deficit>=30
	{'Arcane Torrent', 'player.focusdeficit>=30'},

 	--actions.+=/blood_fury
	{'Blood Fury'},

 	--actions.+=/berserking
	{'Berserking'},

 	--actions.+=/call_action_list,name=cooldowns
	{Cooldowns},

 	--actions.+=/a_murder_of_crows
	{'A Murder of Crows', ''},

 	--actions.+=/barrage
	{'Barrage', ''},

 	--actions.+=/piercing_shot,if=!talent.patient_sniper.enabled&focus>50
	{'Piercing Shot', ''},

 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&(debuff.vulnerability.down||debuff.vulnerability.remains<cast_time)
	{'', ''},

 	--actions.+=/windburst,if=active_enemies<2&buff.marking_targets.down&focus+cast_regen>90
	{'Windburst', ''},

 	--actions.+=/windburst,if=active_enemies<2&cooldown.sidewinders.charges=0
	{'Windburst', ''},

 	--actions.+=/arcane_shot,if=!talent.patient_sniper.enabled&active_enemies=1&debuff.vulnerability.react<3&buff.marking_targets.react&debuff.hunters_mark.down
	{'Arcane Shot', ''},

 	--actions.+=/marked_shot,if=!talent.patient_sniper.enabled&debuff.vulnerability.react<3
	{'Marked Shot', ''},

 	--actions.+=/marked_shot,if=prev_off_gcd.sentinel
	{'Marked Shot', ''},

 	--actions.+=/sentinel,if=debuff.hunters_mark.down&buff.marking_targets.down
	{'Sentinel', ''},

 	--actions.+=/explosive_shot
	{'Explosive Shot', ''},

 	--actions.+=/marked_shot,if=active_enemies>=4&cooldown.sidewinders.charges_fractional>=0.8
	{'Marked Shot', ''},

 	--actions.+=/sidewinders,if=active_enemies>1&debuff.hunters_mark.down&(buff.marking_targets.react||buff.trueshot.react||charges=2)
	{'Sidewinders', ''},

 	--actions.+=/arcane_shot,if=talent.steady_focus.enabled&active_enemies=1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Arcane Shot', ''},

 	--actions.+=/multishot,if=talent.steady_focus.enabled&active_enemies>1&(buff.steady_focus.down||buff.steady_focus.remains<2)
	{'Multi-Shot', ''},

 	--actions.+=/arcane_shot,if=talent.true_aim.enabled&active_enemies=1&(debuff.true_aim.react<1||debuff.true_aim.remains<2)
	{'Arcane Shot', ''},

 	--actions.+=/aimed_shot,if=buff.lock_and_load.up&debuff.vulnerability.remains>gcd.max
	{'Aimed Shot', ''},

 	--actions.+=/piercing_shot,if=talent.patient_sniper.enabled&focus>80
	{'Piercing Shot', ''},

 	--actions.+=/marked_shot,if=!talent.sidewinders.enabled&(debuff.vulnerability.remains<2||buff.marking_targets.react)
	{'Marked Shot', ''},

 	--actions.+=/pool_resource,for_next=1,if=talent.sidewinders.enabled&(focus<60&cooldown.sidewinders.charges_fractional<=1.2)
	{'', ''},

 	--actions.+=/aimed_shot,if=cast_time<debuff.vulnerability.remains&(focus+cast_regen>80||debuff.hunters_mark.down)
	{'Aimed Shot', ''},

 	--actions.+=/marked_shot
	{'Marked Shot', ''},

 	--actions.+=/black_arrow
	{'Black Arrow', ''},

 	--actions.+=/sidewinders,if=debuff.hunters_mark.down&(buff.marking_targets.remains>6||buff.trueshot.react||charges=2)
	{'Sidewinders', ''},

 	--actions.+=/sidewinders,if=focus<30&charges<=1&recharge_time<=5
	{'Sidewinders', ''},

 	--actions.+=/multishot,if=spell_targets.barrage>1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Multi-Shot', ''},

 	--actions.+=/arcane_shot,if=spell_targets.barrage=1&(debuff.hunters_mark.down&buff.marking_targets.react||focus.time_to_max>=2)
	{'Arcane Shot', ''},

 	--actions.+=/arcane_shot,if=focus.deficit<10
	{'Arcane Shot', ''},

}


local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
}


local ST = {
	--Marked Shot to maintain Vulnerable.
	{'Marked Shot', {
		'!target.debuff(Vulnerable).count >= 3', 
		'or', -- OR
		'target.debuff(Vulnerable).duration < 8'
	}, 'target'},
	--Aimed Shot with Lock and Load or to dump excess Focus.
	{'Aimed Shot', {
		'player.buff(Lock and Load)',
		'or', -- OR
		'player.focus > 65'
	}, 'target'},
	--Arcane Shot to build Focus.
	{'Arcane Shot'}
}

local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	
}

local inCombat = {

	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{pet, {'pet.exists', 'pet.alive'}},
	{AoE, {'toggle(AoE)', 'player.area(40).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}

}

local outCombat = {

	{Keybinds},

}

NeP.Engine.registerRotation(254, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Hunter - Marksmanship', Interface, outCombat, exeOnLoad, GUI)