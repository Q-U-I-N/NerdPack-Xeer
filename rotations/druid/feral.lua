local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDRUID |cffADFF2FFeral |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

------------------ POOLING START ------------------
local Bear_Heal = {
	{'Bear Form', 'form~=1'},
	{'Frenzied Regeneration'},
}

local Regrowth = {
	{'!Regrowth'},
}

local Moonfire = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Moonfire'},
}

local Rake = {
	{'%pause', 'player.energy<35&!player.buff(Clearcasting)'},
	{'Rake'},
}
local Rip = {
	{'%pause', 'player.energy<30&!player.buff(Clearcasting)'},
	{'Rip'},
}

local Savage_Roar = {
	{'%pause', 'player.energy<40&!player.buff(Clearcasting)'},
	{'Savage Roar'},
}

local Ferocious_Bite = {
	{'%pause', 'player.energy<25&!player.buff(Clearcasting)'},
	{'Ferocious Bite'},
}

local Thrash = {
	{'%pause', 'player.energy<50&!player.buff(Clearcasting)'},
	{'Thrash'},
}

local Swipe = {
	{'%pause', 'player.energy<45&!player.buff(Clearcasting)'},
	{'Swipe'},
}

------------------ POOLING END ------------------

local PreCombat = {
	{'Travel Form', '!indoors&!player.buff(Travel Form)&!player.buff(Prowl)&{!target.enemy||target.enemy&!target.alive}'},
	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--{'', ''},
	--actions.precombat+=/food,type=nightborne_delicacy_platter
	--{'', ''},
	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
	--actions.precombat+=/Regrowth,if=talent.bloodtalons.enabled
	{Regrowth, 'talent(7,2)&target.enemy&target.alive&!player.buff(Prowl)&!prev(Regrowth)&player.buff(Bloodtalons).stack<2'},
	--actions.precombat+=/cat_form
	{'Cat Form', '!player.buff(Cat Form)&!player.buff(Travel Form)'},
	--actions.precombat+=/prowl
 	{'Prowl', '!player.buff(Prowl)&target.enemy&target.alive'},
 	{'Rake', 'player.buff(Prowl)&target.range<5&target.infront'},
	--actions.precombat+=/potion,name=old_war
	--{'', ''},
}

local SBT_Opener = {
	--# Hard-cast a Regrowth for Bloodtalons buff. Use Dash to re-enter Cat Form.
	--actions.sbt_opener=Regrowth,if=talent.bloodtalons.enabled&combo_points=5&!buff.bloodtalons.up&!dot.rip.ticking
	{Regrowth, 'talent(7,2)&combo_points=5&!player.buff(Bloodtalons)&!target.dot(Rip).ticking'},
	--# Force use of Tiger's Fury before applying Rip.
	--actions.sbt_opener+=/tigers_fury,if=!dot.rip.ticking&combo_points=5
	{'Tiger\'s Fury', '!target.dot(Rip).ticking&combo_points=5'},
}

local Cooldowns = {
	--actions.dash,if=!buff.cat_form.up
	--actions.=/wild_charge
	--actions.=/displacer_beast,if=movement.distance>10
	--actions.=/dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
	--actions.=/rake,if=buff.prowl.up||buff.shadowmeld.up
	{'Rake', 'player.buff(Prowl)||player.buff(Shadowmeld)'},
	--actions.=/berserk,if=buff.tigers_fury.up
	{'Berserk', 'player.buff(Tiger\'s Fury)'},
	--actions.=/incarnation,if=cooldown.tigers_fury.remains<gcd
	{'Incarnation: King of the Jungle', 'talent(5,2)&{cooldown(Tiger\'s Fury).remains<gcd}'},
	--actions+=/use_item,slot=finger1,if=(buff.tigers_fury.up&(target.time_to_die>trinket.stat.any.cooldown|target.time_to_die<45))|buff.incarnation.remains>20
	--actions+=/potion,name=old_war,if=((buff.berserk.remains>10|buff.incarnation.remains>20)&(target.time_to_die<180|(trinket.proc.all.react&target.health.pct<25)))|target.time_to_die<=40
	--actions.=/tigers_fury,if=(!buff.clearcasting.up&energy.deficit>=60)||energy.deficit>=80||(t18_class_trinket&buff.berserk.up&buff.tigers_fury.down)
	{'Tiger\'s Fury', '{!player.buff(Clearcasting)&energy.deficit>=60}||energy.deficit>=80'},
	--actions.=/incarnation,if=energy.time_to_max>1&player.energy>=35
	{'Incarnation: King of the Jungle', 'talent(5,2)&{energy.time_to_max>1&player.energy>=35}'},
	--actions.=/ferocious_bite,cycle_targets=1,if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>3&(target.health.pct<25||talent.sabertooth.enabled)
	{Ferocious_Bite, 'target.dot(Rip).ticking&target.dot(Rip)remains<3&target.time_to_die>3&{target.health<25||talent(6,1)}'},
	--actions.=/Regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&(combo_points>=5||buff.predatory_swiftness.remains<1.5||(talent.bloodtalons.enabled&combo_points=2&buff.bloodtalons.down&cooldown.ashamanes_frenzy.remains<gcd)||(talent.elunes_guidance.enabled&((cooldown.elunes_guidance.remains<gcd&combo_points=0)||(buff.elunes_guidance.up&combo_points>=4))))
	{Regrowth, 'talent(7,2)&player.buff(Predatory Swiftness)&{combo_points>=5||player.buff(Predatory Swiftness).remains<1.5||{talent(7,2)&combo_points=2&!player.buff(Bloodtalons)&cooldown(Ashamane\'s Frenzy).remains<gcd}}'},
	--actions.=/call_action_list,name=sbt_opener,if=talent.sabertooth.enabled&time<20
	{SBT_Opener, 'talent(6,1)&xtime<20'},
	--# Special logic for Ailuro Pouncers legendary.
	--actions.=/Regrowth,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&buff.predatory_swiftness.stack>1&buff.bloodtalons.down
	{Regrowth, 'equipped(137024)&talent(7,2)&player.buff(Predatory Swiftness).stack>1&!player.buff(Bloodtalons)'},
}

