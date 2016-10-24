local _, Xeer = ...

local exeOnLoad = function()
	Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FGuardian |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/3')
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
	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--actions.precombat+=/food,type=azshari_salad
	--actions.precombat+=/bear_form
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
}

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

local Survival = {
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	--{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
	--actions+=/barkskin
	{'Barkskin'},
	--actions+=/bristling_fur,if=buff.ironfur.remains<2&rage<40
	{'Bristling Fur', 'player.buff(Ironfur).remains<2&player.rage<40'},
	{'Mark of Ursol', '!player.buff(Mark of Ursol)&player.incdmg_magic(100)>0'},
	--actions+=/ironfur,if=buff.ironfur.down|rage.deficit<25
	{'Ironfur', '!player.buff(Ironfur)&player.incdmg_phys(100)>0}'},
	--actions+=/frenzied_regeneration,if=!ticking&incoming_damage_6s/health.max>0.25+(2-charges_fractional)*0.15
	{'Frenzied Regeneration', '!player.buff(Frenzied Regeneration)&player.incdmg(6)/player.health.max>{0.25+{2-cooldown(Frenzied Regeneration).charges}*0.15}'},
	--	if not BuffPresent(frenzied_regeneration_buff) and IncomingDamage(6) / MaxHealth() > 0.25 + { 2 - Charges(frenzied_regeneration count=0) } * 0.15 Spell(frenzied_regeneration)
}

local Cooldowns = {
 	--actions+=/blood_fury
	{'Bloodfury'},
 	--actions+=/berserking
	{'Berserking'},
 	--actions+=/use_item,slot=trinket2
	--{'', ''},
}

local xCombat = {
 	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.down
	{'Pulverize', 'talent(7,3)&!player.buff(Pulverize)'},
 	--actions+=/mangle
	{'Mangle'},
 	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.remains<gcd
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<gcd'},
 	--actions+=/lunar_beam
	{'Lunar Beam'},
 	--actions+=/incarnation
	{'Incarnation: Guardian of Ursoc'},
 	--actions+=/thrash_bear,if=active_enemies>=2
	{'Thrash', 'player.area(8).enemies>=2'},
 	--actions+=/pulverize,cycle_targets=1,if=buff.pulverize.remains<3.6
	{'Pulverize', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
 	--actions+=/thrash_bear,if=talent.pulverize.enabled&buff.pulverize.remains<3.6
	{'Thrash', 'talent(7,3)&player.buff(Pulverize).remains<3.6'},
 	--actions+=/moonfire,cycle_targets=1,if=!ticking
	{'Moonfire', '!target.dot(Moonfire).ticking||target.dot(Moonfire).remains<=gcd'},
	{'Maul', 'rage.deficit<=20'},
	{'Swipe'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	--{"Mark of Ursol", "player.health<=90&target.casting&!player.buff(Mark of Ursol)"},
	{'Mark of Ursol', '!player.buff(Mark of Ursol)&player.incdmg_magic(2)>0'},
	--actions+=/ironfur,if=buff.ironfur.down|rage.deficit<25
	{'Ironfur', '!player.buff(Ironfur)&player.incdmg_phys(2)>0'},
}

local inCombatx = {
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{'Bear Form', 'form~=1'},
	{xCombat, 'target.range<8&target.infront'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(104, '[|cff'..Xeer.addonColor..'Xeer|r] DRUID - Guardian', inCombat, outCombat, exeOnLoad)
