local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDEMON HUNTER |cffADFF2FVengeance |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/3 - 3/2 - 4/3 - 5/3 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local XeerX = {
	{'@Xeer.Targeting'},


	-- /cast [@player] Infernal Strike
	-- /cast [@player] Sigil of Flame
	-- /cast [@player] Sigil of Chains
	-- /cast [@player] Sigil of Silence
	-- /cast [@player] Sigil of Misery
	--
	-- /cast [@cursor] Infernal Strike
	-- /cast [@cursor] Sigil of Flame
	-- /cast [@cursor] Sigil of Chains
	-- /cast [@cursor] Sigil of Silence
	-- /cast [@cursor] Sigil of Misery

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
	{'/cast [@cursor] Sigil of Flame', 'keybind(alt)'},
	--{'Sigil of Flame', 'keybind(alt)', 'mouseover.target'},
	{'%pause', 'keybind(lshift)'},
	--{'Metamorphosis', 'keybind(lcontrol)', 'mouseover.target'},
	--{'Infernal Strike', 'keybind(lcontrol)', 'cursor.ground'}
	{'/cast [@cursor] Infernal Strike', 'keybind(lcontrol)'},
}

local Interrupts = {
	{'Arcane Torrent', 'target.range<=8&spell(Consume Magic).cooldown>gcd&!prev_gcd(Consume Magic)'},
	{'Consume Magic'},
}

local ST = {
	--actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
	{'Fiery Brand', '!player.buff(Demon Spikes)&!player.buff(Metamorphosis)'},
	--actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
	{'Demon Spikes', '{spell(Demon Spikes)charges=2||!player.buff(Demon Spikes)}&!target.debuff(Fiery Brand)&!player.buff(Metamorphosis)'},
	--actions+=/empower_wards,if=debuff.casting.up
	{'!Empower Wards', 'target.casting.percent>80'},
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
	{'Sigil of Flame', '!target.debuff(Sigil of Flame)', 'target.ground'},
	--actions+=/spirit_bomb,if=debuff.frailty.down
	{'Spirit Bomb', '!target.debuff(Frailty)&player.buff(Soul Fragments).count>=1'},
	--actions+=/soul_carver,if=dot.fiery_brand.ticking
	{'Soul Carver', 'target.debuff(Fiery Brand)'},
	--actions+=/immolation_aura,if=player.pain<=80
	{'Immolation Aura', 'player.pain<=80'},
	--actions+=/felblade,if=player.pain<=70
	{'Felblade', 'talent(3,1)&player.pain<=70'},
	--actions+=/soul_barrier
	{'Soul Barrier', 'talent(7,3)'},
	--actions+=/soul_cleave,if=soul_fragments=5
	{'Soul Cleave', 'player.buff(Soul Fragments).count=5'},
	--actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>player.health.max*0.70
	{'Metamorphosis', '!player.buff(Demon Spikes)&!target.dot(Fiery Brand).ticking&!player.buff(Metamorphosis)&player.incdmg(5)>=player.health.max*0.70'},
	--actions+=/fel_devastation,if=incoming_damage_5s>player.health.max*0.70
	{'Fel Devastation', 'talent(6,1)&player.incdmg(5)>=player.health.max*0.70'},
	--actions+=/soul_cleave,if=incoming_damage_5s>=player.health.max*0.70
	{'Soul Cleave', 'player.incdmg(5)>=player.health.max*0.70'},
	--actions+=/fel_eruption
	{'Fel Eruption', 'talent(3,3)'},
	--actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
	--{'Sigil of Flame', {'advancedGround', 'totem.duration<=0.3*totem.time'}, 'target.ground'},
	--actions+=/fracture,if=player.pain>=80&soul_fragments<4&incoming_damage_4s<=player.health.max*0.20
	{'Soul Cleave', 'player.pain>=80&player.buff(Soul Fragments).count<4&player.incdmg(4)<=player.health.max*0.20'},
	--actions+=/soul_cleave,if=player.pain>=80
	{'Soul Cleave', 'player.pain>=80'},
	{'Shear', 'player.buff(Blade Turning)'},
	{'Fracture', 'talent(4,2)&player.pain>=60'},
	--actions+=/shear
	{'Shear'}
}

local Ranged = {
	{'Throw Glaive'},
}

local inCombat = {
	{Keybinds},
	--{XeerX, '!target.alive'},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Ranged, 'target.range>8&target.range<=30'},
	{ST, 'target.infront&target.range<=8'}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(581, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] DEMON HUNTER - Vengeance',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
