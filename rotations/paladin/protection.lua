local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
--[[
	NeP.Interface.CreateToggle(
		'AutoTaunt',
		'Interface\\Icons\\spell_nature_shamanrage.png',
		'Auto Taunt',
		'Automatically taunt nearby enemies.')
--]]
end

local _Xeer = {
-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},
--{'%taunt(Hand of Reckoning)', 'toggle(AutoTaunt)'}

--[[
paladin='Paladin_Protection_T19P'
level=110
race=blood_elf
role=tank
position=front
talents=2231223
artifact=49:137548:136778:137547:0:1120:1:1121:3:1124:3:1125:1:1126:3:1128:6:1129:3:1133:1:1135:1:1343:1
spec=protection

# Gear Summary
# gear_ilvl=843.75
# gear_strength=9969
# gear_stamina=19629
# gear_crit_rating=1891
# gear_haste_rating=9554
# gear_mastery_rating=680
# gear_versatility_rating=4820
# gear_armor=3965
# set_bonus=march_of_the_legion_2pc=1
# set_bonus=tier19p_plate_2pc=1
--]]
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'spell(Rebuke).cooldown>gcd'}
}

PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=flask_of_ten_thousand_scars
	--actions.precombat+=/flask,type=flask_of_the_countless_armies,if=role.attack||using_apl.max_dps
	--actions.precombat+=/food,type=seedbattered_fish_plate
	--actions.precombat+=/food,type=azshari_salad,if=role.attack||using_apl.max_dps
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=unbending_potion
}

local Cooldowns = {
	--actions.prot=seraphim,if=talent.seraphim.enabled&action.shield_of_the_righteous.charges>=2
	{'Seraphim', 'talent(7,2)&spell(Shield of the Righteous).charges>=2'},
	--actions.prot+=/shield_of_the_righteous,if=(!talent.seraphim.enabled||action.shield_of_the_righteous.charges>2)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
	{'Shield of the Righteous', {'target.range<8', 'target.infront', '{!talent(7,2)||spell(Shield of the Righteous).charges>2}&!{player.buff(Eye of Tyr)&player.buff(Aegis of Light)&player.buff(Ardent Defender)&player.buff(Guardian of Ancient Kings)&player.buff(Divine Shield)}'}},
	--actions.prot+=/bastion_of_light,if=talent.bastion_of_light.enabled&action.shield_of_the_righteous.charges<1
	{'Bastion of Light', 'talent(2,2)&spell(Shield of the Righteous).charges<1'},
	--actions.prot+=/light_of_the_protector,if=(health.pct<40)
	{'Light of the Protector', 'player.health<40'},
	--actions.prot+=/hand_of_the_protector,if=(health.pct<40)
	{'Hand of the Protector', 'talent(5,1)&player.health<40'},
	--actions.prot+=/light_of_the_protector,if=(incoming_damage_10000ms<player.health.max*1.25)&health.pct<55&talent.righteous_protector.enabled
	{'Light of the Protector', '{player.incdmg(10)>player.health.max*1.25}&player.health<55&talent(7,1)'},
	--actions.prot+=/light_of_the_protector,if=(incoming_damage_13000ms<player.health.max*1.6)&health.pct<55
	{'Light of the Protector', '{player.incdmg(13)>player.health.max*1.6}&player.health<55'},
	--actions.prot+=/hand_of_the_protector,if=(incoming_damage_6000ms<player.health.max*0.7)&health.pct<65&talent.righteous_protector.enabled
	{'Hand of the Protector', 'talent(5,1)&{player.incdmg(6)>player.health.max*0.7}&player.health<55&talent(7,1)'},
	--actions.prot+=/hand_of_the_protector,if=(incoming_damage_9000ms<player.health.max*1.2)&health.pct<55
	{'Hand of the Protector', 'talent(5,1)&{player.incdmg(9)>player.health.max*1.2}&player.health<55'},
	--actions.prot+=/divine_steed,if=talent.knight_templar.enabled&incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Divine Steed', 'talent(5,2)&player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/eye_of_tyr,if=incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Eye of Tyr', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/aegis_of_light,if=incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Aegis of Light', 'talent(6,1)&player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/guardian_of_ancient_kings,if=incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Guardian of Ancient Kings', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/divine_shield,if=talent.final_stand.enabled&incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Divine Shield', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/ardent_defender,if=incoming_damage_2500ms>player.health.max*0.4&!(debuff.eye_of_tyr.up||buff.aegis_of_light.up||buff.ardent_defender.up||buff.guardian_of_ancient_kings.up||buff.divine_shield.up||buff.potion.up)
	{'Ardent Defender', 'player.incdmg(2.5)>player.health.max*0.40&!{player.buff(Eye of Tyr)||player.buff(Aegis of Light)||player.buff(Ardent Defender)||player.buff(Guardian of Ancient Kings)||player.buff(Divine Shield)}'},
	--actions.prot+=/lay_on_hands,if=health.pct<15
	{'Lay on Hands', 'player.health<15'},
	--actions.prot+=/avenging_wrath,if=!talent.seraphim.enabled
	{'Avenging Wrath', '!talent(7,2)'},
	--actions.prot+=/avenging_wrath,if=talent.seraphim.enabled&buff.seraphim.up
	{'Avenging Wrath', 'talent(7,2)&player.buff(Seraphim)'}
}


local AoE = {
	--actions.prot_aoe=avengers_shield
	{'Avenger\'s Shield'},
	--actions.prot_aoe+=/blessed_hammer
	{'Blessed Hammer'},
	--actions.prot_aoe+=/judgment
	{'Judgment'},
	--actions.prot_aoe+=/consecration
	{'Consecration', 'target.range < 7'},
	--actions.prot_aoe+=/hammer_of_the_righteous
	{'Hammer of the Righteous', '!talent(1,2)'},
}

local ST = {
	--actions.prot+=/judgment
	{'Judgment'},
	--actions.prot+=/blessed_hammer
	{'Blessed Hammer'},
	--actions.prot+=/avengers_shield
	{'Avenger\'s Shield'},
	--actions.prot+=/consecration
	{'Consecration', 'target.range<7'},
	--actions.prot+=/blinding_light
	{'Blinding Light'},
	--actions.prot+=/hammer_of_the_righteous
	{'Hammer of the Righteous', '!talent(1,2)'},
}

local inCombat = {
	{Keybinds},
	{_Xeer},
--{Survival, 'player.health < 100'},
	{Interrupts, {'target.interruptAt(50)', 'toggle(Interrupts)', 'target.infront', 'target.range<8'}},
	{Cooldowns, 'toggle(Cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies>=3'}},
	{ST, 'target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(66, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] PALADIN - Protection', inCombat, outCombat, exeOnLoad)
