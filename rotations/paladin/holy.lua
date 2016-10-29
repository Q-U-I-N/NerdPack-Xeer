local _, Xeer = ... 

local GUI = {
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Shift: Pause, | Ctrl: DPS,  | Alt: Top Up ', align = 'center'},

	{type = 'header', 	text = 'Generic', align = 'center'},
	{type = 'spinner', 	text = 'DPS while lowest health%', 	key = 'G_DPS', 	default = 70},
	{type = 'spinner', 	text = 'Critical health%', 			key = 'G_CHP', 	default = 30},
	{type = 'dropdown',text = 'Beacon Logic', key = 'G_Beacon', list = {
		{text = 'Manual', key = 'BeaconManual'},
		{text = 'Lowest Tank', key = 'BeaconLowestTank'},
		{text = 'Focus Tank', key = 'BeaconFocusTank'},
    }, default = 'BeaconManual' },

    --------------------------------
	-- AoE
	--------------------------------
	{type = 'header', 	text = 'AoE', align = 'center'},
	--Aura Mastery logic
    {type = 'spinner', 	text = 'Aura Mastery Health%', 				key = 'AoE_AMH', 	default = 70},
    {type = 'spinner', 	text = 'Aura Mastery Number of Units', 		key = 'AoE_AMN', 	default = 4, step = 1},
    {type = 'spinner', 	text = 'Light of Dawn Health%', 			key = 'AoE_LoDH', 	default = 70},
    {type = 'spinner', 	text = 'Light of Dawn Number of Units', 	key = 'AoE_LoDHN', 	default = 5, step = 1},
    {type = 'spinner', 	text = 'Holy Prism Health%', 				key = 'AoE_HPH', 	default = 70},
    {type = 'spinner', 	text = 'Holy Prism Number of Units', 		key = 'AoE_HPN', 	default = 3, step = 1},
	{type = 'ruler'},{type = 'spacer'},
	
	--------------------------------
	-- PLAYER
	--------------------------------
	{type = 'header', 	text = 'Player', align = 'center'},
	{type = 'spinner', 	text = 'Divine Shield (Health %)', 				key = 'P_DS', 	default = 20}, 
	{type = 'spinner', 	text = 'Divine Protection (Health %)', 			key = 'P_DP', 	default = 40}, 
	{type = 'spinner', 	text = 'Healing Item (Pot/Stone) (Health %)', 	key = 'P_HI', 	default = 25}, 
	{type = 'spinner', 	text = 'Blessing of Protection (Health %)', 	key = 'P_BoP', 	default = 0}, 
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 				key = 'P_LoH', 	default = 25},		
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 				key = 'P_HS', 	default = 90},
	{type = 'spinner', 	text = 'Bestow Faith (Health %)', 				key = 'Å_BF', 	default = 80},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 			key = 'P_FoL', 	default = 75},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 				key = 'P_HL', 	default = 90},
	{type = 'ruler'},{type = 'spacer'},
	
	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},											
	{type = 'spinner', 	text = 'Blessing of Protection (Health %)', 	key = 'T_BoP', 	default = 0}, 
	{type = 'spinner', 	text = 'Blessing of Sacrifice (Health %)', 		key = 'T_BoS', 	default = 30},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 				key = 'T_LoH', 	default = 25},		
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 		key = 'T_LotM', default = 35},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 				key = 'T_HS', 	default = 90},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 		key = 'T_LotM', default = 40},
	{type = 'spinner', 	text = 'Bestow Faith (Health %)', 				key = 'T_BF', 	default = 80},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 			key = 'T_FoL', 	default = 75},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 				key = 'T_HL', 	default = 90},
	{type = 'ruler'},{type = 'spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 				key = 'L_LoH', 	default = 25},
	{type = 'spinner', 	text = 'Blessing of Protection (Health %)', 	key = 'L_BoP', 	default = 20},
	{type = 'spinner', 	text = 'Blessing of Sacrifice (Health %)', 		key = 'L_BoS', 	default = 30},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 				key = 'L_HS', 	default = 90},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 		key = 'L_LotM', default = 40},
	{type = 'spinner', 	text = 'Bestow Faith (Health %)', 				key = 'L_BF', 	default = 80},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 			key = 'L_FoL', 	default = 70},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 				key = 'L_HL', 	default = 90},
	
	
}



