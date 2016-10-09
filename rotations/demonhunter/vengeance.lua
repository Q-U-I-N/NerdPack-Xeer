local GUI = {
}

local exeOnLoad = function()
	Xeer.Splash()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEMON HUNTER |cffADFF2FVengeance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {
	-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

--[[
demonhunter='Demon_Hunter_Vengeance_T19P'
level=110
race=night_elf
timeofday=night
role=tank
position=front
talents=3323313
artifact=60:0:0:0:0:1096:1:1098:1:1099:1:1228:1:1229:3:1230:3:1231:3:1234:3:1236:1:1328:1:1434:1
spec=vengeance

# Gear Summary
# gear_ilvl=826.25
# gear_agility=8531
# gear_stamina=14978
# gear_crit_rating=9245
# gear_haste_rating=834
# gear_mastery_rating=1733
# gear_versatility_rating=4695
# gear_armor=1830
--]]
}

local Keybinds = {
	{'%pause', 'keybind(alt)'},
	{'Sigil of Flame', 'keybind(lshift)', 'mouseover.ground'},
	--{'Metamorphosis', 'keybind(lcontrol)', 'mouseover.ground'},
	{'Infernal Strike', 'keybind(lcontrol)', 'mouseover.ground'}
}

local Interrupts = {
	{'Arcane Torrent', 'target.range<=8&spell(Consume Magic).cooldown>1&!prev_gcd(Consume Magic)'},
	{'Consume Magic'},
}

local ST = {
	--actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
	{'Fiery Brand', '!buff(Demon Spikes)&!buff(Metamorphosis)'},
	--actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
	{'Demon Spikes', '{spell(Demon Spikes)charges=2||!buff(Demon Spikes)}&!target.debuff(Fiery Brand)&!buff(Metamorphosis)'},
	--actions+=/empower_wards,if=debuff.casting.up
	{'!Empower Wards', 'target.casting.percent>80'},
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
	{'Sigil of Flame', '!target.debuff(Sigil of Flame)', 'target.ground'},
	--actions+=/spirit_bomb,if=debuff.frailty.down
	{'Spirit Bomb', '!prev_gcd(Spirit Bomb)&!target.debuff(Frailty)&buff(Soul Fragments).count>=1'},
	--actions+=/soul_carver,if=dot.fiery_brand.ticking
	{'Soul Carver', 'target.debuff(Fiery Brand)'},
	--actions+=/immolation_aura,if=pain<=80
	{'Immolation Aura', 'pain<=80'},
	--actions+=/felblade,if=pain<=70
	{'Felblade', 'talent(3,1)&pain<=70'},
	--actions+=/soul_barrier
	{'Soul Barrier', 'talent(7,3)'},
	--actions+=/soul_cleave,if=soul_fragments=5
	{'Soul Cleave', 'buff(Soul Fragments).count=5'},
	--actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
	{'Metamorphosis', '!buff(Demon Spikes)&!target.dot(Fiery Brand).ticking&!buff(Metamorphosis)&incdmg(5)>=health.max*0.70'},
	--actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
	{'Fel Devastation', 'talent(6,1)&incdmg(5)>=health.max*0.70'},
	--actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
	{'Soul Cleave', 'incdmg(5)>=health.max*0.70'},
	--actions+=/fel_eruption
	{'Fel Eruption', 'talent(3,3)'},
	--actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
	--{'Sigil of Flame', {'advancedGround', 'totem.duration<=0.3*totem.time'}, 'target.ground'},
	--actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
	{'Soul Cleave', 'pain>=80&buff(Soul Fragments).count<4&incdmg(4)<=health.max*0.20'},
	--actions+=/soul_cleave,if=pain>=80
	{'Soul Cleave', 'pain>=80'},
	{'Shear', 'buff(Blade Turning)'},
	{'Fracture', 'talent(4,2)&pain>=60'},
	--actions+=/shear
	{'Shear'}
}

local xCombat = {
	{'Soul Carver'},
	{'Fel Devastation', 'talent(6,1)&incdmg(5)>=health.max*0.70'},
	{'Soul Cleave', 'pain>=80'},
	{'Immolation Aura', 'pain<=80'},
	{'Felblade', 'talent(3,1)&pain<=80'},
	{'Fel Eruption', 'talent(3,3)'},
	{'Spirit Bomb', '!prev_gcd(Spirit Bomb)&!target.debuff(Frailty)&buff(Soul Fragments).count>=1'},
	{'Shear', 'buff(Blade Turning)'},
	{'Fracture', 'talent(4,2)&pain>=60'},
	{'Sigil of Flame', 'target.ground'},
	--actions+=/shear
	{'Shear'}
}

local Ranged = {
	{'Throw Glaive'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(40)'},
	{Ranged, 'target.range>8&target.range<=30'},
	{ST, 'target.infront&target.range<=8'}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(581, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] DEMON HUNTER - Vengeance', inCombat, outCombat, exeOnLoad, GUI)
