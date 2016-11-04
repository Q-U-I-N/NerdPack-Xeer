local _, Xeer = ...

local GUI = {

}

local Keybinds = {

}


local Cooldowns = {

}


local inCombat = {

}

local outCombat = {

}

NeP.CR:Add(256, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] PRIEST - Holy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
