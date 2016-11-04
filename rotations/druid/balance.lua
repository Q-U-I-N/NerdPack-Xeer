local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FBalance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/2 - 3/X - 4/X - 5/2 - 6/3 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
druid="Druid_Balance_T19P"
level=110
race=troll
role=spell
position=back
talents=3200233
artifact=59:137303:137381:137303:0:1035:3:1036:3:1039:3:1040:3:1041:1:1042:5:1044:1:1046:1:1047:1:1049:1:1294:1
spec=balance

# Gear Summary
# gear_ilvl=842.00
# gear_stamina=17965
# gear_intellect=18709
# gear_crit_rating=4112
# gear_haste_rating=8291
# gear_mastery_rating=2752
# gear_versatility_rating=2702
# gear_armor=1957
# set_bonus=tier19p_leather_2pc=1
--]]
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions only.
 	--actions.precombat=flask,type=flask_of_the_whispered_pact
	--{'', ''},
 	--actions.precombat+=/food,type=azshari_salad
	--{'', ''},
 	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
 	--actions.precombat+=/moonkin_form
	{'Moonkin Form', '!player.buff(Moonkin Form)&!player.buff(Travel Form)'},
 	--actions.precombat+=/blessing_of_elune
	{'Blessing of the Ancients', '!player.buff(Blessing of Elune)'},
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
 	--actions.precombat+=/snapshot_stats
 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},
 	--actions.precombat+=/new_moon
	--{'New Moon', 'artifact(New Moon).enabled'},

}


local CA = {
 	--actions.CA_phase=starfall,if=(active_enemies>=2&talent.stellar_flare.enabled||active_enemies>=3)&((talent.fury_of_elune.enabled&cooldown.fury_of_elune.remains>12&buff.fury_of_elune.down)||!talent.fury_of_elune.enabled)
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
 	--actions.CA_phase+=/starsurge,if=active_enemies<=2
	{'Starsurge', 'target.area(15).enemies<=2'},
 	--actions.CA_phase+=/warrior_of_elune
	{'Warrior of Elune', ''},
 	--actions.CA_phase+=/lunar_strike,if=buff.warrior_of_elune.up
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
 	--actions.CA_phase+=/solar_wrath,if=buff.solar_empowerment.up
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
 	--actions.CA_phase+=/lunar_strike,if=buff.lunar_empowerment.up
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
 	--actions.CA_phase+=/solar_wrath,if=talent.natures_balance.enabled&dot.sunfire_dmg.remains<5&cast_time<dot.sunfire_dmg.remains
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
 	--actions.CA_phase+=/lunar_strike,if=(talent.natures_balance.enabled&dot.moonfire_dmg.remains<5&cast_time<dot.moonfire_dmg.remains)||active_enemies>=2
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>=2'},
 	--actions.CA_phase+=/solar_wrath
	{'Solar Wrath'},
}

local ED = {
 	--actions.ED=astral_communion,if=astral_power.deficit>=75&buff.the_emerald_dreamcatcher.up
	{'Astral Communion', 'astral_power.deficit>=75&player.buff(The Emerald Dreamcatcher)'},
 	--actions.ED+=/incarnation,if=astral_power>=85&!buff.the_emerald_dreamcatcher.up
	{'Incarnation: Chosen of Elune', 'astral_power>=85&!player.buff(The Emerald Dreamcatcher)'},
 	--actions.ED+=/celestial_alignment,if=astral_power>=85&!buff.the_emerald_dreamcatcher.up
	{'Celestial Alignment', 'astral_power>=85&!player.buff(The Emerald Dreamcatcher)'},
 	--actions.ED+=/starsurge,if=(buff.the_emerald_dreamcatcher.up&buff.the_emerald_dreamcatcher.remains<gcd.max)||astral_power>=90||((buff.celestial_alignment.up||buff.incarnation.up)&astral_power>=85)
	{'Starsurge', '{player.buff(The Emerald Dreamcatcher).remains<gcd.max}||astral_power>=90||{{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power>=85}'},
 	--actions.ED+=/stellar_flare,cycle_targets=1,max_cycle_targets=4,if=active_enemies<4&remains<7.2&astral_power>=15
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>=15}'},
 	--actions.ED+=/moonfire,if=(talent.natures_balance.enabled&remains<3)||(remains<6.6&!talent.natures_balance.enabled)
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
 	--actions.ED+=/sunfire,if=(talent.natures_balance.enabled&remains<3)||(remains<5.4&!talent.natures_balance.enabled)
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
 	--actions.ED+=/solar_wrath,if=buff.solar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=12&dot.sunfire.remains<5.4&dot.moonfire.remains>6.6
	{'Solar Wrath', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Solar Wrath).execute_time&astral_power>=12&dot(Sunfire).remains<5.4&dot(Moonfire).remains>6.6'},
 	--actions.ED+=/lunar_strike,if=buff.lunar_empowerment.up&buff.the_emerald_dreamcatcher.remains>execute_time&astral_power>=8&(!(buff.celestial_alignment.up||buff.incarnation.up)||(buff.celestial_alignment.up||buff.incarnation.up)&astral_power<=77)
	{'Lunar Strike', 'player.buff(Solar Empowerment)&player.buff(The Emerald Dreamcatcher).remains>action(Lunar Strike).execute_time&astral_power>=8&{!{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}||{player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)}&astral_power<=77}'},
 	--actions.ED+=/new_moon,if=astral_power<=90
	{'New Moon', 'astral_power<=90'},
 	--actions.ED+=/half_moon,if=astral_power<=80
	{'Half Moon', 'astral_power<=80'},
 	--actions.ED+=/full_moon,if=astral_power<=60
	{'Full Moon', 'astral_power<=60'},
 	--actions.ED+=/solar_wrath,if=buff.solar_empowerment.up
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
 	--actions.ED+=/lunar_strike,if=buff.lunar_empowerment.up
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
 	--actions.ED+=/solar_wrath
	{'Solar Wrath'},
}

