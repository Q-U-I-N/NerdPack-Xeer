local GUI = {

}

local exeOnLoad = function()
	--Xeer.Splash()
end

local Keybinds = {
	{'%pause', 'keybind(alt)'},
	{'Sigil of Flame', 'keybind(lshift)', 'mouseover.ground'},
	{'Metamorphosis', 'keybind(lcontrol)', 'mouseover.ground'}
}

local Interrupts = {
	{'Consume Magic'},
}

local ST = {
	--actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
	{'Fiery Brand', {'!player.buff(Demon Spikes)', '!player.buff(Metamorphosis)'}},
	--actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
	{'Demon Spikes', {'spell.charges=2', 'or', 'player.buff(Demon Spikes)', '!target.debuff(Fiery Brand)', '!player.buff(Metamorphosis)'}},
	--actions+=/empower_wards,if=debuff.casting.up
	{'Empower Wards', 'target.debuff(Casting)'},
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
	--actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
	--actions+=/spirit_bomb,if=debuff.frailty.down
	{'Spirit Bomb', '!target.debuff(Frailty)'},
	--actions+=/soul_carver,if=dot.fiery_brand.ticking
	{'Soul Carver', 'target.debuff(Fiery Brand)'},
	--actions+=/immolation_aura,if=pain<=80
	{'Immolation Aura', 'player.pain<=80'},
	--actions+=/felblade,if=pain<=70
	{'Felblade', 'player.pain<=70'},
	--actions+=/soul_barrier
	{'Soul Barrier'},
	--actions+=/soul_cleave,if=soul_fragments=5
	{'Soul Cleave', 'player.buff(Soul Fragments).count=5'},
	{{
		--actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
		{'Metamorphosis', {'advancedGround','!player.buff(Demon Spikes)','!target.debuff(Fiery Brand)','!player.buff'}, 'target.ground'},
		--actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
		{'Fel Devastation'},
		--actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
		{'Soul Cleave'}
	}, 'player.incdmg(5)>=health.max*0.70'},
	--actions+=/fel_eruption
	{'Fel Eruption'},
	--actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
	--{'Sigil of Flame', {'advancedGround', 'totem.duration<=0.3*totem.time'}, 'target.ground'},
	--actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
	{'Soul Cleave', {'player.pain>=80', 'player.buff(Soul Fragments).count<4', 'player.incdmg(4)<=player.maxhealth*0.20'}},
	--actions+=/soul_cleave,if=pain>=80
	{'Soul Cleave', 'player.pain>=80'},
	--actions+=/shear
	{'Shear'}
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(40)'},
	{ST, 'target.infront'}
}

local outCombat = {
	--actions.precombat=flask,type=flask_of_the_seventh_demon
	--actions.precombat+=/food,type=the_hungry_magister
	--actions.precombat+=/augmentation,type=defiled
	--# Snapshot raid buffed stats before combat begins and pre-potting is done.
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/potion,name=unbending_potion
}

NeP.Engine.registerRotation(581, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Demon Hunter - Vengeance', inCombat, outCombat, exeOnLoad, GUI)