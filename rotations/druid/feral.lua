local exeOnLoad = function()
	Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
druid="Druid_Feral_T19P"
level=110
race=night_elf
timeofday=day
role=attack
position=back
talents=3323322
artifact=58:137340:137465:137307:0:1153:1:1154:1:1157:1:1158:1:1161:6:1163:3:1164:3:1165:3:1166:3:1327:1
spec=feral

# Gear Summary
# gear_ilvl=843.75
# gear_agility=11083
# gear_stamina=17628
# gear_crit_rating=6220
# gear_haste_rating=2416
# gear_mastery_rating=5871
# gear_versatility_rating=2251
# gear_armor=1957
# set_bonus=tier19p_leather_2pc=1
--]]
}

local Survival = {
-- this was not working in 1.0!! didn't had time to check it yet in 1.5
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&player.health<=75'},
	{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
}

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

local PreCombat = {
	--# Executed before combat begins. Accepts non-harmful actions.only.
	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--{'', ''},
	--actions.precombat+=/food,type=nightborne_delicacy_platter
	--{'', ''},
	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
	--actions.precombat+=/healing_touch,if=talent.bloodtalons.enabled
	--{'', ''},
	--actions.precombat+=/cat_form
	--{'', ''},
	--actions.precombat+=/prowl
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--{'', ''},
	--actions.precombat+=/potion,name=old_war
	--{'', ''},
}

------------------ POOLING ------------------
--106830 - trash
--106785 - swipe
--155625 - moonfire

local Moonfire = {
	--actions.generator+=/Moonfire_cat,cycle_targets=1,if=combo_points<5&remains<=4.2&target.time_to_die-remains>tick_time*2
	{'Moonfire', 'combo_points<5&target.dot(Moonfire).remains<=4.2&target.time_to_die-target.dot(Moonfire).remains>dot(Moonfire).tick_time*2'},
}

local Healing_Touch = {
	{'Healing Touch'},
}
local Elunes_Guidance = {
	{'Elune\'s Guidance'},
}

local Rip = {
	{'Rip'},
}

local Savage_Roar = {
	{'Savage Roar'},
}

local Ferocious_Bite = {
	{'Ferocious Bite'},
}

local Thrash = {
	{'Thrash'},
}

local Swipe = {
	{'Swipe'},
}

------------------ POOLING ------------------

local SBT_Opener = {
	--# Hard-cast a Healing Touch for Bloodtalons buff. Use Dash to re-enter Cat Form.
	--actions.sbt_opener=healing_touch,if=talent.bloodtalons.enabled&combo_points=5&!buff.bloodtalons.up&!dot.rip.ticking
	{Healing_Touch, 'talent(7,2)&combo_points=5&!player.buff(Bloodtalons)&!target.dot(Rip).ticking'},
	--# Force use of Tiger's Fury before applying Rip.
	--actions.sbt_opener+=/tigers_fury,if=!dot.rip.ticking&combo_points=5
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combo_points=5'},
}

local Cooldowns = {
	--# Executed every time the actor is available.
	--actions.dash,if=!buff.cat_form.up
	--{'', ''},
	--actions.=/cat_form
	--{'', ''},
	--actions.=/wild_charge
	--{'', ''},
	--actions.=/displacer_beast,if=movement.distance>10
	--{'', ''},
	--actions.=/dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
	--{'', ''},
	--actions.=/rake,if=buff.prowl.up||buff.shadowmeld.up
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)'},
	--actions.=/berserk,if=buff.tigers_fury.up
	{'Berserk', 'player.buff(Tiger\'s Fury)'},
	--actions.=/incarnation,if=cooldown.tigers_fury.remains<gcd
	{'Incarnation: King of the Jungle', 'talent(5,2)&{cooldown(Tiger\'s Fury).remains<gcd}'},
	--actions.=/use_item,slot=trinket2,if=(buff.tigers_fury.up&(target.time_to_die>trinket.stat.any.cooldown||target.time_to_die<45))||buff.incarnation.remains>20
	--{'', ''},
	--actions.=/potion,name=old_war,if=((buff.berserk.remains>10||buff.incarnation.remains>20)&(target.time_to_die<180||(trinket.proc.all.react&target.health.pct<25)))||target.time_to_die<=40
	--{'', ''},
	--actions.=/tigers_fury,if=(!buff.clearcasting.react&energy.deficit>=60)||energy.deficit>=80||(t18_class_trinket&buff.berserk.up&buff.tigers_fury.down)
	{'Tiger\'s Fury', '{!player.buff(Clearcasting).react&energy.deficit>=60}||energy.deficit>=80'},--t18_class_trinket ?
	--actions.=/incarnation,if=energy.time_to_max>1&energy>=35
	{'Incarnation: King of the Jungle', 'talent(5,2)&{energy.time_to_max>1&energy>=35}'},
	--# Keep Rip from falling off during execute range.
	--actions.=/ferocious_bite,cycle_targets=1,if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>3&(target.health.pct<25||talent.sabertooth.enabled)
	{Ferocious_Bite, 'target.dot(Rip).ticking&target.dot(Rip)remains<3&target.time_to_die>3&{target.health<25||talent(6,1)}'},
	--# Use Healing Touch at 5 Combo Points, if Predatory Swiftness is about to fall off, at 2 Combo Points before Ashamane's Frenzy, before Elune's Guidance is cast or before the Elune's Guidance buff gives you a 5th Combo Point.
	--actions.=/healing_touch,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&(combo_points>=5||buff.predatory_swiftness.remains<1.5||(talent.bloodtalons.enabled&combo_points=2&buff.bloodtalons.down&cooldown.ashamanes_frenzy.remains<gcd)||(talent.elunes_guidance.enabled&((cooldown.elunes_guidance.remains<gcd&combo_points=0)||(buff.elunes_guidance.up&combo_points>=4))))
	{Healing_Touch, 'talent(7,2)&player.buff(Predatory Swiftness)&{combo_points>=5||player.buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combo_points=2&!player.buff(Bloodtalons)&cooldown(Ashamane\'s Frenzy).remains<gcd}||{talent(6,3)&{{cooldown(Elune\'s Guidance).remains<gcd&combo_points=0}}}}'},
	--actions.=/call_action_list,name=sbt_opener,if=talent.sabertooth.enabled&time<20
	{SBT_Opener, 'talent(6,1)&player.combat.time<20'},
	--# Special logic for Ailuro Pouncers legendary.
	--actions.=/healing_touch,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&buff.predatory_swiftness.stack>1&buff.bloodtalons.down
	{Healing_Touch, 'equipped(137024)&talent(7,2)&player.buff(Predatory Swiftness).stack>1&!player.buff(Bloodtalons)'},
}