local Finisher = {
	--actions.finisher=pool_resource,for_next=1
	--actions.finisher+=/savage_roar,if=!buff.savage_roar.up&(combo_points=5||(talent.brutal_slash.enabled&spell_targets.brutal_slash>desired_targets&action.brutal_slash.charges>0))
	{Savage_Roar, 'talent(5,3)&{!player.buff(Savage Roar)&{combo_points=5||talent(7,1)&action(Brutal Slash).charges>0}}'},
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/Thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.Thrash_cat>=5
	{Thrash, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=5'},
	--actions.finisher+=/pool_resource,for_next=1
	--actions.finisher+=/Swipe_cat,if=spell_targets.Swipe_cat>=8
	{Swipe, 'player.area(8).enemies>=8'},
	--actions.finisher+=/rip,cycle_targets=1,if=(!ticking||(remains<8&target.health.pct>25&!talent.sabertooth.enabled)||persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die-remains>tick_time*4&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||buff.clearcasting.up||talent.soul_of_the_forest.enabled||!dot.rip.ticking||(dot.rake.remains<1.5&spell_targets.Swipe_cat<6))
	{Rip, '{!target.dot(Rip).ticking||{target.dot(Rip).remains<8&target.health>25&!talent(6,1)}||persistent_multiplier(Rip)>dot(Rip).pmultiplier}&{target.time_to_die-target.dot(Rip).remains>dot(Rip).tick_time*4&combo_points=5}&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}||talent(5,1)||!target.dot(Rip).ticking||{target.dot(Rake).remains<1.5&player.area(8).enemies<6}}'},
	--actions.finisher+=/savage_roar,if=(buff.savage_roar.remains<=10.5||(buff.savage_roar.remains<=7.2&!talent.jagged_wounds.enabled))&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||buff.clearcasting.up||talent.soul_of_the_forest.enabled||!dot.rip.ticking||(dot.rake.remains<1.5&spell_targets.Swipe_cat<6))
	{Savage_Roar, 'talent(5,3)&{{{player.buff(Savage Roar).duration<=10.5&talent(6,2)}||{player.buff(Savage Roar).duration<=7.2&!talent(6,2)}}&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||player.buff(Clearcasting)||talent(5,1)||!target.debuff(Rip)||{target.debuff(Rake).duration<1.5&player.area(8).enemies<6}}}'},
	--actions.finisher+=/Swipe_cat,if=combo_points=5&(spell_targets.Swipe_cat>=6||(spell_targets.Swipe_cat>=3&!talent.bloodtalons.enabled))&combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||(talent.moment_of_clarity.enabled&buff.clearcasting.up))
	{'Swipe', 'combo_points=5&{player.area(8).enemies>=6||{player.area(8).enemies>=3&!talent(7,2)}}&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}}'},
	--actions.finisher+=/ferocious_bite,max_energy=1,cycle_targets=1,if=combo_points=5&(energy.time_to_max<1||buff.berserk.up||buff.incarnation.up||buff.elunes_guidance.up||cooldown.tigers_fury.remains<3||set_bonus.tier18_4pc||(talent.moment_of_clarity.enabled&buff.clearcasting.up))
	{'Ferocious Bite', 'energy.deficit=0&combo_points=5&{energy.time_to_max<1||player.buff(Berserk)||player.buff(Incarnation: King of the Jungle)||cooldown(Tiger\'s Fury).remains<3||{talent(7,3)&player.buff(Clearcasting)}}'},
}

