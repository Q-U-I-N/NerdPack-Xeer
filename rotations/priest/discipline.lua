local _, Xeer = ...
local GUI = {
}

--local GUI = {
	--KEYBINDS
--	{type = 'header', 	text = 'Keybinds', align = 'center'},
--	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
--	{type = 'text', 	text = 'Left Ctrl: Mass Dispel', align = 'center'},
--	{type = 'text', 	text = 'Left Alt: Power Word: Barrier', align = 'center'},
--	{type = 'checkbox', text = 'Pause enabled', key = 'kP', default = false},
--	{type = 'checkbox', text = 'Mass Dispel enabled', key = 'kMD', default = false},
--	{type = 'checkbox', text = 'Power Word: Barrier enabled', key = 'kPWB', default = false}

--}

--local exeOnLoad = function()
--	MTSCR.ExeOnLoad()
--end

--UNIT.lastgcd(SPELL)
--UNIT.area(HEALTH, DISTANCE).heal>= #
--UNIT.area(HEALTH, DISTANCE).heal.infront >= #
--UNIT.area(DISTANCE).enemies.infront >= #
--UNIT.area(DISTANCE).friendly.infront >= #

--NeP.FakeUnits:Add('lnbuff', function(num, buff)
--    local tempTable = {}
--    for _, Obj in pairs(NeP.Healing:GetRoster()) do
--        if not NeP.DSL:Get('buff')(Obj.key, buff) then
--            tempTable[#tempTable+1] = {
--                key = Obj.key,
--                health = Obj.health
--            }
--        end
--    end
--    table.sort( tempTable, function(a,b) return a.health < b.health end )
--    return tempTable[num] and tempTable[num].key
--end)

--local Keybinds = {
--	{'%pause', 'keybind(lshift)& UI(kP)'}, -- Pause.
--	{'Mass Dispel', 'keybind(lctrl) & UI(kMD)', 'cursor.ground'}, --Mass Dispel.
--	{'Power Word: Barrier', 'keybind(lalt) & UI(kPWB)', 'cursor.ground'} --Power Word: Barrier.
--}

--function Ato.Buff(eval, args)
--   local spell = NeP.Engine:Spell(args)
--    if not spell then return end
--    for i=1,#NeP.OM['unitFriendly'] do
--        local Obj = NeP.OM['unitFriendly'][i]
--        local Threat = UnitThreatSituation('player', Obj.key)
--        if Threat and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
--            eval.spell = spell
--            eval.target = Obj.key
--            return NeP.Engine:STRING(eval)
--        end
--    end
--end

local Keybinds = {
	{'%pause', 'keybind(shift)'}, -- Pause.
	{'Mass Dispel', 'keybind(control)', 'cursor.ground'}, --Mass Dispel.
	{'Power Word: Barrier', 'keybind(alt)', 'cursor.ground'} --Power Word: Barrier.
}


local Cooldowns = {
	{'Mindbender', nil, 'target'}, --Mind Bender for better Mana Regen and dps boost.
	{'Power Infusion'}, --Power Infusion for some BOOOST YO!
	{'Divine Star', 'player.area(20).enemies.infront >= 3', 'target'}, -- Divine Star (if selected) for some small AoE dmg dealing.
	--{'Light\'s Wrath', 'target.debuff(Schism)&player.buff(Overloaded with Light)', 'target'},

	--{"#trinket1", { "player.buff(Power Infusion)", "!player.buff(Lethal On Board)" }}, --Eyasu's Mulligan's crit or haste
	--{"#trinket1", { "player.buff(Power Infusion)", "!player.buff(The Coin)" }}, --Eyasu's Mulligan's crit or haste
	--{"#trinket2", { "player.buff(Power Infusion)", "!player.buff(Lethal On Board)" }}, --Eyasu's Mulligan's crit or haste
	--{"#trinket2", { "player.buff(Power Infusion)", "!player.buff(The Coin)" }} --Eyasu's Mulligan's crit or haste
}

