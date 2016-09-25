local GUI = {

}

local exeOnLoad = function()
	--Xeer.Splash()
end

local Keybinds = {
	{'%pause', 'keybind(alt)'}
}

local Mitigation = {
	--actions.prot+=/divine_steed,if=talent.knight_templar.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	--actions.prot+=/eye_of_tyr,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	{'Eye of Tyr'},
	--actions.prot+=/aegis_of_light,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	{'Aegis of Light'},
	--actions.prot+=/guardian_of_ancient_kings,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	{'Guardian of Ancient Kings'},
	--actions.prot+=/divine_shield,if=talent.final_stand.enabled&incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	{'Divine Shield'},
	--actions.prot+=/ardent_defender,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
	{'Ardent Defender'}
}

local Survival = {
	--actions.prot=seraphim,if=talent.seraphim.enabled&action.shield_of_the_righteous.charges>=2
	{'Seraphim', 'spell(Shield of the Righteous).charges >= 2'},
	--actions.prot+=/shield_of_the_righteous,if=(!talent.seraphim.enabled|action.shield_of_the_righteous.charges>2)&!(debuff.eye_of_tyr.up&buff.aegis_of_light.up&buff.ardent_defender.up&buff.guardian_of_ancient_kings.up&buff.divine_shield.up&buff.potion.up)
	{'Shield of the Righteous', {
		'!talent(7,2)', 'or', 'spell(Shield of the Righteous).charges > 2',
		{'!player.debuff(Eye of Tyr)', '!player.buff(Aegis of Light)', '!player.buff(Ardent Defender)', '!player.buff(Guardian of Ancient Kings)', '!player.buff(Divine Shield)'}
	}, 'target' },
	--actions.prot+=/bastion_of_light,if=talent.bastion_of_light.enabled&action.shield_of_the_righteous.charges<1
	{'Bastion of Light', 'spell(Shield of the Righteous).charges < 1'},
	{{
		--actions.prot+=/light_of_the_protector,if=(health.pct<40)
		{'Light of the Protector'},
		--actions.prot+=/hand_of_the_protector,if=(health.pct<40)
		{'Hand of the Protector'},
	}, 'player.health < 40' },
	--actions.prot+=/light_of_the_protector,if=(incoming_damage_10000ms<health.max*1.25)&health.pct<55&talent.righteous_protector.enabled
	--actions.prot+=/light_of_the_protector,if=(incoming_damage_13000ms<health.max*1.6)&health.pct<55
	--actions.prot+=/hand_of_the_protector,if=(incoming_damage_6000ms<health.max*0.7)&health.pct<65&talent.righteous_protector.enabled
	--actions.prot+=/hand_of_the_protector,if=(incoming_damage_9000ms<health.max*1.2)&health.pct<55
	{Mitigation, {'player.incdmg(2.5) > player.health.max * 0.4', '!player.debuff(Eye of Tyr)', '!player.buff(Aegis of Light)', '!player.buff(Ardent Defender)', '!player.buff(Guardian of Ancient Kings)', '!player.buff(Divine Shield)'}},
	--actions.prot+=/lay_on_hands,if=health.pct<15
	{'Lay on Hands', 'player.health < 15'},
	--actions.prot+=/potion,name=unbending_potion
	--actions.prot+=/potion,name=draenic_strength,if=incoming_damage_2500ms>health.max*0.4&&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)|target.time_to_die<=25
	--actions.prot+=/stoneform,if=incoming_damage_2500ms>health.max*0.4&!(debuff.eye_of_tyr.up|buff.aegis_of_light.up|buff.ardent_defender.up|buff.guardian_of_ancient_kings.up|buff.divine_shield.up|buff.potion.up)
}

local Interrupts = {
	{'Rebuke'}
}

local AoE = {
	--actions.prot_aoe=avengers_shield
	--actions.prot_aoe+=/blessed_hammer
	--actions.prot_aoe+=/judgment
	--actions.prot_aoe+=/consecration
	--actions.prot_aoe+=/hammer_of_the_righteous
}

local ST = {
	--actions.prot+=/avenging_wrath,if=!talent.seraphim.enabled
	{'Avenging Wrath', '!talent(7,2)'},
	--actions.prot+=/avenging_wrath,if=talent.seraphim.enabled&buff.seraphim.up
	{'Avenging Wrath', {'talent(7,2)', 'player.buff(Seraphim)'}},
	--actions.prot+=/judgment
	{'Judgment'},
	--actions.prot+=/blessed_hammer
	{'Blessed Hammer'},
	--actions.prot+=/avengers_shield
	{'Avenger\'s Shield'},
	--actions.prot+=/consecration
	{'Consecration', 'target.range < 7'},
	--actions.prot+=/blinding_light
	{'Blinding Light'},
	--actions.prot+=/hammer_of_the_righteous
	{'Hammer of the Righteous'},
}

local inCombat = {
	{Keybinds},
	{Survival, "player.health < 100"},
	{Interrupts, 'target.interruptAt(50)'},
	{Cooldowns, "toggle(cooldowns)"},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, 'target.infront'}
}

local outCombat = {
	{Keybinds},
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=flask_of_ten_thousand_scars
	--actions.precombat+=/flask,type=flask_of_the_countless_armies,if=role.attack|using_apl.max_dps
	--actions.precombat+=/food,type=seedbattered_fish_plate
	--actions.precombat+=/food,type=azshari_salad,if=role.attack|using_apl.max_dps
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=unbending_potion
}

NeP.Engine.registerRotation(66, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Paladin - Protection', inCombat, outCombat, exeOnLoad, GUI)