local Generator = {
	--actions.generator=brutal_slash,if=spell_targets.brutal_slash>desired_targets&combo_points<5
	{'Brutal Slash', 'talent(7,1)&combo_points<5'},
	--actions.generator+=/ashamanes_frenzy,if=combo_points<=2&buff.elunes_guidance.down&(buff.bloodtalons.up||!talent.bloodtalons.enabled)&(buff.savage_roar.up||!talent.savage_roar.enabled)
	{'!Ashamane\'s Frenzy', 'combo_points<=2&toggle(cooldowns)&{player.buff(Bloodtalons)||!talent(7,2)}&{player.buff(Savage Roar)||!talent(5,3)}'},
	--actions.generator+=/pool_resource,if=talent.elunes_guidance.enabled&combo_points=0&energy<action.ferocious_bite.cost+25-energy.regen*cooldown.elunes_guidance.remains
	--{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&player.energy<action(Ferocious Bite).cost+25-energy.regen*cooldown(Elune\'s Guidance).remains}'},
	--actions.generator+=/elunes_guidance,if=talent.elunes_guidance.enabled&combo_points=0&player.energy>=action.ferocious_bite.cost+25
	--{'Elune\'s Guidance', 'talent(6,3)&{combo_points=0&player.energy>=action(Ferocious Bite).cost+25}'},
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/Thrash_cat,if=talent.brutal_slash.enabled&spell_targets.Thrash_cat>=9
	{Thrash, 'talent(7,1)&player.area(8).enemies>=9'},
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/Swipe_cat,if=spell_targets.Swipe_cat>=6
	{Swipe, 'player.area(8).enemies>=6'},
	--actions.generator+=/shadowmeld,if=combo_points<5&player.energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up||!talent.bloodtalons.enabled)&(!talent.incarnation.enabled||cooldown.incarnation.remains>18)&!buff.incarnation.up
	--{'', ''},
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/rake,if=combo_points<5&(!ticking||(!talent.bloodtalons.enabled&remains<duration*0.3)||(talent.bloodtalons.enabled&buff.bloodtalons.up&(!talent.soul_of_the_forest.enabled&remains<=7||remains<=5)&persistent_multiplier>dot.rake.pmultiplier*0.80))&target.time_to_die-remains>tick_time
	{Rake, 'combo_points<5&{!target.dot(Rake).ticking||{!talent(7,2)&target.dot(Rake).remains<target.dot(Rake).duration*0.3}||{talent(7,2)&player.buff(Bloodtalons)&{!talent(5,1)&target.dot(Rake).remains<=7||target.dot(Rake).remains<=5}&persistent_multiplier(Rake)>dot(Rake).pmultiplier*0.80}}&target.time_to_die-target.dot(Rake).remains>dot(Rake).tick_time'},
	--actions.generator+=/moonfire_cat,cycle_targets=1,if=combo_points<5&remains<=4.2&target.time_to_die-remains>tick_time*2
	{Moonfire, 'talent(1,3)&combo_points<5&target.dot(Moonfire).remains<=4.2&target.time_to_die-target.dot(Moonfire).remains>dot(Moonfire).tick_time*2'},
	--actions.generator+=/pool_resource,for_next=1
	--actions.generator+=/Thrash_cat,cycle_targets=1,if=remains<=duration*0.3&spell_targets.Swipe_cat>=2
	{Thrash, 'target.dot(Thrash).remains<=target.dot(Thrash).duration*0.3&player.area(8).enemies>=2'},
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

local Interrupts = {
	{'Skull Bash'},
	{'Typhoon', 'talent(4,3)&cooldown(Skull Bash).remains>gcd'},
	{'Mighty Bash', 'talent(4,1)&cooldown(Skull Bash).remains>gcd'},
}

local Survival = {
	{Bear_Heal, 'talent(3,2)&player.incdmg(5)>player.health.max*0.20&!player.buff(Frenzied Regeneration)'},
	--{'/run CancelShapeshiftForm()', 'form>0&talent(3,3)&!player.buff(Rejuvenation)'},
	--{'Rejuvenation', 'talent(3,3)&!player.buff(Rejuvenation)', 'player'},
	{'/run CancelShapeshiftForm()', 'cooldown(Swiftmend)up.&form>0&talent(3,3)&player.health<=75'},
	{'Swiftmend', 'talent(3,3)&player.health<=75', 'player'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(43)&toggle(interrupts)&target.infront&target.range<=8'},
  {Survival, 'player.health<100'},
	{'Cat Form', '!player.buff(Frenzied Regeneration)&{!player.buff(Cat Form)&{!player.buff(Travel Form)||player.area(8).enemies>=1}}'},
	{Cooldowns, '!player.buff(Frenzied Regeneration)&toggle(cooldowns)'},
	{Moonfire, 'talent(1,3)&target.range>8&target.range<=40&target.infront&!player.buff(Prowl)&!target.debuff(Moonfire)'},
	{xCombat, '!player.buff(Frenzied Regeneration)&target.range<8&target.infront'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(103, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] DRUID - Feral',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
