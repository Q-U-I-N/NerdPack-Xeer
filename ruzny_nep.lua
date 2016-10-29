Ðæn

/reflux switch LeilaUI --> Priest/Schaman/Rogue/Mage/Hunter/WL
/reflux switch LeilaUI-d --> Druid/Paladin
/reflux switch LeilaUI-m --> Warrior/DeathKnight/Monk


{'', ''},\r\n \t--actions

\t{'', ''},\r\n \t--actions



\t{'', ''},\n\n \t--actions.




------------------------------------
------------trash lock --------------
Xeer.timerNumber = 1


function Xeer.customText()
    if (Xeer ~= nil and Xeer.sorted_demon_count >= Xeer.timerNumber) then

        return ("%.01fs"):format(Xeer.get_remaining_time(Xeer.demons_sorted[Xeer.timerNumber].name, Xeer.demons_sorted[Xeer.timerNumber].time))
    end
    return 0
end

--id = "minion_timer_1"

custom_duration_trigger =function()
    if (Xeer ~= nil and Xeer.sorted_demon_count >= Xeer.timerNumber) then
        Xeer.name = Xeer.demons_sorted[Xeer.timerNumber].name
        Xeer.counter = Xeer.demons_sorted[Xeer.timerNumber].counter
        return true
    end
end

function Xeer.customDuration()
    if (Xeer ~= nil and Xeer.demons_sorted[Xeer.timerNumber] ~= nil) then
        return Xeer.get_remaining_time(Xeer.demons_sorted[Xeer.timerNumber].name, Xeer.demons_sorted[Xeer.timerNumber].time), Xeer.durations[Xeer.name], true
    end
end

customName = function()
    return Xeer.name .. " (" .. Xeer.counter .. ")"
end

untrigger_custom = function(event)
    if (Xeer ~= nil and Xeer.sorted_demon_count <= Xeer.timerNumber - 1) then
        return true
    end
end

customIcon = function()
    if (Xeer.demons_sorted[Xeer.timerNumber] ~= nil) then
        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Wild Imp") then
            return "Interface\\\\Icons\\\\ability_warlock_impoweredimp"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Dreadstalker") then
            return "Interface\\\\Icons\\\\spell_warlock_calldreadstalkers"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Imp") then
            return "Interface\\\\Icons\\\\spell_shadow_summonimp"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Felhunter") then
            return "Interface\\\\Icons\\\\spell_shadow_summonfelhunter"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Darkglare") then
            return "Interface\\\\Icons\\\\achievement_boss_durumu"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Infernal") then
            return "Interface\\\\Icons\\\\spell_shadow_summoninfernal"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Doomguard") then
            return "Interface\\\\Icons\\\\warlock_summon_doomguard"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Felguard") then
            return "Interface\\\\Icons\\\\spell_shadow_summonfelguard"
        end

        if (Xeer.demons_sorted[Xeer.timerNumber].name == "Succubus") then
            return "Interface\\\\Icons\\\\spell_shadow_summonsuccubus"
        end

    end
    return "Interface\\\\Icons\\\\ability_monk_legsweep"
end


----------------------------------------------------------------------------------------------------------------------------------------------------------

-----travel_time is the timespan, in seconds, the spell will need to reach its target (a fireball for example).

-- List of know spells travel speed. Non charted spells will be considered traveling 40 yards/s
-- To recover travel speed, open up /eventtrace, calculate difference between SPELL_CAST_SUCCESS and SPELL_DAMAGE events
local TravelSpeedChart = {
	[116] = 25, -- Frostbolt
	[11366] = 52, -- Pyroblast
	[29722] = 18, -- Incinerate
	[30455] = 39, -- Ice Lance
	[105174] = 33, -- Hand of Gul'dan
	[120644] = 10, -- Halo
	[122121] = 25, -- Divine Star
	[127632] = 19 -- Cascade
};

-- Return the time a spell will need to travel to the current target
function Xeer.TravelTime()
	TravelSpeed = TravelSpeedChart[self.Identifier] or 40;
	return NeP.DSL:Get("distance")(target) / TravelSpeed;
end
----------------------------------------------------------------------------------------------------------------------------------------------------------







NeP.DSL:Register("talent", function(_, args)
	local row, col = strsplit(",", args, 2)
	local group = GetActiveSpecGroup()
	local talentId, talentName, icon, selected, active = GetTalentInfo(row, col, group)
	if active and selected then
   	return true
	end
		return false
end)

