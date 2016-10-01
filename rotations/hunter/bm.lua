local GUI = {

}

local exeOnLoad = function()

	Xeer.Splash()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rHUNTER |cffADFF2FBeast Mastery |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/1 - 3/X - 4/2 - 5/X - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')	
			
end

local _Xeer = { -- some non-SiMC stuffs

	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},
	

--[[
hunter="Hunter_BM_T19P"
level=110
race=orc
role=attack
position=ranged_back
talents=2102012
artifact=56:137365:133768:137472:0:869:3:870:2:872:3:874:3:875:4:878:1:880:1:881:1:882:1:1095:3:1336:1
spec=beast_mastery

# Gear Summary
# gear_ilvl=842.00
# gear_agility=11306
# gear_stamina=17963
# gear_crit_rating=1307
# gear_haste_rating=3994
# gear_mastery_rating=10699
# gear_versatility_rating=960
# gear_armor=2433
# set_bonus=journey_through_time_2pc=1
# set_bonus=tier19p_mail_2pc=1
summon_pet=cat
--]]
	
}

local PreCombat = {

	--# Executed before combat begins. Accepts non-harmful actions only.
 	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--{'', ''},

 	--actions.precombat+=/food,type=nightborne_delicacy_platter
	--{'', ''},

 	--actions.precombat+=/summon_pet
	--{'', ''},

	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
 	--actions.precombat+=/snapshot_stats
	--{'', ''},

 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},

 	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},

}

local Survival = {

}


local Cooldowns = {

}

local xCombat = {

	{'Mend Pet', 'pet.exists&pet.alive&pet.health<100'},
	
 	--actions+=/arcane_torrent,if=focus.deficit>=30
	{'Arcane Torrent', 'focus.deficit>=30'},

 	--actions+=/blood_fury
	{'Blood Fury'},

 	--actions+=/berserking
	{'Berserking'},

 	--actions+=/potion,name=deadly_grace
	--{'', ''},

 	--actions+=/a_murder_of_crows
	{'A Murder of Crows', 'talent(6,1)'},

 	--actions+=/stampede,if=buff.bloodlust.up||buff.bestial_wrath.up||cooldown.bestial_wrath.remains<=2||target.time_to_die<=14
	{'Stampede', 'talent(7,1)&{buff(Bloodlust)||buff(Bestial Wrath)||spell(Bestial Wrath).cooldown<=2}||target.time_to_die<=14'},

 	--actions+=/dire_beast,if=cooldown.bestial_wrath.remains>2
	{'Dire Beast', 'spell(Bestial Wrath).cooldown>2'},

 	--actions+=/dire_frenzy,if=cooldown.bestial_wrath.remains>2
	{'Dire Frenzy', 'talent(2,2)&spell(Bestial Wrath).cooldown>2'},

 	--actions+=/aspect_of_the_wild,if=buff.bestial_wrath.up
	{'Aspect of the Wild', 'buff(Bestial Wrath)'},

 	--actions+=/barrage,if=spell_targets.barrage>1||(spell_targets.barrage=1&focus>90)
	{'Barrage', 'talent(6,1)&area(40).enemies>1||{area(40).enemies=1&focus>90}'},

 	--actions+=/titans_thunder,if=cooldown.dire_beast.remains>=3||buff.bestial_wrath.up&pet.dire_beast.active
	{'Titan\'s Thunder', 'spell(Dire Beast).cooldown>=3||buff(Bestial Wrath)&buff(Dire Beast)'},

 	--actions+=/bestial_wrath
	{'Bestial Wrath'},

 	--actions+=/multi_shot,if=spell_targets.multi_shot>4&(pet.buff.beast_cleave.remains<gcd.max||pet.buff.beast_cleave.down)
	{'Multi-Shot', 'area(40).enemies>4&{pet.buff(Beast Cleave).remains<gcd||!pet.buff(Beast Cleave)}'},

 	--actions+=/kill_command
	{'Kill Command', 'target.petrange<25'},

 	--actions+=/multi_shot,if=spell_targets.multi_shot>1&(pet.buff.beast_cleave.remains<gcd.max*2||pet.buff.beast_cleave.down)
	{'Multi-Shot', 'area(40).enemies>1&{pet.buff(Beast Cleave).remains<gcd*2||!pet.buff(Beast Cleave)}'},

 	--actions+=/chimaera_shot,if=focus<90
	{'Chimaera Shot', 'talent(2,3)&focus<90'},

 	--actions+=/cobra_shot,if=talent.killer_cobra.enabled&(cooldown.bestial_wrath.remains>=4&(buff.bestial_wrath.up&cooldown.kill_command.remains>=2)||focus>119)||!talent.killer_cobra.enabled&focus>90
	{'Cobra Shot', 'talent(7,2)&{spell(Bestial Wrath).cooldown>=4&{buff(Bestial Wrath)&spell(Kill Command).cooldown>=2}||focus>119}||{!talent(7,2)&focus>90}'},


}


local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	
}

local inCombat = {

	{Keybinds},
	--{Survival, 'player.health < 100'},
	--{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, {'target.range < 40', 'target.infront'}}
	
}

local outCombat = {

	{Keybinds},
	
}

NeP.Engine.registerRotation(253, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] HUNTER - Beast Mastery', inCombat, outCombat, exeOnLoad, GUI)