local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FHoly |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/3 - 5/1 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'dps',
		name = 'dps',
		text = 'DPS while healing',
		icon = 'Interface\\Icons\\spell_nature_shamanrage.png',
	})
end

local _Xeer = {
-- some non-SiMC stuffs
	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},

}

local Util = {
-- Add stuff that should be done part of encounter, dont cast while, dont attack, dont etc
--BOSS
	{ '%pause' , 'player.debuff(200904)' },			--Sapped Soul
	{ '%pause' , 'player.debuff(Sapped Soul)' }, 	--Sapped Soul
	-- FREEDOOM! --Should add a toggle for this
	{ 'Every Man for Himself', 'player.state.stun' }, 
	{ 'Blessing of Freedom', 'player.state.stun' }, 
	{ 'Blessing of Freedom', 'player.state.root' }, 
	{ 'Blessing of Freedom', 'player.state.snare' }, 
}
-- Cast that should be interrupted
local Interrupts = {			-- No interrupt as Holy, but we can stun them
	{ 'Hammer of Justice', nil, 'target'},
	{ 'Blinding Light' },
}

-- Units that should be CC
local Stuns = {
	{ 'Hammer of Justice', nil, 'target'},
}

-- Remove CC and slows
local BreakFree = {
	{ 'Blessing of Freedom' },
	{ 'Every man for himself' },
}
local TopUp = {
	{'Holy Shock', nil, 'lowest'},
	{'Flash of Light', nil, 'lowest'},
	--Todo: Should have a topup target and not always lowest, like MouseOver 
}