{'Holy Light', {'lowest(tank).health < 101', '!player.ismoving'}, 'lowest(tank)'},
    {'Holy Light', {'player.health < 101', '!player.ismoving'}, 'player'},


local dToggles = {
	{
		key = 'mastertoggle',
		name = 'MasterToggle',
		text = 'THIS IS A TOOLTIP!',
		icon = 'Interface\\ICONS\\Ability_repair.png',
		func = function(self, button)
			if button == "RightButton" then
				if IsControlKeyDown() then
					NeP.Interface.MainFrame.drag:Show()
				else
					NeP.Interface:DropMenu()
				end
			end
		end
	},
	{
		key = 'interrupts',
		name = 'Interrupts',
		icon = 'Interface\\ICONS\\Ability_Kick.png',
	},
	{
		key = 'cooldowns',
		name = 'Cooldowns',
		icon = 'Interface\\ICONS\\Achievement_BG_winAB_underXminutes.png',
	},
	{
		key = 'aoe',
		name = 'Multitarget',
		icon = 'Interface\\ICONS\\Ability_Druid_Starfall.png',
	}
}



https://discord.gg/wvj7Jm8
-------------------------------------------------------------------------------
## Title: |r[|cff0070deNerdPack|r]
## Notes: NerdPack custom engine.
## Interface: 70000
## Author: MrTheSoulz
## SavedVariablesPerCharacter: nDavG

files.xml
bindings.xml
then add bindings.xml
<Bindings>
    <Binding name="MASTERTOGGLE" description="Toggle ON/OFF" header="MTS">
        NeP.Interface.toggleToggle('MasterToggle', rest)
    </Binding>
</Bindings>(edited)
it works perfectly for me
shift x toggles the addon on then off
i set it as a keybinf
-------------------------------------------------------------------------------


/dump NeP.DSL:Get("spell.charges")(nil, 'Intercept')
/dump NeP.DSL.Conditions['spell.charges']('player','Fire Blast')


--------------------------------------------------------------------------------
--/dump NeP.Tooltip:Scan_Debuff('target', 'Deep Wounds')
--/dump NeP.Tooltip:Tick_Time2('target', 'Deep Wounds')
function NeP.Tooltip:Tick_Time2(target, spell)
	for i = 1, 40 do
    self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
    self.frame:SetUnitDebuff(target, i)
    local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
    local match = tooltipText:lower():match("every ([0-9]+%.?[0-9]*)")
    return tonumber(match)
	end
	return false
end


function NeP.Tooltip:Tick_Time(target)
    self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
    self.frame:SetUnitBuff(target)
    local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
    local match = text:lower():match("[0-9]+%.?[0-9]*")
    return tonumber(match)
end

--[[

/run
for i=1,40 do
	local D= UnitDebuff("target",i);
	if D then
		print(i.."="..D)
	end
end
--]]

addEvent(function(self, event, unit)
	for i=1, 40 do
		for _, spellbar in ipairs(ns.spellbars.active) do
			if spellbar.spellConfig.debuff[1] > 0 then -- We have a debuff to look at
				if unit == (type(spellbar.spellConfig.debuff[2]) == "string" and spellbar.spellConfig.debuff[2] or "target") then
					local name, _, _, count, dispelType, duration, expires, caster, isStealable, _, spellID, _, _, _, _, _ = UnitDebuff(unit, i)
					if caster == "player" then
						if spellbar.spellConfig.debuff[1] == spellID then -- Ooh, we found it on this spellbar.
							ns.tooltip:SetUnitDebuff(unit, i)
							local scanText = _G["EventHorizonScanTooltipTextLeft2"]:GetText()
							local match = text:lower():match("every ([0-9]+%.?[0-9]*)")
							local tickSpeed = tonumber(match)
								--tonumber returns nil if it can't be converted to a number
							ns:addDebuff(spellbar, duration, tickSpeed)
						end
					end
				end
			end
		end
	end
end,
"UNIT_AURA")

function NeP.Tooltip:Tick_Time(target)
    self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
    self.frame:SetUnit(target)
    local tooltipText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
    local match = text:lower():match("every ([0-9]+%.?[0-9]*)")
    return tonumber(match)
end




--------------------------------------------------------------------------------



Talent - Jagged Wounds *0.6708333333333333
Rake - 2sec tick - 10.1 sec duration
Rip - 1.3 - 16.1
Trash - 2 - 10.1

