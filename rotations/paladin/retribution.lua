local _, Xeer = ... 

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FRetribution |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/1 - 4/1 - 5/1 - 6/1 - 7/2')
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
	{'Greater Blessing of Wisdom', '!player.buff(Greater Blessing of Wisdom).any', 'player'},
	-- Greater Blessing of Might
	{'Greater Blessing of Might', '!player.buff(Greater Blessing of Might).any', 'player'},
	-- Greater Blessing of Kings
	{'Greater Blessing of Kings', '!player.buff(Greater Blessing of Kings).any', 'player'}
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
	--actions+=/potion,name=old_war,if=(buff.bloodlust.react||buff.avenging_wrath.up||buff.crusade.up||target.time_to_die<=40)
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
	--actions+=/execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5||debuff.judgment.remains>gcd*4.67)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*2)
	{'Execution Sentence','player.area(6).enemies<=3&{cooldown(Judgment).remains<gcd*4.5||target.debuff(judgment).remains>gcd*4.67}&{!talent(7,2)||cooldown(Crusade).remains>gcd*2}'},
	--actions+=/blood_fury
	{'Blood Fury'},
	--actions+=/berserking
	{'Berserking'},
}

local VB = {
	--actions.VB=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Divine Storm', 'player.area(6).enemies>=2&player.buff(Divine Purpose).remains<gcd*2'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	{'Divine Storm', 'target.debuff(Judgment)&player.area(6).enemies>=2&holy_power>=5&player.buff(Divine Purpose).react'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'holy_power>=5&!talent(7,2)||cooldown(Crusade).remains>gcd*3'},
	--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	-- NOT NEEDED!
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Templar\'s Verdict', 'player.buff(Divine Purpose).remains<gcd*2'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	{'Templar\'s Verdict', 'holy_power>=5&player.buff(Divine Purpose)'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	{'Templar\'s Verdict', 'holy_power>=5&!talent(7,2)&cooldown(Crusade).remains>gcd*3'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'player.area(6).enemies>=2&cooldown(Wake of Ashes).remains<gcd*2||player.buff(Whisper of the Nathrezim).remains<gcd&!talent(7,2)||cooldown(Crusade).remains>gcd*4'},
	--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'cooldown(Wake of Ashes).remains<gcd*2&!equipped(Whisper of the Nathrezim)'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	{'Templar\'s Verdict', 'cooldown(Wake of Ashes).remains<gcd*2||player.buff(Whisper of the Nathrezim).remains<gcd&!talent(7,2)||cooldown(Crusade).remains>gcd*4&holy_power>=3&target.debuff(Judgment)'},
	--actions.VB+=/wake_of_ashes,if=holy_power=0||holy_power=1&cooldown.blade_of_justice.remains>gcd||holy_power=2&(cooldown.zeal.charges_fractional<=0.34||cooldown.crusader_strike.charges_fractional<=0.34)
	{'Wake of Ashes', 'holy_power=0||holy_power=1&cooldown(Blade of Justice).remains>gcd||holy_power=2&cooldown(Zeal).charges<=0.34||cooldown(Crusader Strike).charges<=0.34'},
	--actions.VB+=/zeal,if=charges=2&holy_power<=4
	{'Zeal', 'spell.charges=2&holy_power<=4'},
	--actions.VB+=/crusader_strike,if=charges=2&holy_power<=4
	{'Crusader Strike', 'spell.charges=2&holy_power<=4'},
	--actions.VB+=/blade_of_justice,if=holy_power<=2||(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34||cooldown.crusader_strike.charges_fractional<=1.34))
	{'Blade of Justice', 'holy_power<=2||holy_power<=3&cooldown(Zeal).charges<=1.34||cooldown(Crusader Strike).charges<=1.34'},
	--actions.VB+=/judgment,if=holy_power>=3||((cooldown.zeal.charges_fractional<=1.67||cooldown.crusader_strike.charges_fractional<=1.67)&cooldown.blade_of_justice.remains>gcd)||(talent.greater_judgment.enabled&target.health.pct>50)
	{'Judgment', 'holy_power>=3||cooldown(Zeal).charges<=1.67||cooldown(Crusader Strike).charges<=1.67&cooldown(Blade of Justice).remains>gcd||talent(2,3)&target.health>50'},
	--actions.VB+=/consecration
	{'Consecration'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	{'Divine Storm', 'player.area(6).enemies>=2&player.buff(Divine Purpose).react'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'player.area(6).enemies>=2&player.buff(The Fires of Justice)&!talent(7,2)||cooldown(Crusade).remains>gcd*3'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'player.area(6).enemies>=2&holy_power>=4&!talent(7,2)||cooldown(Crusade).remains>gcd*4'},
	--actions.VB+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	{'Justicar\'s Vengeance', 'player.buff(Divine Purpose)&!equipped(Whisper of the Nathrezim)'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	{'Templar\'s Verdict', 'player.buff(Divine Purpose)'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	{'Templar\'s Verdict', 'player.buff(The Fires of Justice)&!talent(7,2)||cooldown(Crusade).remains>gcd*3'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	{'Templar\'s Verdict', 'holy_power>=4&!talent(7,2)||cooldown(Crusade).remains>gcd*4&target.debuff(Judment)'},
	--actions.VB+=/zeal,if=holy_power<=4
	{'Zeal', 'holy_power<=4'},
	--actions.VB+=/crusader_strike,if=holy_power<=4
	{'Crusader Strike', 'holy_power<=4'},
	--actions.VB+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*5)
	{'Divine Storm', 'player.area(6).enemies>=2'},
	--actions.VB+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*5)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holy_power>=3&!talent(7,2)||cooldown(Crusade).remains>gcd*5'},
}

local BoW = {
	--actions.BoW=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/wake_of_ashes,if=holy_power=0||holy_power=1&cooldown.blade_of_wrath.remains>gcd||holy_power=2&(cooldown.zeal.charges_fractional<=0.67||cooldown.crusader_strike.charges_fractional<=0.67)
	--actions.BoW+=/zeal,if=charges=2&holy_power<=4
	--actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&!talent.the_fires_of_justice.enabled
	--actions.BoW+=/blade_of_wrath,if=holy_power<=2||(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34||cooldown.crusader_strike.charges_fractional<=1.34))
	--actions.BoW+=/crusader_strike,if=charges=2&holy_power<=4&talent.the_fires_of_justice.enabled
	--actions.BoW+=/judgment
	--actions.BoW+=/consecration
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.BoW+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.BoW+=/zeal,if=holy_power<=4
	--actions.BoW+=/crusader_strike,if=holy_power<=4
}

local DH = {
	--actions.DH=divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*4)
	--actions.DH+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled||buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*3)
	--actions.DH+=/wake_of_ashes,if=holy_power<=1
	--actions.DH+=/zeal,if=charges=2&holy_power<=4
	--actions.DH+=/crusader_strike,if=charges=2&holy_power<=4
	--actions.DH+=/divine_hammer,if=holy_power<=3
	--actions.DH+=/judgment
	--actions.DH+=/consecration
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*5)
	--actions.DH+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*6)
	--actions.DH+=/justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*5)
	--actions.DH+=/templars_verdict,if=debuff.judgment.up&(!talent.crusade.enabled||cooldown.crusade.remains>gcd*6)
	--actions.DH+=/zeal,if=holy_power<=4
	--actions.DH+=/crusader_strike,if=holy_power<=4
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local xCombat = {
		--actions+=/call_action_list,name=VB,if=talent.virtues_blade.enabled
		{VB, 'talent(4,1)'},
		--actions+=/call_action_list,name=BoW,if=talent.blade_of_wrath.enabled
		{BoW, 'talent(4,2)'},
		--actions+=/call_action_list,name=DH,if=talent.divine_hammer.enabled
		{DH, 'talent(4,3)'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.range<8&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(70, '[|cff'..Xeer.addonColor..'Xeer|r] PALADIN - Retribution', inCombat, outCombat, exeOnLoad)
