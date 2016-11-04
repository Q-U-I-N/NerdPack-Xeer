local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FRetribution |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/1 - 4/2 - 5/1 - 6/1 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = { -- some non-SiMC stuffs

	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
paladin="Paladin_Retribution_T19P"
level=110
race=blood_elf
role=attack
position=back
talents=1111112
artifact=2:136717:137316:136717:0:40:1:41:3:42:3:47:1:50:3:51:3:53:6:350:1:353:1:1275:1
spec=retribution

# Gear Summary
# gear_ilvl=842.00
# gear_strength=11306
# gear_stamina=17964
# gear_crit_rating=7401
# gear_haste_rating=7170
# gear_mastery_rating=687
# gear_versatility_rating=1704
# gear_armor=3965
# set_bonus=tier19p_plate_2pc=1
--]]

}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
	--actions.precombat=flask,type=flask_of_the_countless_armies
	--actions.precombat+=/food,type=azshari_salad
	--actions.precombat+=/augmentation,type=defiled
	--actions.precombat+=/greater_blessing_of_might
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=old_war
	-- Greater Blessing of Wisdom
	{'Greater Blessing of Wisdom', '!player.buff(Greater Blessing of Wisdom)', 'player'},
	-- Greater Blessing of Might
	{'Greater Blessing of Might', '!player.buff(Greater Blessing of Might)', 'player'},
	-- Greater Blessing of Kings
	{'Greater Blessing of Kings', '!player.buff(Greater Blessing of Kings)', 'player'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}
local Survival = {
	{'Lay on Hands', 'player.health<=20'},
	--{'Flash of Light', 'player.health<=40'},
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'cooldown(Rebuke).remains>gcd'},
	{'Arcane Torrent', 'target.range<=8&cooldown(Rebuke).remains>gcd&!prev_gcd(Rebuke)'},
}

local Cooldowns = {
	--actions+=/potion,name=old_war,if=(buff.bloodlust.up||buff.avenging_wrath.up||buff.crusade.up||target.time_to_die<=40)
	--actions+=/use_item,name=faulty_countermeasure,if=(buff.avenging_wrath.up||buff.crusade.up)
	--actions+=/holy_wrath
	{'Holy Wrath'},
	--actions+=/avenging_wrath
	{'Avenging Wrath'},
	--actions+=/shield_of_vengeance
	{'Avenging Wrath'},
	--actions+=/crusade,if=holy_power>=5
	{'Crusade', 'holy_power>=5'},
	--actions+=/wake_of_ashes,if=holy_power>=0&time<2
	{'Wake of Ashes', 'holy_power>=0&xtime<2'},
	--actions+=/execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5||debuff.judgment.remains>gcd*4.67)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*2)
	{'Execution Sentence','talent(1,2)&{player.area(6).enemies<=3&{cooldown(Judgment).remains<gcd*4.5||target.debuff(judgment).remains>gcd*4.67}&{!talent(7,2)||cooldown(Crusade).remains>gcd*2}}'},
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/berserking
	{'Berserking'},
}

local xCombat = {
 	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
 	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.up
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&holy_power>=5&player.buff(Divine Purpose)'},
 	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&holy_power>=5&{!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
 	--actions+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2&!equipped(Whisper of the Nathrezim)'},
 	--actions+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.up&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>=5&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)&player.buff(Divine Purpose).remains<gcd*2'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.up
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=5&player.buff(Divine Purpose)'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=5&{!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
 	--actions+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>=3&player.area(6).enemies>=2&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim)&player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
 	--actions+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&holy_power>=3&player.buff(Divine Purpose)&cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled&!equipped(Whisper of the Nathrezim)'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=3&{cooldown(Wake of Ashes).remains<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim).remains<gcd}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
 	--actions+=/wake_of_ashes,if=holy_power=0|holy_power=1&cooldown.blade_of_justice.remains>gcd|holy_power=2&(cooldown.zeal.charges_fractional<=0.65|cooldown.crusader_strike.charges_fractional<=0.65)
	{'Wake of Ashes', 'holy_power=0||holy_power=1&cooldown(Blade of Justice).remains>gcd||holy_power=2&{cooldown(Zeal).charges<=0.65||cooldown(Crusader Strike).charges<=0.65}'},
 	--actions+=/zeal,if=charges=2&holy_power<=4
	{'Zeal', 'talent(2,2)&{cooldown(Zeal).charges=2&holy_power<=4}'},
 	--actions+=/crusader_strike,if=charges=2&holy_power<=4
	{'Crusader Strike', 'cooldown(Crusader Strike).charges=2&holy_power<=4'},
 	--actions+=/blade_of_justice,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
	{'Blade of Justice', 'holy_power<=2||{holy_power<=3&{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}}'},
 	--actions+=/judgment,if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&cooldown.blade_of_justice.remains>gcd)|(talent.greater_judgment.enabled&target.health.pct>50)
	{'Judgment', 'holy_power>=3||{{cooldown(Zeal).charges<=1.67||cooldown(Crusader Strike).charges<=1.67}&cooldown(Blade of Justice).remains>gcd}||{talent(2,3)&target.health>50}'},
 	--actions+=/consecration
	{'Consecration', 'talent(1,3)'},
 	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(Divine Purpose)'},
 	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&player.buff(The Fires of Justice)&{!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&cooldown.blade_of_justice.remains>gcd))&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&{holy_power>=4||{{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}&cooldown(Blade of Justice).remains>gcd}}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
 	--actions+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'target.debuff(Judgment)&player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(The Fires of Justice)&{!talent(7,2)||cooldown(Crusade).remains>gcd*3}'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&cooldown.blade_of_justice.remains>gcd))&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&{holy_power>=4||{{cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34}&cooldown(Blade of Justice).remains>gcd}}&{!talent(7,2)||cooldown(Crusade).remains>gcd*4}'},
 	--actions+=/zeal,if=holy_power<=4
	{'Zeal', 'talent(2,2)&holy_power<=4'},
 	--actions+=/crusader_strike,if=holy_power<=4
	{'Crusader Strike', 'holy_power<=4'},
 	--actions+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	{'Divine Storm', 'target.debuff(Judgment)&holy_power>=3&player.area(6).enemies>=2&{!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
 	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=3&{!talent(7,2)||cooldown(Crusade).remains>gcd*5}'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(70, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] PALADIN - Retribution',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