---- no JW
Rake - 3 - 15
Rip - 2 - 24
Trash - 3 - 15
Moonfire - 2 - 14




/dump NeP.DSL.Get(haste)(player)
/dump NeP.DSL.Get("spell.charges")(nil, 'Fire Blast')





local DotTicks = {
	['Rake'] = 3,
	['Rip'] = 2,
	['Thrash'] = 3,
	['Moonfire'] = 2,
}

--/dump NeP.DSL.Conditions['dot.tick_time']('Thrash')
NeP.DSL.RegisterConditon('dot.tick_time', function(spell)
	local class = select(3,UnitClass('player'))
	if class == 11 and GetSpecialization() == 2 then
		if hasTalent(6,2) == true and spell == 'Thrash' or spell == 'Rake' or spell == 'Rip' then
			return DotTicks[spell]*0.67
		else
			return DotTicks[spell]
		end
	end
end)

--/dump NeP.DSL.Conditions['dot.duration']('target','Rip')
NeP.DSL.RegisterConditon('dot.duration', function(target, spell)
	local debuff,_,duration,expires,caster = Xeer['UnitDot'](target, spell)
	if debuff and (caster == 'player' or caster == 'pet') then
		return duration
	end
	return 0
end)

--/dump NeP.DSL.Conditions['dot.ticking']('target','Rip')
NeP.DSL.RegisterConditon('dot.ticking', function(target, spell)
	if NeP.DSL.Conditions['debuff'](target, spell) then
		return 1
	else
		return 0
	end
end)

NeP.DSL.RegisterConditon('dot.ticks_remain', function(target, spell)
end)

NeP.DSL.RegisterConditon('dot.current_ticks', function(target, spell)
end)

NeP.DSL.RegisterConditon('dot.ticks', function(target, spell)
end)

NeP.DSL.RegisterConditon('dot.tick_time_remains', function(target, spell)
end)

NeP.DSL.RegisterConditon('dot.active_dot', function(target, spell)
end)






--/dump NeP.DSL.Conditions['debuff.duration']('target','Thrash')
NeP.DSL.RegisterConditon('dot.duration', function(target, spell)
	local class = select(3,UnitClass("player"))
	if NeP.DSL.Conditions['debuff.duration'](target, spell) ~= 0 then
		if class == 11 and GetSpecialization() == 2 then
			if hasTalent(6,2) == true and spell == 'Thrash' or spell == 'Rake' or spell == 'Rip' then
				return DotTime[spell]*0.6708333333333333
			else
				return DotTime[spell]
			end
		end
	else
		return 0
	end
end)



--------------------------------
/dump NeP.DSL.Conditions['spell.exists']('target')
/dump NeP.DSL.Conditions['spell.exists']('player','aa')
reaction_time (scope: global; default: 0.5) is the reaction time, in seconds. It is the time your players will need to notice an aura application
(for action conditional expressions using the react keyword) or a spell miss (for action conditional expressions using the miss_react keyword).

Dots

The available properties are:

    duration - is the initial duration, in seconds (not the remaining duration) of the current dot. Note that this returns 0 if the dot is not currently ticking.
    modifier - is the damages or healing modifier. If your character has a 20% general modifier and a 30% modifier for this dot, it will have a total of 1.2*1.3=1.56.
    remains - is the remaining duration, in seconds, before the dot/hot expires.
    ticking - is 1 if the dot is still active on the target, 0 if it faded out.
    ticks_added - is the number of additional ticks that have been added to the dot while it is active. This does not include ticks added from haste at the dots application.
    tick_dmg - is the non-critical damage of the last tick.
    ticks_remain - are the number of ticks remaining for the current active dot.
    spell_power - last spell_power snapshot used for dot damage calculation.
    attack_power - last attack_power snapshot used for dot damage calculation.
    multiplier - last multiplier, excluding dynamic target multipliers.
    haste_pct - last haste multiplier.
    current_ticks - the total number of ticks for the current application of the dot.
    ticks - the number of ticks that have already happened for the current application of the dot.
    crit_pct - last critical strike percentage snapshot used for dot damage calculation.
    crit_dmg - last critical damage strike bonus percentage used for dot damage calculation.
    (Since Simulationcraft 6.0.0) tick_time_remains - remaining time on the ongoing tick in seconds. 0 if the dot is not ticking.

(Since Simulationcraft 6.0.0) You can also check the number of active dots of any type using the active_dot expression.

