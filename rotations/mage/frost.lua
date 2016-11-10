local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rMAGE |cffADFF2FFrost |r')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 1 : RoF+IN+CS|r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/1 - 3/2 - 4/1 - 5/1 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |cffADFF2FVERSION 2 : BC+FT+TV |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/3 - 2/1 - 3/2 - 4/2 - 5/1 - 6/1 - 7/1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local PreCombat = {
	--actions.precombat=flask,type=flask_of_the_whispered_pact
	--actions.precombat+=/food,type=azshari_salad
	--actions.precombat+=/augmentation,type=defiled
	--actions.precombat+=/water_elemental
	{'Summon Water Elemental', '!pet.exists'},
	--actions.precombat+=/snapshot_stats
	--actions.precombat+=/mirror_image
	--actions.precombat+=/potion,name=deadly_grace
	--actions.precombat+=/frostbolt
}

local Cooldowns = {
	--actions+=/time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410)
	--{'Time Warp', '{xtime=0&!player.buff(Bloodlust)}||{!player.buff(Bloodlust)&xequipped(132410)}'},
	--actions.cooldowns=rune_of_power,if=cooldown.icy_veins.remains<cast_time|charges_fractional>1.9&cooldown.icy_veins.remains>10|buff.icy_veins.up|target.time_to_die.remains+5<charges_fractional*10
	{'Rune of Power', '!player.buff(Rune of Power)&{cooldown(Icy Veins).remains<cooldown(Rune of Power).cast_time||cooldown(Rune of Power).charges<1.9&cooldown(Icy Veins).remains>10||player.buff(Icy Veins)||{target.time_to_die+5<cooldown(Rune of Power).charges*10}}'},
 	--actions.cooldowns+=/icy_veins,if=buff.icy_veins.down
	{'Icy Veins', '!player.buff(Icy Veins)'},
 	--actions.cooldowns+=/mirror_image
	{'Mirror Image'},
 	--actions.cooldowns+=/blood_fury
	{'Blood Fury'},
 	--actions.cooldowns+=/berserking
	{'Berserking'},
 	--actions.cooldowns+=/potion,name=deadly_grace
	--{'#Deadly Grace'},
}

local xCombat = {
 	--actions+=/ice_lance,if=buff.fingers_of_frost.down&prev_gcd.flurry
	{'Ice Lance', '!player.buff(Fingers of Frost)&prev_gcd(Flurry)'},
	--actions+=/call_action_list,name=cooldowns
	{Cooldowns, 'toggle(cooldowns)'},
 	--actions+=/blizzard,if=buff.potion_of_deadly_grace.up&!prev_off_gcd.water_jet
	{'Blizzard', 'player.buff(Potion of Deadly Grace)&!target.debuff(Water Jet)'},
 	--actions+=/ice_nova,if=debuff.winters_chill.up
	{'!Ice Nova', 'target.debuff(Winter\'s Chill)'},
 	--actions+=/frostbolt,if=prev_off_gcd.water_jet
	{'Frostbolt', 'target.debuff(Water Jet).remains>action(Frostbolt).cast_time&player.buff(Fingers of Frost).stack<2'},
 	--actions+=/water_jet,if=prev_gcd.frostbolt&buff.fingers_of_frost.stack<(2+artifact.icy_hand.enabled)&buff.brain_freeze.down
	{'&Water Jet', 'prev_gcd(Frostbolt)&player.buff(Fingers of Frost).stack<{2+artifact(Icy Hand).enabled}&!player.buff(Brain Freeze)'},
 	--actions+=/ray_of_frost,if=buff.icy_veins.up|(cooldown.icy_veins.remains>action.ray_of_frost.cooldown&buff.rune_of_power.down)
	{'Ray of Frost', 'player.buff(Icy Veins)||{cooldown(Icy Veins).remains>action(Ray of Frost).cooldown&!player.buff(Rune of Power)}'},
 	--actions+=/flurry,if=buff.brain_freeze.up&buff.fingers_of_frost.down&prev_gcd.frostbolt
	{'Flurry', 'player.buff(Brain Freeze)&!player.buff(Fingers of Frost)&!prev_gcd(Flurry)'},
 	--actions+=/glacial_spike
	{'Glacial Spike'},
 	--actions+=/frozen_touch,if=buff.fingers_of_frost.stack<=(0+artifact.icy_hand.enabled)
	{'Frozen Touch', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).enabled}'},
 	--actions+=/frost_bomb,if=debuff.frost_bomb.remains<action.ice_lance.travel_time&buff.fingers_of_frost.stack>0
	{'Frost Bomb', 'target.debuff(Frost Bomb).remains<action(Ice Lance).travel_time&player.buff(Fingers of Frost).stack>0'},
 	--actions+=/ice_lance,if=buff.fingers_of_frost.stack>0&cooldown.icy_veins.remains>10|buff.fingers_of_frost.stack>2
	{'Ice Lance', 'player.buff(Fingers of Frost).stack>0&cooldown(Icy Veins).remains>10||player.buff(Fingers of Frost).stack>2'},
 	--actions+=/frozen_orb
	{'Frozen Orb'},
 	--actions+=/ice_nova
	{'Ice Nova'},
 	--actions+=/comet_storm
	{'Comet Storm'},
 	--actions+=/blizzard,if=talent.artic_gale.enabled
	{'Blizzard', 'talent(6,3)', 'target.ground'},
 	--actions+=/ebonbolt,if=buff.fingers_of_frost.stack<=(0+artifact.icy_hand.enabled)
	{'Ebonbolt', 'player.buff(Fingers of Frost).stack<={0+artifact(Icy Hand).enabled}'},
	{'Ice Barrier', '!player.buff(Ice Barrier)&!player.buff(Rune of Power)'},
	{'Ice Floes', 'gcd.remains<0.2&xmoving=1&!prev_gcd(Ice Floes)&!player.buff(Ice Floes)'},
	{'Summon Water Elemental', '!pet.exists'},
 	--actions+=/frostbolt
	{'Frostbolt', 'xmoving=0||player.buff(Ice Floes)'},
}


local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Counterspell'},
	{'Arcane Torrent', 'target.range<=8&spell(Counterspell).cooldown>gcd&!prev_gcd(Counterspell)'},
}

local Survival = {

}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<40'},
	{Survival, 'player.health < 100'},
	{xCombat, 'target.range<40&target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(64, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] MAGE - Frost',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