local FoE = {
 	--actions.FoE=incarnation,if=astral_power>=95&cooldown.fury_of_elune.remains<=gcd
	{'Incarnation: Chosen of Elune', 'astral_power>=95&cooldown(Fury of Elune).remains<=gcd'},
 	--actions.FoE+=/fury_of_elune,if=astral_power>=95
	{'Fury of Elune', 'astral_power>=95'},
 	--actions.FoE+=/new_moon,if=((charges=2&recharge_time<5)||charges=3)&(buff.fury_of_elune.up||(cooldown.fury_of_elune.remains>gcd*3&astral_power<=90))
	{'New Moon', '{{cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=90}}'},
 	--actions.FoE+=/half_moon,if=((charges=2&recharge_time<5)||charges=3)&(buff.fury_of_elune.up||(cooldown.fury_of_elune.remains>gcd*3&astral_power<=80))
	{'Half Moon', '{{cooldown(New Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=80}}'},
 	--actions.FoE+=/full_moon,if=((charges=2&recharge_time<5)||charges=3)&(buff.fury_of_elune.up||(cooldown.fury_of_elune.remains>gcd*3&astral_power<=60))
	{'Full Moon', '{{cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3}&{player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>gcd*3&astral_power<=60}}'},
 	--actions.FoE+=/astral_communion,if=buff.fury_of_elune.up&astral_power<=25
	{'Astral Communion', 'player.buff(Fury of Elune)&astral_power<=25'},
 	--actions.FoE+=/warrior_of_elune,if=buff.fury_of_elune.up||(cooldown.fury_of_elune.remains>=35&buff.lunar_empowerment.up)
	{'Warrior of Elune', 'player.buff(Fury of Elune)||{cooldown(Fury of Elune).remains>=35&player.buff(Lunar Empowerment)}'},
 	--actions.FoE+=/lunar_strike,if=buff.warrior_of_elune.up&(astral_power<=90||(astral_power<=85&buff.incarnation.up))
	{'Lunar Strike', 'player.buff(Warrior of Elune)&{astral_power<=90||{astral_power<=85&player.buff(Incarnation: Chosen of Elune)}}'},
 	--actions.FoE+=/new_moon,if=astral_power<=90&buff.fury_of_elune.up
	{'New Moon', 'astral_power<=90&player.buff(Fury of Elune)'},
 	--actions.FoE+=/half_moon,if=astral_power<=80&buff.fury_of_elune.up&astral_power>cast_time*12
	{'Half Moon', 'astral_power<=80&player.buff(Fury of Elune)&astral_power>action(Half Moon).cast_time*12'},
 	--actions.FoE+=/full_moon,if=astral_power<=60&buff.fury_of_elune.up&astral_power>cast_time*12
	{'Full Moon', 'astral_power<=60&player.buff(Fury of Elune)&astral_power>action(Full Moon).cast_time*12'},
 	--actions.FoE+=/moonfire,if=buff.fury_of_elune.down&remains<=6.6
	{'Moonfire', '!player.buff(Fury of Elune)&target.dot(Moonfire).remains<=6.6'},
 	--actions.FoE+=/sunfire,if=buff.fury_of_elune.down&remains<5.4
	{'Sunfire', '!player.buff(Fury of Elune)&target.dot(Sunfire).remains<=5.4'},
 	--actions.FoE+=/stellar_flare,if=remains<7.2&active_enemies=1
	{'Stellar Flare', 'target.dot(Stellar Flare).remains<=7.2&player.area(40).enemies=1'},
 	--actions.FoE+=/starfall,if=(active_enemies>=2&talent.stellar_flare.enabled||active_enemies>=3)&buff.fury_of_elune.down&cooldown.fury_of_elune.remains>10
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>10', 'target.ground'},
 	--actions.FoE+=/starsurge,if=active_enemies<=2&buff.fury_of_elune.down&cooldown.fury_of_elune.remains>7
	{'Starsurge', 'target.area(15).enemies<=2&!player.buff(Fury of Elune)&cooldown(Fury of Elune).remains>7'},
 	--actions.FoE+=/starsurge,if=buff.fury_of_elune.down&((astral_power>=92&cooldown.fury_of_elune.remains>gcd*3)||(cooldown.warrior_of_elune.remains<=5&cooldown.fury_of_elune.remains>=35&buff.lunar_empowerment.stack<2))
	{'Starsurge', '!player.buff(Fury of Elune)&{{astral_power>=92&cooldown(Fury of Elune).remains>gcd*3}||{cooldown(Warrior of Elune).remains<=5&cooldown(Fury of Elune).remains>=35&player.buff(Lunar Empowerment).stack<2}}'},
 	--actions.FoE+=/solar_wrath,if=buff.solar_empowerment.up
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
 	--actions.FoE+=/lunar_strike,if=buff.lunar_empowerment.stack=3||(buff.lunar_empowerment.remains<5&buff.lunar_empowerment.up)||active_enemies>=2
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3||{player.buff(Lunar Empowerment).remains<5&buff(Lunar Empowerment)}||target.area(5).enemies>=2'},
 	--actions.FoE+=/solar_wrath
	{'Solar Wrath'},
}