# Fire nova if enough Flame Shocks are active
actions+=/fire_nova,if=active_dot.flame_shock>=5

-----------------------------------------------



For every buff/debuff, the available properties are:

    remains - is the remaining time, in seconds, for this debuff. Debuffs with a an infinite duration have a zero value.
    cooldown_remains - is the remaining time, in seconds, for spells cooldown triggering this buff.
    up - is 1 when the debuff currently exists and is active, 0 otherwise.
    down - is 0 when the debuff currently exists and is active, 1 otherwise.
    stack - is the number of stacks of this buff.
    max_stack - is the maximum possible stack size of this buff.
    stack_pct - returns 100 * stack / max_stack.
    react - is the number of stacks of this buff, taking into account your reaction time, as specified through reaction_time.
		   If you specified 0.5s, the returned value will be the number of stacks there were 0.5s ago.
    value - is the buff's value. For a 1200 spell power buff, for example, it will be 1200.

-------------------------------------------------------------------------------------------------------------------------
execute_time returns whichever is greater: gcd or cast_time
gcd is the amount of gcd-time it takes for the current action to execute, accounting for haste.
gcd.remains returns the amount of time until the player's gcd is ready
gcd.max returns the hasted gcd-time of the PLAYER, not the action. This is useful for wait commands.

gcd.max = gcd


then you need a ticker that does _
if gcd and player.lastcast == NeP.Engine.lastCast then
  spell = true
end

it would build a table with all spells that triger cgcd
-------------------------------------------------------------------------------------------------------------

{'Chi Burst', '@NOC.fiter(Chi Burst)'}
{'Whirling Dragon Punch', '@NOC.fiter(Whirling Dragon Punch)'}

local MasterySpells = {
    -- [LAST cast] { SPELLS ALOWED AFTER THAT ONE }
    ['Whirling Dragon Punch'] = {'Chi Burst', 'Crackling Jade Lightning'},
    ['Chi Burst'] = {'Whirling Dragon Punch', 'Crackling Jade Lightning'},
}

NOC.Filter = function(spell)
    local lastCast == NeP.Engine.lastCast
    local spellid = SpellID(lastCast)
    if MasterySpells[spellid] then
        for i=1, #MasterySpells do
            local allowed = MasterySpells[i]
            if allowed == spell then
                return true
            end
        end
    end
end

--------------------------------------------------------------

local escapeSequences = {
		[ "\a" ] = "\\a", -- Bell
		[ "\b" ] = "\\b", -- Backspace
		[ "\t" ] = "\\t", -- Horizontal tab
		[ "\n" ] = "\\n", -- Newline
		[ "\v" ] = "\\v", -- Vertical tab
		[ "\f" ] = "\\f", -- Form feed
		[ "\r" ] = "\\r", -- Carriage return
		[ "\\" ] = "\\\\", -- Backslash
		[ "\"" ] = "\\\"", -- Quotation mark
		[ "|" ]  = "||",
}

----------------------------------------------------------------------

	function Xeer.TargetingOLD()
		local exists = UnitExists('target')
		local hp = UnitHealth('target')
		if exists == false or (exists == true and hp < 1) then
			for i=1,#NeP.OM.unitEnemie do
				local Obj = NeP.OM.unitEnemie[i]
				if Obj.distance <= 10 then
					RunMacroText('/tar ' .. Obj.key)
					return true
				end
			end
		end
	end

--------------------------------------------------------------

pool_resource will force the application to stop processing the actions list while the resource is restored. By default, the primary resource of the spec is pooled.
    wait - (default: 0.5) is the time, in seconds, to wait. It is advised to keep this value low so that the resource pooling will
		only occur as long as the application reaches this very action and as its conditions are satisfied.
    for_next - (default: 0), when different from 0, will force the application to wait until the player has enough resources for the following action in list.
		If the following action already satisfies its resource criteria or if it is made unavailable for other reasons than resource starvation (cooldown for example),
		then pool_resource will be ignored.
    extra_amount - (default: 0), must be used with for_next parameter. When different from 0, it will require an additional amount of resource to be generated
		(in addition to the cost of the next action).

{'%pause', CONDITION}

-----------------------------------------------------

RegisterConditon("talent", function(target, args)
	local row, col = strsplit(",", args, 2)
	return hasTalent(tonumber(row), tonumber(col))
end)

