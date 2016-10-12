--/dump NeP.DSL:Get('equipped')('player','1212')
--/dump NeP.DSL:Get("spell.cooldown")(nil, 'Intercept')
NeP.DSL:Register('equipped', function(target, item)
	if IsEquippedItem(item) == true then return true else return false end
end)

--/dump NeP.DSL:Get('casting.left')('player', 'Fireball')
NeP.DSL:Register('casting.left', function(target, spell)
	local reverse = NeP.DSL:Get('casting.percent')(target, spell)
	if reverse ~= 0 then
	return 100 - reverse
	end
return 0
end)

--[[
--/dump NeP.DSL:Get('xinfront.enemies')('10','30')
NeP.DSL:Register('xinfront.enemies', function(unit, distance)
	local total = 0
	if not UnitExists(unit) then return total end
	for i=1, #NeP.OM['unitEnemie'] do
		local Obj = NeP.OM['unitEnemie'][i]
		if UnitExists(Obj.key) and (UnitAffectingCombat(Obj.key) or isDummy(Obj.key))
		and NeP.Engine.Distance(unit, Obj.key) <= tonumber(distance) then
			if NeP.Engine.Infront('player', Obj.key) then
				total = total +1
			end
		end
	end
	return total
end)

--]]
-----------------------------------SIMC STUFFS----------------------------------

NeP.DSL:Register('xmoving', function(target)
	local speed, _ = GetUnitSpeed(target)
		if speed ~= 0 then
			return 1
		else
			return 0
		end
end)

--[[
	local classTaunt = {
		[1] = 'Taunt',
		[2] = 'Hand of Reckoning',
		[6] = 'Dark Command',
		[10] = 'Provoke',
		[11] = 'Growl',
		[12] = 'Torment'
	}
--]]


local PowerT = {
	[0] = ('^.-Mana'),
	[1] = ('^.-Rage'),
	[2] = ('^.-Focus'),
	[3] = ('^.-Energy'),
}


--/dump NeP.DSL:Get('action.cost')('Rake')
--/dump NeP.DSL:Get('action.cost')('Rejuvenation')
NeP.DSL:Register('action.cost', function(spell)
	local costText = Xeer.Core:Scan_SpellCost(spell)
	local numcost = 0
		for i = 0, 3 do
			local cost = strmatch(costText, PowerT[i])
			if cost ~= nil then
        numcost = gsub(cost, '%D', '') + 0
			end
		end
		if numcost > 0 then
			return numcost
		else
			return 0
		end
end)


--UnitBuff(Unit,GetSpellInfo(SpellID))
--/dump GetSpellInfo(190456)
--/dump UnitBuff('player',GetSpellInfo(190456))

--/dump NeP.DSL:Get('ignorepain_cost')()
NeP.DSL:Register('ignorepain_cost', function()
	return Xeer.Core:Scan_IgnorePain()
end)

--/dump NeP.DSL:Get['ignorepain_max')()
NeP.DSL:Register('ignorepain_max', function()
	local ss = NeP.DSL:Get('health.max')('player')
	if hasTalent(5,2) == true then
		return NeP.Core.Round((((77.86412474516502 * 1.70) * ss) / 100))
	else
		return NeP.Core.Round(((77.86412474516502 * ss) / 100))
	end
end)

--------------------------------------FERAL-------------------------------------
local DotTicks = {
	[1822] = 3,
	[1079] = 2,
	[106832] = 3,
	[8921] = 2,
	[155625] = 2,
}

--/dump NeP.DSL:Get['dot.x')('target', 'Moonfire')
--/dump NeP.DSL:Get('dot.tick_time')('target','155625')
NeP.DSL:Register('dot.tick_time', function(target, spell)
	local spell = NeP.Core:GetSpellID(NeP.Core:GetSpellName(spell))
	local class = select(3,UnitClass('player'))
	if class == 11 and GetSpecialization() == 2 then
		if NeP.DSL:Get('talent')(nil, '6,1') and spell == 1822 or spell == 1079 or spell == 106832 then
			return DotTicks[spell] * 0.67
		else if spell == 1822 or spell == 1079 or spell == 106832 then
					return DotTicks[spell]
				else
					return math.floor((DotTicks[spell] / ((GetHaste() / 100) + 1)) * 10^3 ) / 10^3
				end
		end
	end
end)
--------------------------------------FERAL-------------------------------------

