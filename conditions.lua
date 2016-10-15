local _, Xeer

--------------------------------------------------------------------------------
---------------------------------ARTIFACT---------------------------------------
--------------------------------------------------------------------------------

local LAD = LibStub("LibArtifactData-1.0")

--/dump NeP.DSL:Get('artifact.force_update')()
NeP.DSL:Register('artifact.force_update', function ()
    return LAD.ForceUpdate()
end)

--/dump NeP.DSL:Get('artifact.acquired_power')('artifactID')
NeP.DSL:Register('artifact.acquired_power', function (artifactID)
		local amount_power_acquired = LAD.GetAcquiredArtifactPower(artifactID)
  	return LAD.GetAcquiredArtifactPower(artifactID)
end)

--/dump NeP.DSL:Get('artifact.activeid')()
NeP.DSL:Register('artifact.active_id', function ()
		local artifactID = LAD.GetActiveArtifactID(artifactID)
    return LAD.GetActiveArtifactID()
end)

--/dump NeP.DSL:Get('artifact.get_all_info')()
NeP.DSL:Register('artifact.get_all_info', function ()
    return LAD.GetAllArtifactsInfo()
end)

--/dump NeP.DSL:Get('artifact.info')('artifactID')
NeP.DSL:Register('artifact.info', function (artifactID)
		local artifactID, data = LAD.GetArtifactInfo(artifactID)
    return LAD.GetArtifactInfo(artifactID)
end)

--/dump NeP.DSL:Get('artifact.knowledge')()
NeP.DSL:Register('artifact.knowledge', function ()
		local knowledge_level, knowledge_multiplier = LAD.GetArtifactKnowledge()
		return LAD.GetArtifactKnowledge()
end)

--/dump NeP.DSL:Get('artifact.power')('artifactID')
NeP.DSL:Register('artifact.power', function (artifactID)
    local artifact_id, unspent_power, power, max_power, power_for_next_rank, num_ranks_purchased, num_ranks_purchaseable = LAD.GetArtifactPower(artifactID)
		return LAD.GetArtifactPower(artifactID)
end)

--/dump NeP.DSL:Get('artifact.relics')('artifactID')
NeP.DSL:Register('artifact.relics', function (artifactID)
		local artifactID, data = LAD.GetArtifactRelics(artifactID)
    return LAD.GetArtifactRelics(artifactID)
end)

--/dump NeP.DSL:Get('artifact.traits')(NeP.DSL:Get('artifact.activeid'))
NeP.DSL:Register('artifact.traits', function (artifactID)
		local artifactID, data = LAD.GetArtifactTraits(artifactID)
    return LAD.GetArtifactTraits(artifactID)
end)

--/dump NeP.DSL:Get('artifact.num_obtained')()
NeP.DSL:Register('artifact.num_obtained', function ()
		local numObtained = LAD.GetArtifactKnowledge()
		return LAD.GetNumObtainedArtifacts()
end)

--/dump NeP.DSL:Get('artifact.trait_info')('player', 'Warbreaker')
--/dump NeP.DSL:Get('artifact.trait_info')('player', 'Thoradin\'s Might')
NeP.DSL:Register('artifact.trait_info', function(_, spell)
	local currentRank = 0
			artifactID = NeP.DSL:Get('artifact.active_id')()
			if not artifactID then
					NeP.DSL:Get('artifact.force_update')()
			end
			local _, traits = NeP.DSL:Get('artifact.traits')(artifactID)
			if traits then
					for _,v in ipairs(traits) do
							if v.name == spell then
								return v.isGold, v.bonusRanks, v.maxRank, v.traitID, v.isStart, v.icon, v.isFinal, v.name, v.currentRank, v.spellID
							end
					end
			end
end)

--/dump NeP.DSL:Get('artifact.enabled')('player', 'Warbreaker')
--/dump NeP.DSL:Get('artifact.enabled')('player', 'Thoradin\'s Might')
NeP.DSL:Register('artifact.enabled', function(_, spell)
		if select(10,NeP.DSL:Get('artifact.trait_info')(_, spell)) then
			return true
		else
			return false
		end
end)

NeP.DSL:Register('artifact.equipped', function(_, spell)
	return NeP.DSL:Get('spell.exists')(_, spell)
end)

--------------------------------------------------------------------------------
-----------------------------------MISC-----------------------------------------
--------------------------------------------------------------------------------

--NeP.DSL:Register('equipped', function(target, item)
--	if IsEquippedItem(item) == true then return true else return false end
--end)

--/dump NeP.DSL:Get('casting.left')('player', 'Fireball')
NeP.DSL:Register('casting.left', function(target, spell)
	local reverse = NeP.DSL:Get('casting.percent')(target, spell)
	if reverse ~= 0 then
	return 100 - reverse
	end
return 0
end)

--------------------------------------------------------------------------------
--------------------------------SIMC STUFFS-------------------------------------
--------------------------------------------------------------------------------