local Finisher = {
	--# Use Savage Roar if it's expired and you're at 5 combo points or are about to use Brutal Slash
	--actions.finisher=pool_resource,for_next=1
	--actions.finisher+=/savage_roar,if=!buff.savage_roar.up&(combo_points=5||(talent.brutal_slash.enabled&spell_targets.brutal_slash>desired_targets&action.brutal_slash.charges>0))
	--{Savage_Roar, 'talent(5,3)&{!player.buff(Savage Roar)&{combo_points=5||talent(7,1)&action(Brutal Slash).charges>0}}'},
	{Savage_Roar, '{!player.buff(Savage Roar)&player.combo_points=5}||!player.buff(Savage Roar)&{talent(7,1)&action(Brutal Slash).charges>0}&talent(5,2)}}'},
	--# Thrash has higher priority than finishers at 5 targets
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/Thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.Thrash_cat>=5
	{Thrash, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=5'},
	--# Replace Rip with Swipe at 8 targets
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/Swipe_cat,if=spell_targets.Swipe_cat>=8
	{Swipe, 'player.area(8).enemies>=6'},
	--# Refresh Rip at 8 seconds or for a stronger Rip
	--actions.finisher+=/rip,cycle_targets=1,if=(!ticking||(remains<8&target.health.pct>25&!talent.sabertooth.enabled)||persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die-remains>tick_time*4&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||buff.clearcasting.react||talent.soul_of_the_forest.enabled||!dot.rip.ticking||(dot.rake.remains<1.5&spell_targets.Swipe_cat<6))
	--{Rip, '{!target.dot(Rip).ticking||{target.dot(Rip).remains<8&target.health>25&!talent(6,1)}}&target.time_to_die-target.dot(Rip).remains>dot(Rip).tick_time*4&&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting).react}||talent(5,1)||!target.dot(Rip).ticking||{target.dot(Rake).remains<1.5&player.area(8).enemies<6}}'},
	{Rip, '{!target.debuff(Rip)||{target.debuff(Rip).duration<8&target.health>25&!talent(6,1)}}&{target.ttd>8&player.combo_points=5}&{player.energydiff<20||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.buff(Elune\'s Guidance)||spell(Tiger\'s Fury).cooldown<3||player.buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5}}'},
	--# Refresh Savage Roar early with Jagged Wounds
	--actions.finisher+=/savage_roar,if=(buff.savage_roar.remains<=10.5||(buff.savage_roar.remains<=7.2&!talent.jagged_wounds.enabled))&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||buff.clearcasting.react||talent.soul_of_the_forest.enabled||!dot.rip.ticking||(dot.rake.remains<1.5&spell_targets.Swipe_cat<6))
	--{Savage_Roar, 'talent(5,3)&{player.buff(Savage Roar).remains<=7.2&combo_points=5&{combo_points=5||energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting).react}||!target.dot(Rip).ticking||{target.dot(Rake).remains<1.5&player.area(8).enemies<6}}}'},
	{Savage_Roar, '{{player.buff(Savage Roar).duration<=10.5&talent(6,2)}||{player.buff(Savage Roar).duration<=7.2&!talent(6,2)}}&{player.combo_points>=5}&{player.energydiff<20||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||player.buff(Elune\'s Guidance)||spell(Tiger\'s Fury).cooldown<3||player.buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5}}'},
	--# Replace FB with Swipe at 6 targets for Bloodtalons or 3 targets otherwise.
	--actions.finisher+=/Swipe_cat,if=combo_points=5&(spell_targets.Swipe_cat>=6||(spell_targets.Swipe_cat>=3&!talent.bloodtalons.enabled))&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||(talent.moment_of_clarity.enabled&buff.clearcasting.react))
	{Swipe, 'combo_points=5&{player.area(8).enemies>=6||{player.area(8).enemies>=3&!talent(7,2)}}&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting).react}}'},
	-- custom FB
	{Ferocious_Bite, 'combo_points=5&{player.buff(Savage Roar).remains>=17.2&target.dot(Rip).remains>=18}'},
	--actions.finisher+=/ferocious_bite,player.max_energy=1,cycle_targets=1,if=combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||(talent.moment_of_clarity.enabled&buff.clearcasting.react))
	{Ferocious_Bite, 'combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting).react}}'},
	--TODO: set_bonus.tier18_4pc
}