--/dump NeP.DSL:Get('dot.duration')('target','Rip')
NeP.DSL:Register('dot.duration', function(target, spell)
	local debuff,_,duration,expires,caster = Xeer.Core:UnitDot(target, spell)
	if debuff and (caster == 'player' or caster == 'pet') then
		return duration
	end
	return 0
end)

--/dump NeP.DSL:Get('debuff')('target', 'Deep Wounds')
--/dump NeP.DSL:Get('dot.ticking')('target', 'Deep Wounds')
NeP.DSL:Register('dot.ticking', function(target, spell)
	if NeP.DSL:Get('debuff')(target, spell) then
		return true
	else
		return false
	end
end)

--/dump NeP.DSL:Get('dot.remains')('target','Rip')
NeP.DSL:Register('dot.remains', function(target, spell)
	return NeP.DSL:Get('debuff.duration')(target, spell)
end)

NeP.DSL:Register('dot.ticks_remain', function(target, spell)
end)

NeP.DSL:Register('dot.current_ticks', function(target, spell)
end)

NeP.DSL:Register('dot.ticks', function(target, spell)
end)

NeP.DSL:Register('dot.tick_time_remains', function(target, spell)
end)

NeP.DSL:Register('dot.active_dot', function(target, spell)
end)


--/dump NeP.DSL:Get('cooldown.remains')('player','Combustion')
--/dump NeP.DSL:Get('buff.stack')('player','Incanter\'s Flow')
--/dump NeP.DSL:Get('spell_haste')('player')
--/dump NeP.DSL:Get('talent.enabled')('player','6,2')
--/dump NeP.DSL:Get('cast_regen')('player','Fireball')
--/dump NeP.DSL:Get('cast_time')('player','Cinderstorm')


--/dump NeP.DSL:Get('ignorepain_max')('player')