NeP.DSL:Register('xmoving', function()
	local speed, _ = GetUnitSpeed('player')
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
	local costText = Xeer.Scan_SpellCost(spell)
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

--/dump NeP.DSL:Get('dot.duration')('target','Rip')
NeP.DSL:Register('dot.duration', function(target, spell)
	local debuff,_,duration,expires,caster = Xeer.UnitDot(target, spell, _)
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
NeP.DSL:Register('prev_off_gcd', function(_, Spell)
	return NeP.DSL:Get('lastcast')('player', Spell)
end)

--/dump NeP.DSL:Get('prev_gcd')('player', 'Thrash')
NeP.DSL:Register('prev_gcd', function(_, Spell)
	return NeP.DSL:Get('lastcast')('player', Spell)
end)

--/dump NeP.DSL:Get('prev')('player', 'Thrash')
NeP.DSL:Register('prev', function(_, Spell)
	return NeP.DSL:Get('lastcast')('player', Spell)
end)

--/dump NeP.DSL:Get('time_to_die')('target')
NeP.DSL:Register('time_to_die', function(target)
	return NeP.DSL:Get('deathin')(target)
end)

--/dump NeP.DSL:Get('time')('player')
NeP.DSL:Register('time', function(target)
	return NeP.DSL:Get('combat.time')(target)
end)

--/dump NeP.DSL:Get('cooldown.remains')('player','Combustion')
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

--/dump NeP.DSL:Get('spell_haste')()
NeP.DSL:Register('spell_haste', function()
	local shaste = NeP.DSL:Get('haste')('player')
	return math.floor((100 / ( 100 + shaste )) * 10^3 ) / 10^3
end)

--/dump NeP.DSL:Get('action.execute_time')('player','Fireball')
NeP.DSL:Register('action.execute_time', function(_, spell)
	return NeP.DSL:Get('execute_time')(_, spell)
end)

NeP.DSL:Register('execute_time', function(_, spell)
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
NeP.DSL:Register('max_energy', function()
	 local ttm = NeP.DSL:Get('energy.time_to_max')()
	 local GCD = NeP.DSL:Get('gcd')()
	 if GCD > ttm then
		 return 1
	 else
		 return false
	 end
end)

--/dump NeP.DSL:Get('energy.deficit')('player')
NeP.DSL:Register('energy.deficit', function()
	return NeP.DSL:Get('deficit')('player')
end)

--/dump NeP.DSL:Get('energy.regen')('player')
NeP.DSL:Register('energy.regen', function()
	local eregen = select(2, GetPowerRegen('player'))
	return eregen
end)

--/dump NeP.DSL:Get('energy.time_to_max')('player')
NeP.DSL:Register('energy.time_to_max', function()
	local deficit = NeP.DSL:Get('deficit')('player')
	local eregen = NeP.DSL:Get('energy.regen')('player')
	return deficit / eregen
end)

--/dump NeP.DSL:Get('focus.deficit')('player')
NeP.DSL:Register('focus.deficit', function()
	return NeP.DSL:Get('deficit')('player')
end)

--/dump NeP.DSL:Get('focus.regen')('player')
NeP.DSL:Register('focus.regen', function()
	local fregen = select(2, GetPowerRegen('player'))
	return fregen
end)

--/dump NeP.DSL:Get('focus.time_to_max')()
NeP.DSL:Register('focus.time_to_max', function()
	local deficit = NeP.DSL:Get('deficit')('player')
	local fregen = NeP.DSL:Get('focus.regen')('player')
	return deficit / fregen
end)


--/dump NeP.DSL:Get('rage.deficit')('player')
NeP.DSL:Register('rage.deficit', function()
	return NeP.DSL:Get('deficit')('player')
end)

--/dump NeP.DSL:Get('runic_power')()
NeP.DSL:Register('runic_power', function()
	return NeP.DSL:Get('runicpower')('player')
end)

--/dump NeP.DSL:Get('holy_power')()
NeP.DSL:Register('holy_power', function()
	return NeP.DSL:Get('holypower')('player')
end)

--/dump NeP.DSL:Get('action.cast_time')('player','Revenge')
NeP.DSL:Register('action.cast_time', function(_, spell)
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

--------------------------------------------------------------------------------
---------------------------------PROT WAR---------------------------------------
--------------------------------------------------------------------------------

--UnitBuff(Unit,GetSpellInfo(SpellID))
--/dump GetSpellInfo(190456)
--/dump UnitBuff('player',GetSpellInfo(190456))

--/dump NeP.DSL:Get('ignorepain_cost')()
NeP.DSL:Register('ignorepain_cost', function()
	return Xeer.Scan_IgnorePain()
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


--------------------------------------------------------------------------------
---------------------------------FERAL------------------------------------------
--------------------------------------------------------------------------------

local DotTicks = {
    [1] = {
        [1822] = 3,
        [1079] = 2,
        [106832] = 3,
    },
    [2] = {
				[8921] = 2,
        [155625] = 2,
    }
}

NeP.DSL:Register('dot.tick_time', function(_,spell)
    local spell = NeP.Core:GetSpellID(spell)
    local class = select(3,UnitClass('player'))
    if class == 11 and GetSpecialization() == 2 then
        if NeP.DSL:Get('talent')(nil, '6,2') and DotTicks[1][spell] then
            return DotTicks[1][spell] * 0.67
        else
            if DotTicks[1][spell] then
                return DotTicks[1][spell]
            else
                local tick = DotTicks[2][spell]
                return math.floor((tick / ((GetHaste() / 100) + 1)) * 10^3 ) / 10^3
            end
        end
    end
end)

--/dump NeP.DSL:Get('gcd')()
--/dump NeP.DSL:Get('dot.x')('target', 'Moonfire')
--/dump NeP.DSL:Get('dot.tick_time')('Moonfire')

--/dump NeP.Core:GetSpellID('Rip')
--/dump select(8, UnitDebuff('target', GetSpellInfo(NeP.Core:GetSpellID(NeP.Core:GetSpellName('Rip')))))
--/dump select(6, UnitDebuff('target', GetSpellInfo(NeP.Core:GetSpellID(NeP.Core:GetSpellName('Rip')))))
