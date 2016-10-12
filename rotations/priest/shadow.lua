local GUI = {

}

local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
end

local Voidform = {
	--Void Bolt on cooldown.
	{'!Void Eruption'},
	--Shadow Word: Death when available on targets with <= 20% health.
	{'Shadow Word: Death', 'target.health <= 20'},
	--Mind Blast on cooldown.
	{'Mind Blast'},
	--Mind Flay as a filler.
	{'Mind Flay'}
}

local ST = {
	--Void Eruption at 100 Insanity to activate Voidform.
	{'Void Eruption', 'player.insanity >= 100'},
	--Shadow Word: Pain maintained at all times.
	{'Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 5'},
	--Vampiric Touch maintained at all times.
	{'Vampiric Touch', 'target.debuff(Vampiric Touch).duration < 5'},
	--Shadow Word: Death when available on targets with <= 20% health.
	{'Shadow Word: Death', 'target.health <= 20'},
	--Mind Blast on cooldown to build Insanity.
	{'Mind Blast'},
	--Mind Flay as a filler to build Insanity.
	{'Mind Flay'}
}

local inCombat = {
	{Voidform, 'player.buff(Voidform)'},
	{ST, '!player.buff(Voidform)'}
}

local outCombat = {

}

NeP.CR:Add(258, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Priest - Shadow', inCombat, outCombat, exeOnLoad)