local exeOnLoad = function()
	NeP.Xeer:Splash()

	print("|cffADFF2F ----------------------------------------------------------------------|r")
	print("|cffADFF2F --- |rWARRIOR |cffADFF2FProtection |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/2 - 5/3 - 6/1 - 7/2")
	print("|cffADFF2F ----------------------------------------------------------------------|r")

	NeP.Interface:AddToggle({
		key = 'AutoTaunt',
		name = 'Auto Taunt',
		text = 'Automatically taunt nearby enemies.',
		icon = 'Interface\\Icons\\spell_nature_shamanrage',
	})

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},
	--{'@Xeer.Taunt(Taunt)', 'toggle(AutoTaunt)'},
	--{'%taunt(Taunt)', 'toggle(AutoTaunt)'},
	{'Impending Victory', '{!buff(Victorious)&rage>10&player.health<=85}||{buff(Victorious)&player.health<=70}'},
	{'Heroic Throw', 'target.range>8&target.range<=30&target.infront'},	{'Shockwave', 'area(6).enemies>=3'}

--[[
warrior="Warrior_Protection_T19P"
level=110
race=tauren
role=tank
position=front
talents=1222312
artifact=11:0:0:0:0:91:1:92:1:93:1:95:2:99:3:100:3:101:3:102:3:103:1:104:1:1358:1
spec=protection

# Gear Summary
# gear_ilvl=843.75
# gear_strength=11292
# gear_stamina=17944
# gear_crit_rating=971
# gear_haste_rating=1910
# gear_mastery_rating=7106
# gear_versatility_rating=6958
# gear_armor=3965
--]]
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
}

local Interrupts = {
	{'Pummel'}
}

local Cooldowns = {
	--# Executed every time the actor is available.
	--actions=intercept
	--actions+=/auto_attack
	--actions+=/blood_fury
	--actions+=/berserking
	--actions+=/arcane_torrent
	--actions+=/call_action_list,name=prot
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=countless_armies
	--actions.precombat+=/food,type=seedbattered_fish_plate
	--actions.precombat+=/augmentation,type=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=unbending_potion
}

local Something = {
	--same skills in same order in both parts of rotation... placed them here :)
	--actions.prot_aoe=focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
	--actions.prot+=/focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
	{'Focused Rage', 'talent(3,2)&buff(Ultimatum)&!talent(6,1)'},
	--actions.prot_aoe+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled
	--actions.prot+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled
	{'Battle Cry', '{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<=4.5-gcd}||!talent(6,1)'},
	--actions.prot_aoe+=/demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
	--actions.prot+=/demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
	{'Demoralizing Shout', 'talent(6,3)&buff(Battle Cry)'},
	--actions.prot_aoe+=/ravager,if=talent.ravager.enabled&buff.battle_cry.up
	--actions.prot+=/ravager,if=talent.ravager.enabled&buff.battle_cry.up
	{'Ravager', 'talent(7,3)&buff(Battle Cry)'}
}

local AoE = {
	{Something},
	--actions.prot_aoe+=/neltharions_fury,if=buff.battle_cry.up
	{'Neltharion\'s Fury', 'buff(Battle Cry)'},
	--actions.prot_aoe+=/shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd*2&!buff(Shield Block)&talent(7,2)}'},
	--actions.prot_aoe+=/revenge
	{'Revenge'},
	--actions.prot_aoe+=/thunder_clap,if=spell_targets.thunder_clap>=3
	{'Thunder Clap', 'area(6).enemies>=3'},
	--actions.prot_aoe+=/devastate
	{'Devastate'}
}

