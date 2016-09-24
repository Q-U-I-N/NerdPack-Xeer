local GUI = {

}

local exeOnLoad = function()
	--Xeer.Splash()
	
	NeP.Interface.CreateToggle(
		'autotaunt',
		'Interface\\Icons\\spell_nature_shamanrage.png',
		'Auto Taunt',
		'Automatically taunt enemies.')
		
--[[	
	NeP.Interface.CreateToggle(
		'autotarget', 
		'Interface\\Icons\\ability_hunter_snipershot', 
		'Auto Target', 
		'Automatically target the nearest enemy when target dies or does not exist')
]]--
	
end

local _Xeer = { -- non-SiMC stuffs

	{'@Xeer.Targeting()' , '!target.alive'},
	{'@Xeer.AoETaunt()' , 'toggle.autotaunt'},

	{'Impending Victory', '{!buff(Victorious)&rage>10&player.health<=85}||{buff(Victorious)&player.health<=70}'},
	{'Heroic Throw', 'target.range>8&target.range<=30&target.infront'},
	{'Shockwave', 'area(6).enemies>=3'}
	
}

local Keybinds = {

	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'mouseover.ground'}
	
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

local Something = { --same skills in same order in both parts of rotation... placed them here :)

	--actions.prot_aoe=focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled	--actions.prot+=/focused_rage,if=talent.ultimatum.enabled&buff.ultimatum.up&!talent.vengeance.enabled
	{'Focused Rage', 'talent(3,2)&buff(Ultimatum)&!talent(6,1)'},
	
	--actions.prot_aoe+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled	--actions.prot+=/battle_cry,if=(talent.vengeance.enabled&talent.ultimatum.enabled&cooldown.shield_slam.remains<=5-gcd.max-0.5)||!talent.vengeance.enabled
	{'Battle Cry', '{talent(6,1)&talent(3,2)&spell(Shield Slam).cooldown<=5-gcd-0.5}||!talent(6,1)'},
	
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
	{'Neltharions Fury', 'buff(Battle Cry)'},
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
	{'Shield Block', '!buff(203524)&{{spell(Shield Slam).cooldown<6&!buff(Shield Block)}||{spell(Shield Slam).cooldown<6+buff(Shield Block).duration&buff(Shield Block)}}'},
	--actions.prot+=/ignore_pain,if=(rage>=60&!talent.vengeance.enabled)||(buff.vengeance_ignore_pain.up&buff.ultimatum.up)||(buff.vengeance_ignore_pain.up&rage>=30)||(talent.vengeance.enabled&!buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage<30)
	{'Ignore Pain','{rage>=60&!talent(6,1)}||{buff(Vengeance: Ignore Pain)&buff(Ultimatum)}||{buff(Vengeance: Ignore Pain)&rage>=30}||{talent(6,1)&!buff(Ultimatum)&!buff(Vengeance: Ignore Pain)&!buff(Vengeance: Focused Rage)&rage<30}'},
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
	{'203524', 'incdmg(2.5)>health.max*0.20&!buff(Shield Block)'},
	
	--actions.prot+=/shield_slam,if=!(cooldown.shield_block.remains<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
	{'Shield Slam', '!{spell(Shield Block).cooldown<=gcd*2&!buff(Shield Block)&talent(7,2)}||{rage<=5}'},

	
	--actions.prot+=/revenge,if=cooldown.shield_slam.remains<=gcd.max*2
	{'Revenge', '{spell(Shield Slam).cooldown<=gcd*2}||{rage<=5}'},

	
	--actions.prot+=/devastate
	{'Devastate'}
	
}

local inCombat = {

	{Keybinds},
	{Cooldowns},
	{_Xeer},
	{ST, {'target.range < 8', 'target.infront'}}
	
}

local outCombat = {

	{Keybinds},
	{PreCombat},

}

NeP.Engine.registerRotation(73, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] WARRIOR - Protection', inCombat, outCombat, exeOnLoad, GUI)

