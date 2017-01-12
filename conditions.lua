local _, Xeer = ...

--------------------------------------------------------------------------------
---------------------------------ARTIFACT---------------------------------------
--------------------------------------------------------------------------------

local LAD = LibStub('LibArtifactData-1.0')

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

--/dump NeP.DSL:Get('artifact.enabled')('player', 'Shredder Fangs')
--/dump NeP.DSL:Get('artifact.enabled')('player', 'Thoradin\'s Might')
NeP.DSL:Register('artifact.enabled', function(_, spell)
    if select(10,NeP.DSL:Get('artifact.trait_info')(_, spell)) then
        return 1
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('artifact.rank')('player', 'Shredder Fangs')
NeP.DSL:Register('artifact.rank', function(_, spell)
    local rank = select(9,NeP.DSL:Get('artifact.trait_info')(_, spell))
    if rank then
        return rank
    else
        return 0
    end
end)

NeP.DSL:Register('artifact.equipped', function(_, spell)
    return NeP.DSL:Get('spell.exists')(_, spell)
end)

--------------------------------------------------------------------------------
-----------------------------------MISC-----------------------------------------
--------------------------------------------------------------------------------

--NeP.DSL:Register('equipped', function(target, item)
-- if IsEquippedItem(item) then return true else return false end
--end)

--/dump NeP.DSL:Get('casting.left')('player', 'Fireball')
NeP.DSL:Register('casting.left', function(target, spell)
    local reverse = NeP.DSL:Get('casting.percent')(target, spell)
    if reverse ~= 0 then
        return 100 - reverse
    end
    return 0
end)

--/dump NeP.DSL:Get('pet_range')()
NeP.DSL:Register('pet_range', function()
    return NeP.DSL:Get('petrange')('target')
end)



--/dump NeP.DSL:Get('indoors')()
NeP.DSL:Register('indoors', function()
    return IsIndoors()
end)
--------------------------------------------------------------------------------
--------------------------------SIMC STUFFS-------------------------------------
--------------------------------------------------------------------------------

NeP.DSL:Register('xmoving', function()
    local speed = GetUnitSpeed('player')
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

--/dump NeP.DSL:Get('action.cost')(nil,'Rake')
--/dump NeP.DSL:Get('action.cost')(nil, 'Rejuvenation')
NeP.DSL:Register('action.cost', function(_, spell)
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

--/dump NeP.DSL:Get('dot.refreshable')('target','Nightblade')
NeP.DSL:Register('dot.refreshable', function(_, spell)
    local _,_,_,_,_,duration,expires,_,_,_,spellID = UnitDebuff('target', spell, nil, 'PLAYER|HARMFUL')
    if spellID and expires then
        local time_left = expires - GetTime()
        if time_left < (duration/3) then
            return true
        end
    end
    return false
end)

--/dump NeP.DSL:Get('dot.duration')('target','Doom')
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

--/dump NeP.DSL:Get('buff.up')('player','Incanter\'s Flow')
--/dump NeP.DSL:Get('buff')('player','Rejuvenation')
--/dump NeP.DSL:Get('debuff')('target','Sunfire')
NeP.DSL:Register('buff.up', function(target, spell)
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

--/dump NeP.DSL:Get('buff.remains')('pet','Demonic Empowerment')
NeP.DSL:Register('buff.remains', function(target, spell)
    return NeP.DSL:Get('buff.duration')(target, spell)
end)

NeP.DSL:Register('debuff.up', function(target, spell)
    local x = NeP.DSL:Get('debuff.count')(target, spell)
    if x == 1 then
        return true
    elseif x == 0 then
        return false
    else
        return x
    end
end)

--/dump NeP.DSL:Get('debuff.stack')('target','Thrash')
NeP.DSL:Register('debuff.stack', function(target, spell)
    return NeP.DSL:Get('debuff.count')(target, spell)
end)

--/dump UnitDebuff('target', 'Thrash')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Thrash')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Rake')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Rip')
--/dump NeP.DSL:Get('debuff.remains')('target', 'Moonfire')
NeP.DSL:Register('debuff.remains', function(target, spell)
    return NeP.DSL:Get('debuff.duration')(target, spell)
end)

--TODO: work out off gcd/gcd only skills now all of this is just like SiMC 'prev'

--/dump NeP.DSL:Get('prev_off_gcd')('player', 'Water Jet')
NeP.DSL:Register('prev_off_gcd', function(_, spell)
    return NeP.DSL:Get('lastcast')('player', spell)
end)

--/dump NeP.DSL:Get('prev_gcd')(nil, 'Shadowstrike')
--/dump NeP.DSL:Get('lastcast')('player', 'Fireball')
NeP.DSL:Register('prev_gcd', function(_, spell)
    return NeP.DSL:Get('lastgcd')('player', spell)
end)

--/dump NeP.DSL:Get('prev')('player', 'Thrash')
NeP.DSL:Register('prev', function(_, spell)
    return NeP.DSL:Get('lastcast')('player', spell)
        --end
end)

--/dump NeP.DSL:Get('time_to_die')('target')
NeP.DSL:Register('time_to_die', function(target)
    return NeP.DSL:Get('deathin')(target)
end)

--/dump NeP.DSL:Get('xtime')()
NeP.DSL:Register('xtime', function()
    return NeP.DSL:Get('combat.time')('player')
end)

--/dump NeP.DSL:Get('spell.cooldown')('player', '61304')
--/dump NeP.DSL:Get('cooldown.remains')('player','Mind Blast')
NeP.DSL:Register('cooldown.remains', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('spell.exists')('player','Vanish')
--/dump NeP.DSL:Get('cooldown.up')('player','Vanish')
--/dump NeP.DSL:Get('spell.cooldown')('player','Vanish')
NeP.DSL:Register('cooldown.up', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        if NeP.DSL:Get('spell.cooldown')(_, spell) == 0 then
            return true
        end
    else
        return false
    end
end)

--/dump GetSpellCooldown(61304)
--/dump GetSpellCharges(108853)
--/dump GetSpellCharges(116011)
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Fire Blast')
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Rune of Power')
--/dump NeP.DSL:Get('action.cooldown_to_max')('player','Frost Nova')
--/dump NeP.DSL:Get('spell.recharge')('player','Fire Blast')
--/dump NeP.DSL:Get('spell.charges')('player','Fire Blast')
NeP.DSL:Register('action.cooldown_to_max', function(_, spell)
    local charges, maxCharges, start, duration = GetSpellCharges(spell)
    if duration and charges ~= maxCharges then
        charges_to_max = maxCharges - ( charges + ((GetTime() - start) / duration))
        cooldown = duration * charges_to_max
        return cooldown
    else
        return 0
    end
end)

--/dump GetSpellBaseCooldown(61304)
--return GetSpellBaseCooldown(spellID) / 1000
--/dump NeP.DSL:Get('action.cooldown')('player','Fire Blast')
NeP.DSL:Register('action.cooldown', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.cooldown')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('action.charges')('player','Fire Blast')
NeP.DSL:Register('action.charges', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('cooldown.charges')('player','Fire Blast')
NeP.DSL:Register('cooldown.charges', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.charges')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('cooldown.recharge_time')('player','Fire Blast')
NeP.DSL:Register('cooldown.recharge_time', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
        return NeP.DSL:Get('spell.recharge')(_, spell)
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('charges_fractional')('player','Phoenix\'s Flames')
NeP.DSL:Register('charges_fractional', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
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

--/dump NeP.DSL:Get('gcd.remains')()
NeP.DSL:Register('gcd.remains', function()
    return NeP.DSL:Get('spell.cooldown')('player', '61304')
end)

--/dump NeP.DSL:Get('gcd.max')()
NeP.DSL:Register('gcd.max', function()
    return NeP.DSL:Get('gcd')()
end)

--/dump NeP.DSL:Get('action.execute_time')('player','Aimed Shot')
--/dump NeP.DSL:Get('action.execute_time')('player','Shadow Bolt')

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

--/dump NeP.DSL:Get('deficit')()
NeP.DSL:Register('deficit', function()
    local max = UnitPowerMax('player')
    local curr = UnitPower('player')
    return (max - curr)
end)

--/dump NeP.DSL:Get('energy.deficit')()
NeP.DSL:Register('energy.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('focus.deficit')()
NeP.DSL:Register('focus.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('rage.deficit')()
NeP.DSL:Register('rage.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('astral_power.deficit')()
NeP.DSL:Register('astral_power.deficit', function()
    return NeP.DSL:Get('deficit')()
end)

--/dump NeP.DSL:Get('combo_points.deficit')()
NeP.DSL:Register('combo_points.deficit', function(target)
    return (UnitPowerMax('player', SPELL_POWER_COMBO_POINTS)) - (UnitPower('player', SPELL_POWER_COMBO_POINTS))
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

--/dump NeP.DSL:Get('mana.pct')()
NeP.DSL:Register('mana.pct', function()
    return NeP.DSL:Get('mana')('player')
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

--/dump NeP.DSL:Get('energy.regen')()
NeP.DSL:Register('energy.regen', function()
    local eregen = select(2, GetPowerRegen('player'))
    return eregen
end)

--/dump NeP.DSL:Get('energy.time_to_max')()
NeP.DSL:Register('energy.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local eregen = NeP.DSL:Get('energy.regen')()
    return deficit / eregen
end)

--/dump NeP.DSL:Get('focus.regen')()
NeP.DSL:Register('focus.regen', function()
    local fregen = select(2, GetPowerRegen('player'))
    return fregen
end)

--/dump NeP.DSL:Get('focus.time_to_max')()
NeP.DSL:Register('focus.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local fregen = NeP.DSL:Get('focus.regen')('player')
    return deficit / fregen
end)

--/dump NeP.DSL:Get('astral_power')()
NeP.DSL:Register('astral_power', function()
    return NeP.DSL:Get('lunarpower')('player')
end)

--/dump NeP.DSL:Get('runic_power')()
NeP.DSL:Register('runic_power', function()
    return NeP.DSL:Get('runicpower')('player')
end)

--/dump NeP.DSL:Get('holy_power')()
NeP.DSL:Register('holy_power', function()
    return NeP.DSL:Get('holypower')('player')
end)

--/dump NeP.DSL:Get('action.cast_time')('player','Frostbolt')
NeP.DSL:Register('action.cast_time', function(_, spell)
    if NeP.DSL:Get('spell.exists')(_, spell) then
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

--/dump NeP.DSL:Get('talent.enabled')(nil, '4,2')
NeP.DSL:Register('talent.enabled', function(_, x,y)
    if NeP.DSL:Get('talent')(_, x,y) then
        return 1
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('xequipped')(2575)
NeP.DSL:Register('xequipped', function(item)
    if IsEquippedItem(item) then
        return 1
    else
        return 0
    end
end)

--/dump NeP.DSL:Get('line_cd')(_, 'Cobra Shot')
NeP.DSL:Register('line_cd', function(_, spell)
    local spellID = NeP.Core:GetSpellID(spell)
    if Xeer.spell_timers[spellID] then
        return GetTime() - Xeer.spell_timers[spellID].time
    end
    return 0
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
    if hasTalent(5,2) then
        return NeP.Core.Round((((77.86412474516502 * 1.70) * ss) / 100))
    else
        return NeP.Core.Round(((77.86412474516502 * ss) / 100))
    end
end)

--heistcodes revenge procc tracker
local Revenge = false
	NeP.Listener:Add('RevengeProcStart', 'SPELL_ACTIVATION_OVERLAY_GLOW_SHOW', function(spellID)
		if spellID == 6572 then
			Revenge = true
		end
	end)

	NeP.Listener:Add('RevengeProcStop', 'SPELL_ACTIVATION_OVERLAY_GLOW_HIDE', function(spellID)
		if spellID == 6572 then
			Revenge = false
		end
	end)

	NeP.DSL:Register("revengeproc", function()
		return Revenge
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
    },
    [3] = {
        [195452] = 2,
    },
}

--/dump NeP.DSL:Get('dot.tick_time')(_, 'Moonfire')
NeP.DSL:Register('dot.tick_time', function(_, spell)
    local spell = NeP.Core:GetSpellID(spell)
    if not spell then return end
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
    else
        return DotTicks[3][spell]
    end
end)

--/dump NeP.DSL:Get('dot.pmultiplier')(nil, 'Rip')
NeP.DSL:Register('dot.pmultiplier', function(_, spell)
    local GUID = UnitGUID('target')
    local name = string.lower(spell)
    if Xeer.f_Snapshots[name][GUID] then
      return Xeer.f_Snapshots[name][GUID]
    else
      return 0
    end
end)

--/dump NeP.DSL:Get('persistent_multiplier')(nil, 'Rip')
NeP.DSL:Register('persistent_multiplier', function(_, spell)
  local name = string.lower(spell)
  if Xeer.f_Snapshots[name].current then
    return Xeer.f_Snapshots[name].current
  else
    return 1
  end
end)

--/dump NeP.DSL:Get('f_test')()
NeP.DSL:Register('f_test', function()
  return Xeer.f_Snapshots
end)

--------------------------------------------------------------------------------
--------------------------------WARLOCK-----------------------------------------
--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('warlock.remaining_duration')('Dreadstalker')
--/dump NeP.DSL:Get('warlock.remaining_duration')('Wild Imp')
NeP.DSL:Register('warlock.remaining_duration', function(demon)
    return Xeer.remaining_duration(demon)
end)

--/dump NeP.DSL:Get('warlock.empower')()
NeP.DSL:Register('warlock.empower', function()
    return Xeer.Empower()
end)

--/dump NeP.DSL:Get('warlock.count')('Wild Imp')
NeP.DSL:Register('warlock.count', function(demon)
    return Xeer.count_active_demon_type(demon)
end)

--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('warlock.active_pets_list')()
NeP.DSL:Register('warlock.active_pets_list', function()
    return Xeer.active_demons
end)

--/dump NeP.DSL:Get('warlock.sorted_pets_list')()
NeP.DSL:Register('warlock.sorted_pets_list', function()
    return Xeer.demons_sorted
end)

--/dump NeP.DSL:Get('warlock.demon_count')()
NeP.DSL:Register('warlock.demon_count', function()
    return Xeer.demon_count
end)

--GetNotDemonicEmpoweredDemonsCount
--/dump NeP.DSL:Get('warlock.no_de')()
--NeP.DSL:Register('warlock.no_de', function(demon)
-- return Xeer.Empower_no_de(demon)
--end)

--/dump NeP.DSL:Get('soul_shard')()
NeP.DSL:Register('soul_shard', function()
    return NeP.DSL:Get('soulshards')('player')
end)

--------------------------------------------------------------------------------
-------------------------------- PRIEST ----------------------------------------
--------------------------------------------------------------------------------

--actions+=/variable,op=set,name=actors_fight_time_mod,value=0
--actions+=/variable,op=set,name=actors_fight_time_mod,value=-((-(450)+(time+target.time_to_die))%10),if=time+target.time_to_die>450&time+target.time_to_die<600
--actions+=/variable,op=set,name=actors_fight_time_mod,value=((450-(time+target.time_to_die))%5),if=time+target.time_to_die<=450
--actions+=/variable,op=set,name=s2mcheck,value=0.8*(45+((raw_haste_pct*100)*(2+(1*talent.reaper_of_souls.enabled)+(2*artifact.mass_hysteria.rank)-(1*talent.sanlayn.enabled))))-(variable.actors_fight_time_mod*nonexecute_actors_pct)
--actions+=/variable,op=min,name=s2mcheck,value=180

--/dump NeP.DSL:Get('variable.actors_fight_time_mod')()
NeP.DSL:Register('variable.actors_fight_time_mod', function()
    local time = NeP.DSL:Get('xtime')()
    local target_time_to_die = NeP.DSL:Get('time_to_die')('target')
    -- time+target.time_to_die>450&time+target.time_to_die<600
    if (time + target_time_to_die) > 450 and (time + target_time_to_die) < 600 then
        -- -((-(450)+(time+target.time_to_die))%10)
        return -(( -(450) +( time + target_time_to_die)) / 10)
            -- time+target.time_to_die<=450
    elseif time + target_time_to_die <= 450 then
        -- ((450-(time+target.time_to_die))%5)
        return ((450 - (time + target_time_to_die)) / 5)
    else
        return 0
    end
end)

NeP.DSL:Register('variable.s2mcheck_min', function()
    return 180
end)

NeP.DSL:Register('variable.s2mcheck_value', function()
    local sanlayn = 0
    local reaper_of_souls = 0
    local actors_fight_time_mod = NeP.DSL:Get('variable.actors_fight_time_mod')()
    local raw_haste_pct = UnitSpellHaste('player')
    local mass_hysteria = NeP.DSL:Get('artifact.rank')('player', 'Mass Hysteria')

    if NeP.DSL:Get('talent')(nil, '5,1') then
        sanlayn = 1
    else
        sanlayn = 0
    end

    if NeP.DSL:Get('talent')(nil, '4,2') then
        reaper_of_souls = 1
    else
        reaper_of_souls = 0
    end

    --local value = 0.8*(105+((raw_haste_pct*50)*(2+(1*talent.reaper_of_souls.enabled)+(2*artifact.mass_hysteria.rank)-(1*talent.sanlayn.enabled))))-(variable.actors_fight_time_mod*nonexecute_actors_pct)
    local value = 0.8 * (105 + ((raw_haste_pct * 50) * (2 + (1 * reaper_of_souls) + (2 * mass_hysteria) - (1 * sanlayn)))) - (actors_fight_time_mod * 0)
    --local value = 0.8 * { 105 + raw_haste_pct * 50 * { 2 + 1 * reaper_of_souls + 2 * mass_hysteria - 1 * sanlayn } } - actors_fight_time_mod * 0
    return value
end)

--/dump NeP.DSL:Get('variable.s2mcheck')()
NeP.DSL:Register('variable.s2mcheck', function()
    if NeP.DSL:Get('variable.s2mcheck_value')() > 180 then
        return NeP.DSL:Get('variable.s2mcheck_value')()
    else
        return 180
    end
end)

--/dump NeP.DSL:Get('shadowy_apparitions_in_flight')()
NeP.DSL:Register('shadowy_apparitions_in_flight', function()
    local x = Xeer.SA_TOTAL
    return x
end)

NeP.DSL:Register('parser_bypass1', function()
    --player.insanity-current_insanity_drain*gcd.max
    local x = (NeP.DSL:Get('insanity')('player') - (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')()))
    return x
end)

--/dump NeP.DSL:Get('insanity_drain_stacks')()
NeP.DSL:Register('insanity_drain_stacks', function()
    local x = Xeer.Voidform_Drain_Stacks
    return x
end)

--/dump NeP.DSL:Get('current_insanity_drain')()
NeP.DSL:Register('current_insanity_drain', function()
    local x = Xeer.Voidform_Current_Drain_Rate
    return x
end)

--{current_insanity_drain*gcd.max>player.insanity}&{player.insanity-{current_insanity_drain*gcd.max}+90}<100
--/dump (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')()) > NeP.DSL:Get('insanity')('player')
--/dump (NeP.DSL:Get('insanity')('player') - (NeP.DSL:Get('current_insanity_drain')() * NeP.DSL:Get('gcd.max')()) + 90) < 100

--------------------------------------------------------------------------------
--------------------------------- ROGUE ----------------------------------------
--------------------------------------------------------------------------------

NeP.DSL:Register('parser_bypass2', function()
    local x = NeP.DSL:Get('xtime')()
    if x < 10 then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('parser_bypass3', function()
    local x = NeP.DSL:Get('xtime')()
    if x >= 10 then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('stealthed', function()
    if NeP.DSL:Get('buff')('player', 'Shadow Dance') or NeP.DSL:Get('buff')('player', 'Stealth') or NeP.DSL:Get('buff')('player', 'Subterfuge') or NeP.DSL:Get('buff')('player', 'Shadowmeld') or NeP.DSL:Get('buff')('player', 'Prowl') then
        return true
    else
        return false
    end
end)
--/dump NeP.DSL:Get('variable.ssw_er')()
NeP.DSL:Register('variable.ssw_er', function()
    --actions=variable,name=ssw_er,value=equipped.shadow_satyrs_walk*(10+floor(target.distance*0.5))
    local range_check
    if NeP.DSL:Get('range')('target') then
        range_check = NeP.DSL:Get('range')('target')
    else
        range_check = 0
    end
    local x = (NeP.DSL:Get('xequipped')('137032') * (10 + (range_check * 0.5)))
    return x
end)

--/dump NeP.DSL:Get('variable.ed_threshold')()
NeP.DSL:Register('variable.ed_threshold', function()
    --actions+=/variable,name=ed_threshold,value=energy.deficit<=(20+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+variable.ssw_er)
    local x = (NeP.DSL:Get('energy.deficit')() <= ((20 + NeP.DSL:Get('talent.enabled')(nil, '3,3')) * (35 + NeP.DSL:Get('talent.enabled')(nil, '7,1')) * (25 + NeP.DSL:Get('variable.ssw_er')())))
    return x
end)

NeP.DSL:Register('RtB', function()
    local int = 0
    local bearing = false
    local shark = false

    -- Shark Infested Waters
    if UnitBuff('player', GetSpellInfo(193357)) then
        shark = true
        int = int + 1
    end

    -- True Bearing
    if UnitBuff('player', GetSpellInfo(193359)) then
        bearing = true
        int = int + 1
    end

    -- Jolly Roger
    if UnitBuff('player', GetSpellInfo(199603)) then
        int = int + 1
    end

    -- Grand Melee
    if UnitBuff('player', GetSpellInfo(193358)) then
        int = int + 1
    end

    -- Buried Treasure
    if UnitBuff('player', GetSpellInfo(199600)) then
        int = int + 1
    end

    -- Broadsides
    if UnitBuff('player', GetSpellInfo(193356)) then
        int = int + 1
    end

    -- If all six buffs are active:
    if int == 6 then
        return true --"LEEEROY JENKINS!"

            -- If two or Shark/Bearing and AR/Curse active:
    elseif int == 2 or int == 3 or ((bearing or shark) and ((UnitBuff("player", GetSpellInfo(13750)) or UnitDebuff("player", GetSpellInfo(202665))))) then
        return true --"Keep."

            --[[
      -- If only True Bearing
    elseif bearing then
      return true --"Keep. AR/Curse if ready."
      --]]

            -- If only Shark or True Bearing and CDs ready
    elseif (bearing or shark) and ((GetSpellCooldown(13750) == 0) or (GetSpellCooldown(202665) == 0)) then
        return true --"AR/Curse NOW and keep!"

            --if we have only ONE bad buff BUT AR/curse is active:
    elseif int ==1 and ((UnitBuff("player", GetSpellInfo(13750)) or UnitDebuff("player", GetSpellInfo(202665)))) then
        return true

            -- If only one bad buff:
    else return false --"Reroll now!"
    end
end)

--------------------------------------------------------------------------------
--------------------------------- HUNTER ---------------------------------------
--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('variable.safe_to_build')()
--actions+=/variable,name=safe_to_build,value=debuff.hunters_mark.down|(buff.trueshot.down&buff.marking_targets.down)
NeP.DSL:Register('variable.safe_to_build', function()
    local x = NeP.DSL:Get('debuff')('target','Hunter\'s Mark')
    local y = NeP.DSL:Get('buff')('player','Trueshot')
    local z = NeP.DSL:Get('buff')('player','Marking Targets')
    if x == nil or (y == nil and z == nil) then
        return true
    end
    return false
end)

--/dump NeP.DSL:Get('variable.use_multishot')()
--actions+=/variable,name=use_multishot,value=((buff.marking_targets.up|buff.trueshot.up)&spell_targets.multishot>1)|(buff.marking_targets.down&buff.trueshot.down&spell_targets.multishot>2)
NeP.DSL:Register('variable.use_multishot', function()
    local x = NeP.DSL:Get('buff')('player','Marking Targets')
    local y = NeP.DSL:Get('buff')('player','Trueshot')
    local z = NeP.DSL:Get('area.enemies')('target','8')
    if ((x or y) and z >= 1) or (x == nil and y == nil and z >= 2) then
        return true
    end
    return false
end)

--------------------------------------------------------------------------------
---------------------------------- WIP -----------------------------------------
--------------------------------------------------------------------------------

--/dump NeP.DSL:Get('travel_time')('target','Frostbolt')
NeP.DSL:Register('travel_time', function(unit, spell)
    return Xeer.TravelTime(unit, spell)
end)

--[[
--/dump NeP.DSL:Get('tttlz')()
NeP.DSL:Register('tttlz', function()
    return Xeer.TTTL_table
  end)

--/dump NeP.DSL:Get('dist')('player', 'target')
NeP.DSL:Register('dist', function(unit1, unit2)
    return Xeer.ComputeDistance(unit1, unit2)
  end)

--/dump NeP.DSL:Get('tttlz.wipe')()
NeP.DSL:Register('tttlz.wipe', function()
    return wipe(Xeer.TTTL_table)
  end)
--]]

--------------------------------------------------------------------------------
-------------------------------- GABBZ_START -----------------------------------
--------------------------------------------------------------------------------

--your stuffs here, for now

--------------------------------------------------------------------------------
-------------------------------- GABBZ_END -------------------------------------
--------------------------------------------------------------------------------