function hasTalent(row, col)
	local group = GetActiveSpecGroup()
	local talentId, talentName, icon, selected, active = GetTalentInfo(row, col, group)
	return active and selected
end



buff.enrage.remains>cooldown.bloodthirst.remains
buff(Enrage).remains>spell(Bloodthirst).cooldown


!player.channeling(spell id)



Ðæn


/reflux switch LeilaUI --> Priest/Schaman/Rogue/Mage/Hunter/WL
/reflux switch LeilaUI-d --> Druid/Paladin
/reflux switch LeilaUI-m --> Warrior/DeathKnight/Monk


\t{'', ''},\n\n \t--actions.

{'', ''},\r\n \t--actions


// Return the focus that will be regenerated during the cast time or GCD of the target action.
// This includes additional focus for the steady_shot buff if present, but does not include
// focus generated by dire beast.

  virtual double cast_regen() const
  {
    double cast_seconds = ab::execute_time().total_seconds();
    double sf_seconds = std::min( cast_seconds, p() -> buffs.steady_focus -> remains().total_seconds() );
    double regen = p() -> focus_regen_per_second();
    return ( regen * cast_seconds ) + ( regen * p() -> buffs.steady_focus -> current_value * sf_seconds );
}






testing something, dont mind this comment :P

--/dump NeP.DSL.Conditions['QQQ']('target')
NeP.DSL.RegisterConditon('QQQ', function (target)
    local t = t or "target"
    local px,py = GetPlayerMapPosition("player")
    local tx,ty = GetPlayerMapPosition(t)
    local angle =  ( ( math.pi - math.atan2(px-tx,ty-py) - GetPlayerFacing() ) / (math.pi*2) * 32 + 0.5 ) % 32
    return angle
end)




function uf(t)
    local t = t or "target"
    local px,py = GetPlayerMapPosition("player")
    local tx,ty = GetPlayerMapPosition(t)
    local angle =  ( ( math.pi - math.atan2(px-tx,ty-py) - GetPlayerFacing() ) / (math.pi*2) * 32 + 0.5 ) % 32
    return angle
end

--[[
--/dump NeP.DSL.Conditions['timetomax']('player','Sidewinders')
/dump NeP.DSL.Conditions['cast_regen']('player','Aimed Shot')
/dump NeP.DSL.Conditions['casttime']('player','Aimed Shot')
1778
/dump NeP.DSL.Conditions['power.regen']('player')
11.246999740601
19.99716553878858
--]]

NeP.DSL.RegisterConditon('cast_regen', function(target, spell)
	--if NeP.DSL.Get('buff')('player','Steady Focus') then
	--	regen = (select(2, GetPowerRegen(target)))*1.25
	--else
	local regen = select(2, GetPowerRegen(target))
	--end
	local _, _, _, cast_time = GetSpellInfo(spell)
	--return ((regen * cast_time)/ 1000)
	return math.floor(((regen * cast_time)/ 1000) * 10^3 ) / 10^3
end)



'totem(Earthquake Totem).duration<10'

{ "Berserk", "target.deathin <= 20" },
{ "Berserk", "target.ttd <= 20" },

/dump NeP.DSL.Conditions['totem']('player','Totem Mastery')
/dump NeP.DSL.Conditions['totem.duration']('player','Totem Mastery')
/dump NeP.DSL.Conditions['totem.time']('player','Totem Mastery')
--/dump NeP.DSL.Conditions['spell.charges']('player','Boulderfist')

--/dump NeP.DSL.Conditions['rpdeficiet']('player')
--/dump NeP.DSL.Conditions['rprint']('Hi')
--/dump NeP.DSL.Conditions['rubimarea']
--/dump NeP.DSL.Conditions['areattd']('player')
--/dump NeP.DSL.Conditions['rubimarea.enemies']('player',8)
--/dump NeP.DSL.Conditions['spell.charges']('player','Blood Boil')
--/dump NeP.DSL.Conditions['toggle']('cooldowns')
--/dump NeP.DSL.Conditions['bmup']

ticks - for a dot or a hot, will return the number of ticks done so far since the last time the dot was refreshed.
ticks_remain - for a dot or a hot, will return the number of remaining ticks before the dot expires.
tick_time -  for a dot or a hot, is the time in seconds between ticks, if cast using your current haste.




    -- AoE
    ['aoe'] = function(rest) NeP.Interface.toggleToggle('AoE', rest) end,
    -- CDs
    ['cooldowns'] = function(rest) NeP.Interface.toggleToggle('Cooldowns', rest) end,
    -- Interrupts
    ['interrupts'] = function(rest) NeP.Interface.toggleToggle('Interrupts', rest) end,

