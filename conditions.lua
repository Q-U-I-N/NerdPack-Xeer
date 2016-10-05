--/dump NeP.DSL.Conditions['equipped']('player','1212')
NeP.DSL.RegisterConditon('equipped', function(target, item)
	if IsEquippedItem(item) == true then return true else return false end
end)

--/dump NeP.DSL.Conditions['xinfront.enemies']('10','30')
--/dump NeP.DSL.Conditions['area.enemies']('10','30')
--player.area(8).enemies >= 3
NeP.DSL.RegisterConditon('xinfront.enemies', function(unit, distance)
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

NeP.DSL.RegisterConditon('xmoving', function(target)
	local speed, _ = GetUnitSpeed(target)
		if speed ~= 0 then
			return 1
		else
			return 0
		end
end)

--------------------------------SIMC STUFFS---------------------------------
--/dump NeP.DSL.Conditions['cooldown.remains']('player','Combustion')
--/dump NeP.DSL.Conditions['buff.stack']('player','Incanter\'s Flow')
--/dump NeP.DSL.Conditions['spell_haste']('player')
--/dump NeP.DSL.Conditions['talent.enabled']('player','1,1')
--/dump NeP.DSL.Conditions['cast_regen']('player','Fireball')
--/dump NeP.DSL.Conditions['cast_time']('player','Cinderstorm')


--/dump NeP.DSL.Conditions['buff.react']('player','Ice Floes')
NeP.DSL.RegisterConditon('buff.react', function(target, spell)
	local x = NeP.DSL.Conditions['buff.count'](target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

NeP.DSL.RegisterConditon('buff.stack', function(target, spell)
	return NeP.DSL.Conditions['buff.count'](target, spell)
end)

NeP.DSL.RegisterConditon('buff.remains', function(target, spell)
	return NeP.DSL.Conditions['buff.duration'](target, spell)
end)

NeP.DSL.RegisterConditon('debuff.react', function(target, spell)
	local x = NeP.DSL.Conditions['debuff.count'](target, spell)
  if x == 1 then
    return true
  elseif x == 0 then
    return false
  else
    return x
  end
end)

NeP.DSL.RegisterConditon('debuff.stack', function(target, spell)
	return NeP.DSL.Conditions['debuff.count'](target, spell)
end)

NeP.DSL.RegisterConditon('debuff.remains', function(target, spell)
	return NeP.DSL.Conditions['debuff.duration'](target, spell)
end)

--TODO: work out off gcd/gcd only skills now all of this is just like SiMC "prev"
--/dump NeP.DSL.Conditions['prev_off_gcd']('player', 'Fire Blast')
NeP.DSL.RegisterConditon('prev_off_gcd', function(Unit, Spell)
	return NeP.DSL.Conditions['lastcast'](Unit, Spell)
end)

NeP.DSL.RegisterConditon('prev_gcd', function(Unit, Spell)
	return NeP.DSL.Conditions['lastcast'](Unit, Spell)
end)

NeP.DSL.RegisterConditon('prev', function(Unit, Spell)
	return NeP.DSL.Conditions['lastcast'](Unit, Spell)
end)

NeP.DSL.RegisterConditon('time_to_die', function(target)
	return NeP.DSL.Conditions['deathin'](target)
end)

--/dump NeP.DSL.Conditions['time']('player')
NeP.DSL.RegisterConditon('time', function(target)
	return NeP.DSL.Conditions['combat.time'](target)
end)

NeP.DSL.RegisterConditon('cooldown.remains', function(_, spell)
	if NeP.DSL.Conditions['spell.exists'](_, spell) == true then
		return NeP.DSL.Conditions['spell.cooldown'](_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL.Conditions['charges_fractional']('player','Phoenix\'s Flames')
NeP.DSL.RegisterConditon('action.charges', function(_, spell)
	if NeP.DSL.Conditions['spell.exists'](_, spell) == true then
		return NeP.DSL.Conditions['spell.charges'](_, spell)
	else
		return 0
	end
end)

NeP.DSL.RegisterConditon('charges_fractional', function(_, spell)
	if NeP.DSL.Conditions['spell.exists'](_, spell) == true then
		return NeP.DSL.Conditions['spell.charges'](_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL.Conditions['spell_haste']('player')
NeP.DSL.RegisterConditon('spell_haste', function(target)
	local shaste = NeP.DSL.Conditions['haste'](target)
	return math.floor((100 / ( 100 + shaste )) * 10^3 ) / 10^3
end)

NeP.DSL.RegisterConditon('talent.enabled', function(target, args)
--[[
	local havetalent = NeP.DSL.Conditions['talent'](target, args)
	if havetalent == true then
		return 1
	else
		return 0
	end
--]]
	return NeP.DSL.Conditions['talent'](target, args)
end)

--/dump NeP.DSL.Conditions['action.execute_time']('player','Fireball')
NeP.DSL.RegisterConditon('action.execute_time', function(target, spell)
	return NeP.DSL.Conditions['execute_time'](target, spell)
end)

NeP.DSL.RegisterConditon('execute_time', function(target, spell)
  local GCD = NeP.DSL.Get('gcd')()
  local CTT = NeP.DSL.Conditions['spell.casttime'](_, spell)
		if CTT > GCD then
			return CTT
		else
			return GCD
		end
end)

NeP.DSL.RegisterConditon('deficit', function(target, spell)
	local max = UnitPowerMax(target)
	local curr = UnitPower(target)
	return (max - curr)
end)

NeP.DSL.RegisterConditon('cast_regen', function(target, spell)
	local regen = select(2, GetPowerRegen(target))
	local _, _, _, cast_time = GetSpellInfo(spell)
	return math.floor(((regen * cast_time) / 1000) * 10^3 ) / 10^3
end)

NeP.DSL.RegisterConditon('action.cast_time', function(_, spell)
	if NeP.DSL.Conditions['spell.exists'](_, spell) == true then
		return NeP.DSL.Conditions['spell.casttime'](_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL.Conditions['cast_time']('player','Cinderstorm')
NeP.DSL.RegisterConditon('cast_time', function(_, spell)
	if NeP.DSL.Conditions['spell.exists'](_, spell) == true then
		return NeP.DSL.Conditions['spell.casttime'](_, spell)
	else
		return 0
	end
end)

--/dump NeP.DSL.Conditions['health.pct']('player')
NeP.DSL.RegisterConditon('health.pct', function(target)
	return NeP.DSL.Conditions['health'](target)
end)

NeP.DSL.RegisterConditon('active_enemies', function(unit, distance)
	return NeP.DSL.Conditions['area.enemies'](unit, distance)
end)

--TODO: this is just fake one atm:P dont have real artifact traits check yet
NeP.DSL.RegisterConditon('artifact.enabled', function(_, spell)
	return NeP.DSL.Conditions['spell.exists'](_, spell)
end)

NeP.DSL.RegisterConditon('artifact.equipped', function(_, spell)
	return NeP.DSL.Conditions['spell.exists'](_, spell)
end)