local Generator = {
	--# Brutal Slash if there's adds up
	--actions.generator=brutal_slash,if=spell_targets.brutal_slash>desired_targets&combo_points<5
	{'Brutal Slash', 'talent(7,1)&combo_points<5'},
	--actions.generator+=/ashamanes_frenzy,if=combo_points<=2&buff.elunes_guidance.down&(buff.bloodtalons.up||!talent.bloodtalons.enabled)&(buff.savage_roar.up||!talent.savage_roar.enabled)
	{'Ashamane\'s Frenzy', 'combo_points<=2&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}'},
	--# Pool energy for Elune's Guidance when it's coming off cooldown.
	--actions.generator+=/pool_resource,if=talent.elunes_guidance.enabled&combo_points=0&energy<action.ferocious_bite.cost+25-energy.regen*cooldown.elunes_guidance.remains
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&energy>=action(Ferocious Bite).cost+25-energy.regen*cooldown(Elune\'s Guidance).remains}'},
	--actions.generator+=/elunes_guidance,if=talent.elunes_guidance.enabled&combo_points=0&energy>=action.ferocious_bite.cost+25
	{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&energy>=action(Ferocious Bite).cost+25}'},
	--# Spam Thrash over Rake or Moonfire at 9 targets with Brutal Slash talent.
	--actions.generator+=/Thrash_cat,if=talent.brutal_slash.enabled&spell_targets.Thrash_cat>=9
	{'Thrash', 'talent(7,1)&player.area(8).enemies>=9'},
	--# Use Swipe over Rake or Moonfire at 6 targets.
	--actions.generator+=/Swipe_cat,if=spell_targets.Swipe_cat>=6
	{'Swipe', 'player.area(8).enemies>=6'},
	--# Shadowmeld to buff Rake
	--actions.generator+=/shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up||!talent.bloodtalons.enabled)&(!talent.incarnation.enabled||cooldown.incarnation.remains>18)&!buff.incarnation.up
	--{'', ''},
	--# Refresh Rake early with Bloodtalons
	--actions.generator+=/rake,if=combo_points<5&(!ticking||(!talent.bloodtalons.enabled&remains<duration*0.3)||(talent.bloodtalons.enabled&buff.bloodtalons.up&(!talent.soul_of_the_forest.enabled&remains<=7||remains<=5)))&target.time_to_die-remains>tick_time
	{'Rake', 'combo_points<5&{!target.dot(Rake).ticking||{!talent(7,2)&target.dot(Rake).remains<target.dot(Rake).duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&target.dot(Rake).remains<=7||target.dot(Rake).remains<=5}}}&target.time_to_die-target.dot(Rake).remains>dot(Rake).tick_time'},
	{Moonfire, 'talent(1,3)&!prev_gcd(Moonfire)'},
	--actions.generator+=/Thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.Swipe_cat>=2
	{'Thrash', 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=2'},
	--# Brutal Slash if you would cap out charges before the next adds spawn
	--actions.generator+=/brutal_slash,if=combo_points<5&((raid_event.adds.exists&raid_event.adds.in>(1+max_charges-charges_fractional)*15)||(!raid_event.adds.exists&(charges_fractional>2.66&time>10)))
	--{'Brutal Slash', 'combo_points<5&{{}}'},
	--actions.generator+=/Swipe_cat,if=combo_points<5&spell_targets.Swipe_cat>=3
	{'Swipe', 'combo_points<5&player.area(8).enemies>=3'},
	--actions.generator+=/shred,if=combo_points<5&(spell_targets.Swipe_cat<3||talent.brutal_slash.enabled)
	{'Shred', 'combo_points<5&{player.area(8).enemies<3||talent(7,1)}'},
}

local xCombat = {
	--actions.=/call_action_list,name=finisher
	{Finisher},
	--actions.=/call_action_list,name=generator
	{Generator},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	--{_Xeer},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
  {Survival, 'player.health<100'},
	{'Cat Form', 'form~=2'},
	{Cooldowns, 'toggle(cooldowns)'},
	{xCombat, 'target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(103, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Druid - Feral', inCombat, outCombat,exeOnLoad)