GCD
GetSpellCooldown(61304)



	AutoTaunt = function()
		local _,_,class = UnitClass('player')
		spell = classTaunt[class]
		local spellCooldown = NeP.DSL.Get('spell.cooldown')('player', spell)
		if spellCooldown > 0 then
			return false
		end
		for i=1,#NeP.OM.unitEnemie do
			local Obj = NeP.OM.unitEnemie[i]
			local Threat = UnitThreatSituation('player', Obj.key)
			if Threat ~= nil and Threat >= 0 and Threat < 3 and Obj.distance <= 30 then
				NeP.Engine.Cast_Queue(spell, Obj.key)
				return true
			end
		end
	end






Open the find/replace dialog.
At the bottom will be some Search mode options.  Select "Extended (\n \r \t \0 \x...)"
In either the Find what or the Replace with field entries, you can use the following escapes:
\n  new line (LF)
\r   carriage return (CR)
\t   tab character
\0  null character
\xddd special character with code ddd

--/dump NeP.DSL.Conditions['test2']('target')
NeP.DSL.RegisterConditon('test2', function(target)
	return NeP.Tooltip:Scan_x(target)
end)

function NeP.Tooltip:Scan_x(target)
	for i = 1, 40 do
		self.frame:SetOwner(UIParent, 'ANCHOR_NONE')
		self.frame:SetUnitDebuff(target, i)
		local scanText = _G["NeP_ScanningTooltipTextLeft2"]:GetText()
		local tickSpeed = tonumber(string.sub(scanText, string.find(scanText, "every ")+6, string.find(scanText, " sec")-1))
		return tickSpeed
	end
	return false
end

RegisterConditon('state', function(target, arg)
	local match = States[tostring(arg)]
	return match and NeP.Tooltip:Scan_Debuff(target, match)
end)

RegisterConditon('test2', function(target)
	local match = {'damage every.*sec', 'damage per.*sec'}
	return match and NeP.Tooltip:Scan_x(target, match)
end)

    addEvent(function(self, event, unit)
    	for i=1, 40 do
    		for _, spellbar in ipairs(ns.spellbars.active) do
    			if spellbar.spellConfig.debuff[1] > 0 then -- We have a debuff to look at
    				if unit == (type(spellbar.spellConfig.debuff[2]) == "string" and spellbar.spellConfig.debuff[2] or "target") then
    					local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitDebuff(unit, i)
    					if caster == "player" then
    						if spellbar.spellConfig.debuff[1] == spellID then -- Ooh, we found it on this spellbar.
    							ns.tooltip:SetUnitDebuff(unit, i)
                --scanText:match("every ([0-9]+%.?[0-9]*)")
    							local scanText = _G["EventHorizonScanTooltipTextLeft2"]:GetText()
    							local tickSpeed = tonumber(string.sub(scanText, string.find(scanText, "every ")+6, string.find(scanText, " sec")-1))
    								--tonumber returns nil if it can't be converted to a number
    							ns:addDebuff(spellbar, duration, tickSpeed)

    						end
    					end
    				end
    			end
    		end
    	end
    end,
    "UNIT_AURA")  '


"All of the things that relate to spell times, either casting or the DoT tick, use the current value of haste.
For castTime() that is reasonably accurate for the decisions that have to be made, but for debuffTick(), it won't be quite right.
It would be nice to use the value of the haste when the DoT was applied, but unfortunately, there is no way to get that information from the WoW API after the fact from examining debuffs on the target."

Basically if you have 6000 haste when you cast the spell, we can calculate the tick speed for 6000 haste buy if you proc a trinket the spell would benefit from that trinkets haste even though its already
 on the target.  There is no api funtion to get that information, we can try to do some advanced algebra but there is always a discrepency from server vs local time.


--]]

{'Roll the Bones', 'combopoints>=5&{!talent(7,1)&{{!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Broadsides)&buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Broadsides)&!buff(Jolly Roger)&buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&buff(Shark Infested Waters)&!buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&buff(True Bearing)&!buff(Buried Treasure)}||{!buff(Broadsides)&!buff(Jolly Roger)&!buff(Grand Melee)&!buff(Shark Infested Waters)&!buff(True Bearing)&buff(Buried Treasure)}}}'},