local Tank = {
    --{'Clarity of Will', 'talent(6,1)&tank.incdmg(7) => tank.health.max*0.70||tank.area(5).enemies>= 3', 'tank'}, --Clarity of Will (if selected) to keep our tank secure and healthy.
	{'Power Word: Shield', {'!tank.buff(Power Word: Shield)||player.buff(Rapture)'}, 'tank'}, --Power Word: Shield the Tank
	{'Pain Suppression', 'tank.health <= 20', 'tank'}, --Pain Suppression for less damage intake.
	{'Shadow Mend', 'tank.health <= 40', 'tank'}, --Shadow Mend for huge direct heal.
}

local Lowest = {
	{'Plea', '!lowest.buff(Atonement)&lowest.health <= 90', 'lowest'}, --Plea for an instant Atonement.
	--{'Plea', '!lowest2.buff(Atonement)&lowest.health <= 90', 'lowest2'},
	--{'Plea', '!lowest3.buff(Atonement)&lowest.health <= 90', 'lowest3'},
		{'Power Word: Shield', 'lowest.health <= 90||player.buff(Rapture)&!lowest.buff(Power Word: Shield)', 'lowest'}, --Power Word: Shield Use to absorb low to moderate damage and to apply Atonement.
	{'Shadow Mend', 'lowest.health <= 60', 'lowest'}, --Shadow Mend for a decent direct heal.
	{'Penance', 'lowest.health <= 80 & talent(1,1)', 'lowest'}, -- Penance (if talent "Penitent" selected)
	--{'Plea', 'lowest.health <= 90', 'lowest'}, --Plea for an efficient direct heal and to apply Atonement.
	{'Divine Star', 'player.area(80, 20).heal >= 3'} -- Divine Star (if selected) for a quick heal & dmg dealing.
}

local Player = {

}

local Atonement = {
--	{'Purge the Wicked', 'talent(7,1)&target.debuff(Purge the Wicked).duration < 3&target.debuff(Schism)||!talent(1,3)&talent(7,1)&target.debuff(Purge the Wicked).duration < 2.7'}, 	--Purge of the Wicked for a low to moderate HoT to your Atonement targets.
--	{'Shadow Word: Pain', '!talent(7,1)&target.debuff(Shadow Word: Pain).duration < 2&target.debuff(Schism)||!talent(1,3)&!talent(7,1)&target.debuff(Shadow Word: Pain).duration < 2.7'},	--Shadow Word: Pain (if no PotW Talent is selected) for a low to moderate HoT to your Atonement targets.
	{'Purge the Wicked', 'talent(7,1)&target.debuff(Purge the Wicked).duration < 2.7'}, 	--Purge of the Wicked for a low to moderate HoT to your Atonement targets.
	{'Shadow Word: Pain', '!talent(7,1)&target.debuff(Shadow Word: Pain).duration < 2.7'},	--Shadow Word: Pain (if no PotW Talent is selected) for a low to moderate HoT to your Atonement targets.
	{'Schism', 'target.debuff(Schism).duration < 1.5'},	--Schism on cooldown for damage & heal buff
	{'Penance', 'target.debuff(Schism)||!talent(1,3)', 'target'}, --Penance on cooldown for low to moderate healing to your Atonement targets.
	{'Smite', 'target.debuff(Schism)||!talent(1,3)', 'target'} --Smite for low to moderate healing to your Atonement targets.
}

local inCombat = {
		{'%dispelall'},
		{'Arcane Torrent', 'player.mana < 50'},
		{Keybinds},
		{Cooldowns, 'toggle(cooldowns)'},
		{Tank, 'tank.health < 100'},
		{Lowest, 'lowest.health < 100'},
		--{Player, 'player.health < 100'},
		{Atonement}
}

local outCombat = {
		{Keybinds},
		{'Plea', '!lowest.buff(Atonement)&lowest.health <=95', 'lowest'}
}

NeP.CR:Add(256, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] PRIEST - Discipline',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