local ST = {
 	--actions.ST=new_moon,if=astral_power<=90
	{'New Moon', 'astral_power<=90'},
 	--actions.ST+=/half_moon,if=astral_power<=80
	{'Half Moon', 'astral_power<=80'},
 	--actions.ST+=/full_moon,if=astral_power<=60
	{'Full Moon', 'astral_power<=60'},
 	--actions.ST+=/starfall,if=(active_enemies>=2&talent.stellar_flare.enabled||active_enemies>=3)&((talent.fury_of_elune.enabled&cooldown.fury_of_elune.remains>12&buff.fury_of_elune.down)||!talent.fury_of_elune.enabled)
	{'Starfall', '{target.area(15).enemies>=2&talent(5,3)||target.area(15).enemies>=3}&{{talent(7,1)&cooldown(Fury of Elune).remains>12&!player.buff(Fury of Elune)}||!talent(7,1)}', 'target.ground'},
 	--actions.ST+=/starsurge,if=active_enemies<=2
	{'Starsurge', 'player.area(40).enemies<=2&{player.buff(Solar Empowerment).stack<3||player.buff(Lunar Empowerment).stack<3}'},
 	--actions.ST+=/warrior_of_elune
	{'Warrior of Elune'},
 	--actions.ST+=/lunar_strike,if=buff.warrior_of_elune.up
	{'Lunar Strike', 'player.buff(Warrior of Elune)'},
 	--actions.ST+=/solar_wrath,if=buff.solar_empowerment.up
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
 	--actions.ST+=/lunar_strike,if=buff.lunar_empowerment.up
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
 	--actions.ST+=/solar_wrath,if=talent.natures_balance.enabled&dot.sunfire_dmg.remains<5&cast_time<dot.sunfire_dmg.remains
	{'Solar Wrath', 'talent(7,3)&target.dot(Sunfire).remains<5&action(Solar Wrath).cast_time<target.dot(Sunfire).remains'},
 	--actions.ST+=/lunar_strike,if=(talent.natures_balance.enabled&dot.moonfire_dmg.remains<5&cast_time<dot.moonfire_dmg.remains)||active_enemies>=2
	{'Lunar Strike', '{talent(7,3)&dot(Moonfire).remains<5&action(Lunar Strike).cast_time<target.dot(Moonfire).remains}||target.area(5).enemies>=2'},
 	--actions.ST+=/solar_wrath
	{'Solar Wrath'},
}