local ST = {
	--actions.prot=shield_block,if=!buff.neltharions_fury.up&((cooldown.shield_slam.remains<6&!buff.shield_block.up)||(cooldown.shield_slam.remains<6+buff.shield_block.remains&buff.shield_block.up))
	{'Shield Block', '!buff(Neltharion\'s Fury)&{{spell(Shield Slam).cooldown<6&!buff(Shield Block)}||{spell(Shield Slam).cooldown<6+buff(Shield Block).duration&buff(Shield Block)}}'},
	--actions.prot+=/ignore_pain,if=(rage>=60&!talent.vengeance.enabled)||(buff.vengeance_ignore_pain.up&buff.ultimatum.up)||(buff.vengeance_ignore_pain.up&rage>=30)||(talent.vengeance.enabled&!buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage<30)
	{'!Ignore Pain','{buff(Vengeance: Ignore Pain)&buff(Ignore Pain).duration<=gcd*2&rage>=13}||{!buff(Vengeance: Ignore Pain)&buff(Ignore Pain).duration<=gcd*2&rage>=20}||{rage>=60&!talent(6,1)}||{buff(Vengeance: Ignore Pain)&buff(Ultimatum)}||{buff(Vengeance: Ignore Pain)&rage>=30}||{talent(6,1)&!buff(Ultimatum)&!buff(Vengeance: Ignore Pain)&!buff(Vengeance: Focused Rage)&rage<30}'},
	--actions.prot+=/focused_rage,if=(buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)||(buff.ultimatum.up&buff.vengeance_focused_rage.up&!buff.vengeance_ignore_pain.up)||(talent.vengeance.enabled&buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up)||(talent.vengeance.enabled&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage>=30)||(buff.ultimatum.up&buff.vengeance_ignore_pain.up&cooldown.shield_slam.remains=0&rage<10)||(rage>=100)
	{'Focused Rage', '{buff(Vengeance: Focused Rage)&!buff(Vengeance: Ignore Pain)}||{buff(Ultimatum)&buff(Vengeance: Focused Rage)&!buff(Vengeance: Ignore Pain)}||{talent(6,1)&buff(Ultimatum)&!buff(Vengeance: Ignore Pain)&!buff(Vengeance: Focused Rage)}||{talent(6,1)&!buff(Vengeance: Ignore Pain)&!buff(Vengeance: Focused Rage)&rage>=30}||{buff(Ultimatum)&buff(Vengeance: Ignore Pain)&spell(Shield Slam)&rage<10}||{rage>=100}'},
	--actions.prot+=/demoralizing_shout,if=incoming_damage_2500ms>health.max*0.20
	{'Demoralizing Shout', 'incdmg(2.5)>health.max*0.20'},
	--actions.prot+=/shield_wall,if=incoming_damage_2500ms>health.max*0.50
	{'Shield Wall', 'incdmg(2.5)>health.max*0.50'},
	--actions.prot+=/last_stand,if=incoming_damage_2500ms>health.max*0.50&!cooldown.shield_wall.remains=0
	{'Last Stand', 'incdmg(2.5)>health.max*0.50&!spell(Shield Wall).cooldown=0'},
	--actions.prot+=/potion,name=unbending_potion,if=(incoming_damage_2500ms>health.max*0.15&!buff.potion.up)||target.time_to_die<=25
	--actions.prot+=/call_action_list,name=prot_aoe,if=spell_targets.neltharions_fury>=2
	{AoE, 'area(8).enemies>=2'},
	{Something},
	--actions.prot+=/neltharions_fury,if=incoming_damage_2500ms>health.max*0.20&!buff.shield_block.up
	{'Neltharion\'s Fury', 'incdmg(2.5)>health.max*0.20&!buff(Shield Block)'},
	--actions.prot+=/shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd&!buff(Shield Block)&talent(7,2)}||{buff(Vengeance: Ignore Pain)&buff(Ignore Pain).duration<=gcd*2&rage<13}||{!buff(Vengeance: Ignore Pain)&buff(Ignore Pain).duration<=gcd*2&rage<20}||'},
	{'Shield Slam', '!talent(7,2)'},
	--actions.prot+=/revenge,if=cooldown.shield_slam.remains<=gcd.max*2
	{'Revenge', '{spell(Shield Slam).cooldown<=gcd*2||rage<=5}'},
	--actions.prot+=/devastate
	{'Devastate'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(40)'},
	--{Cooldowns},
	{_Xeer},
	{ST, {'target.range<8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
--{PreCombat}
}

NeP.CR:Add(73, '[|cff'..NeP.Xeer.Interface.addonColor..'Xeer|r] WARRIOR - Protection', inCombat, outCombat, exeOnLoad)