local DPS = {
	{'Consecration', {'player.area(8).enemies > 2', '!xmoving=1'}},
	{'Blinding Light', 'player.area(8).enemies >= 3'},
	{'Holy Shock', nil, 'target'},
	--{'Holy Prism', {'lowest.area(15).enemies > 1', 'lowest.health < 90'}, 'lowest'},
	--{'Holy Prism', nil, 'target'},
	{'Judgment'},
	{'Crusader Strike'},
	{'Consecration', {'player.area(8).enemies > 0', '!xmoving=1'}},
	--{'Holy Prism', 'lowest.health < 95', 'lowest'},
	{'Flash of Light', 'lowest.health < 90', 'lowest'},
}
local Healing = {
--Todos: Set alot of the configuration,
--[[
	-------------------
	-- Break out of Stuns with racials
	-------------------
	-- Todo :Add every man for himself
	]]
	--------------
	-- Critical healing Player
	--------------
	{'!Divine Shield', 			'player.health < UI(P_DS)&!player.debuff(Forebearance)'},
	{'!Lay on Hands', 			'player.health < UI(P_LoH)&!player.debuff(Forebearance)', 'player'},
	{'!Blessing of Protection',	'player.health < UI(P_BoP)&!player.debuff(Forebearance)', 'player'},
	--------------
	-- Critical healing Tank
	--------------
	{'!Lay on Hands', 			'lowest(tank).health < UI(T_LoH)&!lowest(tank).debuff(Forebearance)',	'lowest(tank)'},
	{'Blessing of Protection', 	'lowest(tank).health < UI(T_BoP)&!lowest(tank).debuff(Forebearance)', 	'lowest(tank)'},
	{'Blessing of Sacrifice', 	'lowest(tank).health < UI(T_BoS)&player.health > 70', 'lowest(tank)'},
	--------------
	-- Critical Heals Raid
	-----------
	{'!Lay on Hands', 			'lowest.health < UI(L_LoH)&!lowest.debuff(Forebearance)', 		'lowest'},
	{'Blessing of Protection', 	'lowest.health < UI(L_BoP)&!lowest.debuff(Forebearance)', 		'lowest'},
	{'Blessing of Sacrifice', 	'lowest.health < UI(L_BoS)&player.health > 70', 				'lowest'},
	--------------
	-- Player low health CDs
	--------------
	{'Divine Protection', 		'player.health < UI(P_DP)'},
	{ '#129196', 				'player.health < UI(P_HI)'}, 
	-- ToDo Mana Pot, if mana low

	-------------------------
	-- Divine Protection if debuffed with Blessing of Sacrifice
	-------------------------
	{'Divine Protection', 		'player.debuff(Blessing of Sacrifice)'}, 

	---------------
	-- Interrupt high prio
	---------------

	---------------
	-- DPS target selection, 
	---------------

	---------------
	-- Get Units populated, healing units, dispell units, unitswithdebuffs etc, MT/OTLowest
	-- For AoE heals we need to get
	--	Holy prism candidates, ie injunred allies around enemy targets
	-- 	Light of Dawn candidates, ie injured around the player and frontal cone
	--	Lights Hammer candidate or actaully spot on the gound to cast on
	-- 	Rule of Law information, ie people 10-15 yards, out of range lowest we need to heal
	---------------

	-------------------
	-- Dispell high prio debuffs
	-------------------

	------------------
	-- Stuns High prio
	------------------

	--------------------
	-- Healing CDs
	--	Check number of injured allies and if beneath HP% and number then popp CDs
	-------------------
	--{'Aura Mastery', 'AoEHeal(15, 80, 40'}, --Cast AM if we have x number of units beneath y hp thresghold within y range
	--{'Avenging Wrath', 'AoEHeal(15, 80, 40'},
	--{'Holy Avenger', 'AoEHeal(15, 80, 40'},
	--{'Light of Dawn', 'HealInFront(6, 80, 40'}
	--{'Tyrs Deliverance', 'AoEHeal(15, 80, 40'}, -- AoE 15 yards around and more healing on thise targets

	-------------------
	-- Critical Healing under Threshold
	--	Per unit set a threshold for critical heals, ie we do not do anyhting else then fast heals until they are up
	-------------------
	-- Player
	{'Flash of Light', 'player.health < UI(G_CHP)&player.buff(Infusion of Light)', 'player'}, 
	{'Holy Shock', 'player.health < UI(G_CHP)', 'player'}, 
	{'Flash of Light', 'player.health < UI(G_CHP)', 'player'}, 
	-- Tank
	{'Light of the Martyr',	'player.buff(Divine Shield)&lowest(tank).health < UI(G_CHP)&player.health > lowest(tank).health', 'lowest(tank)'},
	{'Flash of Light', 'lowest(tank).health < UI(G_CHP)&player.buff(Infusion of Light)', 'lowest(tank)'},
	{'Holy Shock', 'lowest(tank).health < UI(G_CHP)', 'lowest(tank)'}, 
	{'Flash of Light', 'lowest(tank).health < UI(G_CHP)', 'lowest(tank)'},
	
	-- Raid
	{'Light of the Martyr',	'player.buff(Divine Shield)&player.health > lowest.health', 'lowest'},
	{'Flash of Light', 'lowest.health < UI(G_CHP)&player.buff(Infusion of Light)', 'lowest'}, 
	{'Holy Shock', 'lowest.health < UI(G_CHP)', 'lowest'}, 
	{'Flash of Light', 'lowest.health < UI(G_CHP)', 'lowest'},


	-----------------
	-- Judgment if you have light talent and set it to high prio
	--		Iterate through all enemies and cast on one with injured allies hitting it
	----------------
	--{'Judgment', 'target.exist, target.infront&target.distance < 40&target.alive&target.debuff(Judgment of Light)', 'target'}, --Todo: Dynamic target

	-----------------------
	-- DPS if the user presses key or toggle and lowest.health is higher then threshold
	-----------------------
	{DPS, 'keybind(lcontrol)||{toggle(dps)&!lowest.health < UI(G_DPS)&target.enemy}' },


	----------------------
	-- TopUp the raid if user presses key
	----------------------
	{TopUp, 'keybind(lalt)'},

	-----------------------
	-- Beacon Handling
	--	Beacon of light should be on the tank that takes damage
	--		If beacon unit is 100% and not having aggro then switch to other tank if he has less HP and or having aggro
	----------------------
	--{Beaconf of Light},
	--{Beaconf of Virtue}, -- If we have talent and 2-3 people is injured beneath X amount

	--------------------
	-- Dispel normal prio
	---------------------

	-- Healing Rotation
		-- Heal Tanks as very high priority - Holy Shock and Flash of Light	
			-- BestTankTarget =  MainTankHealth < OffTankHealth and MainTank or OffTank;

	-- Divine Purpose - Light Of Dawn - 216413
	{'Light of Dawn', 'player.buff(216413)'},
	-- Divine Purpose - Holy Shock - 216411
	{'Holy Shock', 'player.buff(216411)', 'lowest'},
	
	-- Holy Shock Always
				-- If we have confiured to always use Holy Shock then cast it on lowest or enemy
	-- Holy Prism on Target / MainTank Target / OffTank Target
		-- Should first check if we can cast it on enemy, so use MT/OT target to check agains, or go through all of enemies to get the best one to cast on
		-- Should here actaully get the healing for each target and not only how many
	--{'Holy Prism', 'lowest.health < UI(L_HP)', 'lowest'},
	
	-- Holy Shock, however use infusion buff before if we have them
	{'Flash of Light', {'player.health < UI(P_FoL)', 'player.buff(Infusion of Light)', 'xmoving=1'}, 'player'},
	{'Holy Shock', 'player.health < UI(P_HS)', 'player'},

	{'Flash of Light', {'lowest(tank).health < UI(T_FoL)','player.buff(Infusion of Light)', 'xmoving=1'}, 'lowest(tank)'},
	{'Holy Shock', 'lowest(tank).health < UI(T_HS)', 'lowest(tank)'},
	
	{'Flash of Light', 'lowest.health < UI(L_FoL) & player.buff(Infusion of Light)&xmoving=1', 'lowest'},
	{'Holy Shock', 'lowest.health < UI(L_HS)', 'lowest'},
			
	-- Light Of The Martyr
	{'Light of the Martyr',	'lowest(tank).health < UI(T_LoftM) & player.health > 70', 'lowest(tank)'},
	{'Light of the Martyr',	'lowest.health < UI(L_LoftM) & player.health > 70', 'lowest'},

	-- Bestow Faith Unit, todo -- Should only be cast on tank os people with low health/debuffed
	{'Bestow Faith', 'player.health < UI(P_BF)', 'player'},
	{'Bestow Faith', 'lowest(tank).health < UI(T_BF)', 'lowest(tank)'},
	{'Bestow Faith', 'lowest.health < UI(L_BF)', 'lowest'},
				
	--  CrusadersMight if we have it set to high, lowers CD on LoD and HS with 1.5 sec
	-- Light's Hammer
	-- Judgement light at low prio

	-- Flash Of Light
	{'Flash of Light', 'player.health < UI(P_FoL) & !xmoving=1', 'player'},
	{'Flash of Light', 'lowest(tank).health < UI(T_FoL) & !xmoving=1', 'lowest(tank)'},
	{'Flash of Light', 'lowest.health < UI(L_FoL) & !xmoving=1', 'lowest'},
	
	-- Bad Debuffs - Tank
			-- Cast Holy Shock or Flash of Light if tanks is badly debuffed or need to be topped off
			
	-- Bad Debuffs - Debuffs
		-- Cast Holy Shock or Flash of Light if tanks is badly debuffed or need to be topped off

	-- Crusaders might if low prio
		
	-- Holy Light
	{'Holy Light', 'player.health < UI(P_HL) & !xmoving=1', 'player'},
	{'Holy Light', 'lowest(tank).health < UI(T_HL) & !xmoving=1', 'lowest(tank)'},
	{'Holy Light', 'lowest.health < UI(L_HL) & !xmoving=1','lowest'},

	-------------------------
	-- DPS if nothing to heal
	------------------------
				
}

local HealingN = {
	
	{'Holy Light', 'player.health < 90 & !xmoving=1', 'player'},
	{'Holy Light', 'lowest(tank).health < 90 & !xmoving=1', 'lowest(tank)'},
	{'Holy Light', 'lowest.health < 90 & !xmoving=1','lowest'},
	
}


local Keybinds = {
	{'%pause', 'keybind(shift)'},
}

local inCombat = {
	{Util},
	{Keybinds},
	{TopUp, 'keybind(lalt)'},
	{Healing},
}

local outCombat = {
	{DPS, 'keybind(lcontrol)'},
	{TopUp, 'keybind(lalt)'},
}

NeP.CR:Add(65, '[|cff'..Xeer.addonColor..'Gabbz Holy Paladin V2', inCombat, outCombat, exeOnLoad, GUI)