local xCombat = {
	--# Executed every time the actor is available.
 	--actions=potion,name=deadly_grace,if=buff.celestial_alignment.up||buff.incarnation.up
	--{'#Deadly Grace', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
 	--actions+=/blessing_of_elune,if=active_enemies<=2&talent.blessing_of_the_ancients.enabled&buff.blessing_of_elune.down
	{'Blessing of the Ancients', 'player.area(40).enemies<=2&talent(6,3)&!player.buff(Blessing of Elune)'},
 	--actions+=/blessing_of_elune,if=active_enemies>=3&talent.blessing_of_the_ancients.enabled&buff.blessing_of_anshe.down
	{'Blessing of the Ancients', 'player.area(40).enemies>=3&talent(6,3)&!player.buff(Blessing of An\'she)'},
 	--actions+=/blood_fury,if=buff.celestial_alignment.up||buff.incarnation.up
	{'Blood Fury', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
 	--actions+=/berserking,if=buff.celestial_alignment.up||buff.incarnation.up
	{'Berserking', 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
 	--actions+=/call_action_list,name=fury_of_elune,if=talent.fury_of_elune.enabled&cooldown.fury_of_elune.remains<target.time_to_die
	{FoE, 'talent(7,1)&{cooldown(Fury of Elune).remains<target.time_to_die}'},
 	--actions+=/call_action_list,name=ed,if=equipped.the_emerald_dreamcatcher
	{ED, 'xequipped(137062)'},
 	--actions+=/new_moon,if=(charges=2&recharge_time<5)||charges=3
	{'New Moon', 'cooldown(New Moon).charges<3&cooldown(New Moon).recharge_time<5}||cooldown(New Moon).charges=3'},
 	--actions+=/half_moon,if=(charges=2&recharge_time<5)||charges=3||(target.time_to_die<15&charges=2)
	{'Half Moon', 'cooldown(Half Moon).charges<3&cooldown(Half Moon).recharge_time<5}||cooldown(Half Moon).charges=3||{target.time_to_die<15&cooldown(Half Moon).charges<3}'},
 	--actions+=/full_moon,if=(charges=2&recharge_time<5)||charges=3||target.time_to_die<15
	{'Full Moon', 'cooldown(Full Moon).charges<3&cooldown(Full Moon).recharge_time<5}||cooldown(Full Moon).charges=3||target.time_to_die<15'},
 	--actions+=/stellar_flare,cycle_targets=1,max_cycle_targets=4,if=active_enemies<4&remains<7.2&astral_power>=15
	{'Stellar Flare', 'talent(5,1)&{player.area(30).enemies<4&target.debuff(Stellar Flare).remains<7.2&astral_power>=15}'},
 	--actions+=/moonfire,if=(talent.natures_balance.enabled&remains<3)||(remains<6.6&!talent.natures_balance.enabled)
	{'Moonfire', '{talent(7,3)&target.debuff(Moonfire).remains<3}||{target.debuff(Moonfire).remains<6.6&!talent(7,3)}'},
 	--actions+=/sunfire,if=(talent.natures_balance.enabled&remains<3)||(remains<5.4&!talent.natures_balance.enabled)
	{'Sunfire', '{talent(7,3)&target.debuff(Sunfire).remains<3}||{target.debuff(Sunfire).remains<5.4&!talent(7,3)}'},
 	--actions+=/astral_communion,if=astral_power.deficit>=75
	{'Astral Communion', 'astral_power.deficit>=75'},
 	--actions+=/incarnation,if=astral_power>=40
	{'Incarnation: Chosen of Elune', 'astral_power>=40'},
 	--actions+=/celestial_alignment,if=astral_power>=40
	{'Celestial Alignment', 'astral_power>=40'},
 	--actions+=/starfall,if=buff.oneths_overconfidence.up
	{'Starfall', 'player.buff(Oneth\'s Overconfidence)', 'target.ground'},
 	--actions+=/solar_wrath,if=buff.solar_empowerment.stack=3
	{'Solar Wrath', 'player.buff(Solar Empowerment).stack=3'},
 	--actions+=/lunar_strike,if=buff.lunar_empowerment.stack=3
	{'Lunar Strike', 'player.buff(Lunar Empowerment).stack=3'},
 	--actions+=/call_action_list,name=CA,if=buff.celestial_alignment.up||buff.incarnation.up
	{CA, 'player.buff(Celestial Alignment)||player.buff(Incarnation: Chosen of Elune)'},
 	--actions+=/call_action_list,name=ST
	{ST},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Interrupts = {
	--{'Skull Bash'},
	{'Typhoon', 'talent(4,3)'},
	{'Mighty Bash', 'talent(4,1)'},
}

local Survival = {
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
}

local Cooldowns = {

}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=40'},
	--{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.range<40&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(102, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] DRUID - Balance',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