--/dump NeP.DSL:Get('buff.react')('player','Incanter\'s Flow')
NeP.DSL:Register('buff.react', function(target, spell)
	local x = NeP.DSL:Get('buff.count')(target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

--/dump NeP.DSL:Get('buff.stack')('player','Incanter\'s Flow')
NeP.DSL:Register('buff.stack', function(target, spell)
	return NeP.DSL:Get('buff.count')(target, spell)
end)

NeP.DSL:Register('buff.remains', function(target, spell)
	return NeP.DSL:Get('buff.duration')(target, spell)
end)

NeP.DSL:Register('debuff.react', function(target, spell)
	local x = NeP.DSL:Get('debuff.count')(target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

NeP.DSL:Register('debuff.stack', function(target, spell)
	return NeP.DSL:Get('debuff.count')(target, spell)
end)

--/dump NeP.DSL:Get('debuff.remains')('target', 'Thrash')
NeP.DSL:Register('debuff.remains', function(target, spell)
	return NeP.DSL:Get('debuff.duration')(target, spell)
end)

--TODO: work out off gcd/gcd only skills now all of this is just like SiMC 'prev'

--/dump NeP.DSL:Get('prev_off_gcd')('player', 'Thrash')
NeP.DSL:Register('prev_off_gcd', function(Unit, Spell)
	return NeP.DSL:Get('lastcast')(Unit, Spell)
end)

--/dump NeP.DSL:Get('prev_gcd')('player', 'Thrash')
NeP.DSL:Register('prev_gcd', function(Unit, Spell)
	return NeP.DSL:Get('lastcast')(Unit, Spell)
end)

--/dump NeP.DSL:Get('prev')('player', 'Thrash')
NeP.DSL:Register('prev', function(Unit, Spell)
	return NeP.DSL:Get('lastcast')(Unit, Spell)
end)

--/dump NeP.DSL:Get('time_to_die')('target')
NeP.DSL:Register('time_to_die', function(target)
	return NeP.DSL:Get('deathin')(target)
end)

--/dump NeP.DSL:Get('time')('player')
NeP.DSL:Register('time', function(target)
	return NeP.DSL:Get('combat.time')(target)
end)

--/dump NeP.DSL:Get('spell.cooldown')('player','Rip')
NeP.DSL:Register('cooldown.remains', function(_, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) == true then
		return NeP.DSL:Get('spell.cooldown')(_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL:Get('action.charges')('player','Phoenix\'s Flames')
NeP.DSL:Register('action.charges', function(_, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) == true then
		return NeP.DSL:Get('spell.charges')(_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL:Get('charges_fractional')('player','Phoenix\'s Flames')
NeP.DSL:Register('charges_fractional', function(_, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) == true then
		return NeP.DSL:Get('spell.charges')(_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL:Get('spell_haste')('player')
NeP.DSL:Register('spell_haste', function(target)
	local shaste = NeP.DSL:Get('haste')(target)
	return math.floor((100 / ( 100 + shaste )) * 10^3 ) / 10^3
end)

NeP.DSL:Register('talent.enabled', function(target, args)
--[[
	local havetalent = NeP.DSL:Get('talent')(target, args)
	if havetalent == true then
		return 1
	else
		return 0
	end
--]]
	return NeP.DSL:Get('talent')(target, args)
end)

--/dump NeP.DSL:Get('action.execute_time')('player','Fireball')
NeP.DSL:Register('action.execute_time', function(target, spell)
	return NeP.DSL:Get('execute_time')(target, spell)
end)

NeP.DSL:Register('execute_time', function(target, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) then
  	local GCD = NeP.DSL:Get('gcd')()
  	local CTT = NeP.DSL:Get('spell.casttime')(_, spell)
			if CTT > GCD then
				return CTT
			else
				return GCD
			end
	end
	return false
end)

--/dump NeP.DSL:Get('combo_points')()
NeP.DSL:Register('combo_points', function()
	return GetComboPoints('player', 'target')
end)

--/dump NeP.DSL:Get('cast_regen')('player', 'Shockwave')
NeP.DSL:Register('cast_regen', function(target, spell)
	local regen = select(2, GetPowerRegen(target))
	local _, _, _, cast_time = GetSpellInfo(spell)
	return math.floor(((regen * cast_time) / 1000) * 10^3 ) / 10^3
end)

--/dump NeP.DSL:Get('deficit')('player')
NeP.DSL:Register('deficit', function(target)
	local max = UnitPowerMax(target)
	local curr = UnitPower(target)
	return (max - curr)
end)

--max_energy=1, this means that u will get energy cap in less than one GCD
--/dump NeP.DSL:Get('max_energy')('player')
NeP.DSL:Register('max_energy', function(target)
	 local ttm = NeP.DSL:Get('energy.time_to_max')(target)
	 local GCD = NeP.DSL:Get('gcd')()
	 if GCD > ttm then
		 return 1
	 else
		 return false
	 end
end)

--/dump NeP.DSL:Get('energy.deficit')('player')
NeP.DSL:Register('energy.deficit', function(target)
	return NeP.DSL:Get('deficit')(target)
end)

--/dump NeP.DSL:Get('energy.regen')('player')
NeP.DSL:Register('energy.regen', function(target)
	local eregen = select(2, GetPowerRegen(target))
	return eregen
end)

--/dump NeP.DSL:Get('energy.time_to_max')('player')
NeP.DSL:Register('energy.time_to_max', function(target)
	local deficit = NeP.DSL:Get('deficit')(target)
	local eregen = NeP.DSL:Get('energy.regen')(target)
	return deficit / eregen
end)

--/dump NeP.DSL:Get('focus.deficit')('player')
NeP.DSL:Register('focus.deficit', function(target)
	return NeP.DSL:Get('deficit')(target)
end)

--/dump NeP.DSL:Get('focus.regen')('player')
NeP.DSL:Register('focus.regen', function()
	local fregen = select(2, GetPowerRegen(target))
	return fregen
end)

--/dump NeP.DSL:Get('focus.time_to_max')('player')
NeP.DSL:Register('focus.time_to_max', function(target)
	local deficit = NeP.DSL:Get('deficit')(target)
	local fregen = NeP.DSL:Get('focus.regen')(target)
	return deficit / fregen
end)

NeP.DSL:Register('action.cast_time', function(_, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) == true then
		return NeP.DSL:Get('spell.casttime')(_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL:Get('cast_time')('player','Revenge')
NeP.DSL:Register('cast_time', function(_, spell)
	if NeP.DSL:Get('spell.exists')(_, spell) == true then
		return NeP.DSL:Get('spell.casttime')(_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL:Get('health.pct')('player')
NeP.DSL:Register('health.pct', function(target)
	return NeP.DSL:Get('health')(target)
end)

NeP.DSL:Register('active_enemies', function(unit, distance)
	return NeP.DSL:Get('area.enemies')(unit, distance)
end)

--TODO: this is just fake one atm:P dont have real artifact traits check yet
NeP.DSL:Register('artifact.enabled', function(_, spell)
	return NeP.DSL:Get('spell.exists')(_, spell)
end)

NeP.DSL:Register('artifact.equipped', function(_, spell)
	return NeP.DSL:Get('spell.exists')(_, spell)
end)
