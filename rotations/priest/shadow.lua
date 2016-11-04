local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()
	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPRIEST |cffADFF2FShadow |r')
	print('|cffADFF2F --- |rRecommended Talents1: 1/1 - 2/2 - 3/1 - 4/2 - 5/3 - 6/3 - 7/3')
	print('|cffADFF2F --- |rRecommended Talents2: 1/1 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'xS2M',
		name = 'S2M',
		text = 'ON/OFF using S2M in rotation',
		icon = 'Interface\\Icons\\Achievement_boss_generalvezax_01',
	})

end

local _Xeer = { -- some non-SiMC stuffs
	--{'@Xeer.Targeting()', {'!target.alive&toggle(AutoTarget)'}},


--[[
priest="Priest_Shadow_T19M_S2M"
level=110
race=troll
role=spell
position=back
talents=1212333
artifact=47:139251:139257:139251:0:764:1:765:1:766:1:767:3:768:1:769:1:770:1:771:3:772:5:773:3:774:3:775:3:776:4:777:3:778:3:779:1:1347:1
spec=shadow

# Gear Summary
# gear_ilvl=884.19
# gear_stamina=26216
# gear_intellect=28334
# gear_crit_rating=6790
# gear_haste_rating=9592
# gear_mastery_rating=3280
# gear_armor=1819
--]]

}


local PreCombat = {
 	--actions.precombat=flask,type=flask_of_the_whispered_pact
	--{'', ''},
 	--actions.precombat+=/food,type=azshari_salad
	--{'', ''},
 	--actions.precombat+=/augmentation,type=defiled
	--{'', ''},
 	--actions.precombat+=/snapshot_stats
 	--actions.precombat+=/potion,name=deadly_grace
	--{'', ''},
 	--actions.precombat+=/shadowform,if=!buff.shadowform.up
	{'Shadowform', '!player.buff(Shadowform)&!player.buff(Voidform)'},
 	--actions.precombat+=/mind_blast
	--{'', ''},
}

local Void_Eruption = {
 {'!Void Eruption'},
}

local Mind_Blast = {
	{'Mind Blast'},
}

local Void_Eruption_Clip = {
 {'!Void Eruption'},
}

local Mind_Blast_Clip = {
	{'!Mind Blast'},
}

local MainRotation_Clip = {
	--actions.main=surrender_to_madness,if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
	{'!Surrender to Madness', 'toggle(xS2M)&talent(7,3)&target.time_to_die<=variable.s2mcheck'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
	{'!Mindbender', 'toggle(cooldowns)&talent(6,3)&!talent(7,3)'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck+60
	{'!Mindbender', 'toggle(cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck+60'},
 	--actions.main+=/shadow_word_pain,if=dot.shadow_word_pain.remains<{3+{4%3}}*gcd
	{'!Shadow Word: Pain', 'target.dot(Shadow Word: Pain).remains<{3+{4/3}}*gcd'},
 	--actions.main+=/vampiric_touch,if=dot.vampiric_touch.remains<{4+{4%3}}*gcd
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&target.dot(Vampiric Touch).remains<{4+{4/3}}*gcd'},
 	--actions.main+=/void_eruption,if=insanity>=85||{talent.auspicious_spirits.enabled&insanity>={80-shadowy_apparitions_in_flight*4}}
	{'!Void Eruption', '{talent(7,1)&player.insanity>=70}||player.insanity>=85||{talent(5,2)&player.insanity>={80-shadowy_apparitions_in_flight*4}}'},
 	--actions.main+=/shadow_crash,if=talent.shadow_crash.enabled
	{'!Shadow Crash', 'talent(6,2)'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
	--{'!', ''},
 	--actions.main+=/shadow_word_pain,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&talent(7,1)&player.insanity>=70'},
 	--actions.main+=/vampiric_touch,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&talent(7,1)&player.insanity>=70'},
 	--actions.main+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=90
	{'!Shadow Word: Death', '!talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=90'},
 	--actions.main+=/shadow_word_death,if=talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=70
	{'!Shadow Word: Death', 'talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=70'},
 	--actions.main+=/mind_blast,if=talent.legacy_of_the_void.enabled&{insanity<=81||{insanity<=75.2&talent.fortress_of_the_mind.enabled}}
	{'!Mind Blast', 'talent(7,1)&{player.insanity<=81||{player.insanity<=75.2&talent(1,2)}}'},
 	--actions.main+=/mind_blast,if=!talent.legacy_of_the_void.enabled||{insanity<=96||{insanity<=95.2&talent.fortress_of_the_mind.enabled}}
	{'!Mind Blast', '!talent(7,1)||{player.insanity<=96||{player.insanity<=95.2&talent(1,2)}}'},
 	--actions.main+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.main+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.main+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.main+=/shadow_word_void,if={insanity<=70&talent.legacy_of_the_void.enabled}||{insanity<=85&!talent.legacy_of_the_void.enabled}
	{'!Shadow Word: Void', '{player.insanity<=70&talent(7,1)}||{player.insanity<=85&!talent(7,1)}'},
}

local MainRotation = {
	{MainRotation_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
 	--actions.main=surrender_to_madness,if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
	{'Surrender to Madness', 'toggle(xS2M)&talent(7,3)&target.time_to_die<=variable.s2mcheck'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
	{'Mindbender', 'toggle(cooldowns)&talent(6,3)&!talent(7,3)'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck+60
	{'Mindbender', 'toggle(cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck+60'},
 	--actions.main+=/shadow_word_pain,if=dot.shadow_word_pain.remains<{3+{4%3}}*gcd
	{'Shadow Word: Pain', 'target.dot(Shadow Word: Pain).remains<{3+{4/3}}*gcd'},
 	--actions.main+=/vampiric_touch,if=dot.vampiric_touch.remains<{4+{4%3}}*gcd
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&target.dot(Vampiric Touch).remains<{4+{4/3}}*gcd'},
 	--actions.main+=/void_eruption,if=insanity>=85||{talent.auspicious_spirits.enabled&insanity>={80-shadowy_apparitions_in_flight*4}}
	{'!Void Eruption', '{talent(7,1)&player.insanity>=70}||player.insanity>=85||{talent(5,2)&player.insanity>={80-shadowy_apparitions_in_flight*4}}'},
 	--actions.main+=/shadow_crash,if=talent.shadow_crash.enabled
	{'Shadow Crash', 'talent(6,2)'},
 	--actions.main+=/mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
	--{'', ''},
 	--actions.main+=/shadow_word_pain,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&talent(7,1)&player.insanity>=70'},
 	--actions.main+=/vampiric_touch,if=!ticking&talent.legacy_of_the_void.enabled&insanity>=70
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&talent(7,1)&player.insanity>=70'},
 	--actions.main+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=90
	{'Shadow Word: Death', '!talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=90'},
 	--actions.main+=/shadow_word_death,if=talent.reaper_of_souls.enabled&cooldown.shadow_word_death.charges=2&insanity<=70
	{'Shadow Word: Death', 'talent(4,2)&cooldown(Shadow Word: Death).charges=2&player.insanity<=70'},
 	--actions.main+=/mind_blast,if=talent.legacy_of_the_void.enabled&{insanity<=81||{insanity<=75.2&talent.fortress_of_the_mind.enabled}}
	{'Mind Blast', 'talent(7,1)&{player.insanity<=81||{player.insanity<=75.2&talent(1,2)}}'},
 	--actions.main+=/mind_blast,if=!talent.legacy_of_the_void.enabled||{insanity<=96||{insanity<=95.2&talent.fortress_of_the_mind.enabled}}
	{'Mind Blast', '!talent(7,1)||{player.insanity<=96||{player.insanity<=95.2&talent(1,2)}}'},
 	--actions.main+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.main+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.main+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.main+=/shadow_word_void,if={insanity<=70&talent.legacy_of_the_void.enabled}||{insanity<=85&!talent.legacy_of_the_void.enabled}
	{'Shadow Word: Void', '{player.insanity<=70&talent(7,1)}||{player.insanity<=85&!talent(7,1)}'},
	--actions.main+=/mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,interrupt=1,chain=1
	--actions.main+=/mind_sear,if=active_enemies>=2,interrupt=1,chain=1
	{'Mind Sear', 'target.area(10).enemies>1', 'target'},
 	--actions.main+=/mind_flay,if=!talent.mind_spike.enabled,interrupt=1,chain=1
	{'Mind Flay', '!talent(7,2)', 'target'},
 	--actions.main+=/mind_spike,if=talent.mind_spike.enabled
	{'Mind Spike', 'talent(7,2)'},
 	--actions.main+=/shadow_word_pain
	{'Shadow Word: Pain'},
}

local S2M_Clip = {
	{'!Void Eruption'},
 	--actions.s2m=shadow_crash,if=talent.shadow_crash.enabled
	{'!Shadow Crash', 'talent(6,2)'},
 	--actions.s2m+=/mindbender,if=talent.mindbender.enabled
	{'!Mindbender', 'toggle(cooldowns)&talent(6,3)'},
	--actions.s2m+=/void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5
	{'!Void Torrent', 'target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5'},
	--actions.s2m+=/berserking,if=buff.voidform.stack>=80
	{'!Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>=80'},
	--actions.s2m+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-current_insanity_drain*gcd.max+15)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=77&cooldown.shadow_word_death.charges=2
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+15}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	--actions.s2m+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-current_insanity_drain*gcd.max+65)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=77&cooldown.shadow_word_death.charges=2
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+65}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&{talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt
	{'!Void Eruption'},
 	--actions.s2m+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+30}<100
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
 	--actions.s2m+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+90}<100
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+90}<100'},
	--actions.s2m+=/power_infusion,if=buff.insanity_drain_stacks.stack>=77
	{'!Power Infusion', 'toggle(cooldowns)&insanity_drain_stacks>=77'},
	--actions.s2m+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	--actions.s2m+=/dispersion,if=current_insanity_drain*gcd.max>insanity&!buff.power_infusion.up
	{'!Dispersion', 'current_insanity_drain*gcd_max>player.insanity&!player.buff(Power Infusion)'},
 	--actions.s2m+=/mind_blast
	{'!Mind Blast'},
 	--actions.s2m+=/wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
	{Mind_Blast_Clip, 'action(Mind Blast).cooldown<gcd.max*0.28'},
 	--actions.s2m+=/shadow_word_death,if=cooldown.shadow_word_death.charges=2
	{'!Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
 	--actions.s2m+=/shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
	{'!Shadowfiend', 'toggle(cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
 	--actions.s2m+=/shadow_word_void,if={insanity-current_insanity_drain*gcd.max+75}<100
	{'!Shadow Word: Void', '{parser_bypass1+75}<100'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&{active_enemies<5||talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled||artifact.sphere_of_insanity.rank}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
 	--actions.s2m+=/vampiric_touch,if=!ticking&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.s2m+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.s2m+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable||action.void_bolt.usable_in<gcd.max*0.8
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.8'},
}

local S2M = {
	{S2M_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
	{'!Void Eruption'},
 	--actions.s2m=shadow_crash,if=talent.shadow_crash.enabled
	{'Shadow Crash', 'talent(6,2)'},
 	--actions.s2m+=/mindbender,if=talent.mindbender.enabled
	{'Mindbender', 'toggle(cooldowns)&talent(6,3)'},
	--actions.s2m+=/void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5
	{'Void Torrent', 'target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5'},
	--actions.s2m+=/berserking,if=buff.voidform.stack>=80
	{'Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>=80'},
	--actions.s2m+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-current_insanity_drain*gcd.max+15)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=77&cooldown.shadow_word_death.charges=2
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+15}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
	--actions.s2m+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&(insanity-current_insanity_drain*gcd.max+65)<100&!buff.power_infusion.up&buff.insanity_drain_stacks.stack<=77&cooldown.shadow_word_death.charges=2
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+65}<100&!player.buff(Power Infusion)&insanity_drain_stacks<=77&cooldown(Shadow Word: Death).charges>=2'},
 	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&{talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
 	--actions.s2m+=/void_bolt
	{'!Void Eruption'},
 	--actions.s2m+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+30}<100
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
 	--actions.s2m+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+90}<100
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+90}<100'},
	--actions.s2m+=/power_infusion,if=buff.insanity_drain_stacks.stack>=77
	{'Power Infusion', 'toggle(cooldowns)&insanity_drain_stacks>=77'},
	--actions.s2m+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.28'},
	--actions.s2m+=/dispersion,if=current_insanity_drain*gcd.max>insanity&!buff.power_infusion.up
	{'Dispersion', 'current_insanity_drain*gcd_max>player.insanity&!player.buff(Power Infusion)'},
 	--actions.s2m+=/mind_blast
	{'Mind Blast'},
 	--actions.s2m+=/wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
	{Mind_Blast, 'action(Mind Blast).cooldown<gcd.max*0.28'},
 	--actions.s2m+=/shadow_word_death,if=cooldown.shadow_word_death.charges=2
	{'Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
 	--actions.s2m+=/shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
	{'Shadowfiend', 'toggle(cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
 	--actions.s2m+=/shadow_word_void,if={insanity-current_insanity_drain*gcd.max+75}<100
	{'Shadow Word: Void', '{parser_bypass1+75}<100'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&{active_enemies<5||talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled||artifact.sphere_of_insanity.rank}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
 	--actions.s2m+=/vampiric_touch,if=!ticking&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.s2m+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.s2m+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.s2m+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable||action.void_bolt.usable_in<gcd.max*0.8
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.8'},
	--actions.s2m+=/mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
	--actions.s2m+=/mind_sear,if=active_enemies>=3,interrupt=1
	{'Mind Sear', 'target.area(10).enemies>=3', 'target'},
 	--actions.s2m+=/mind_flay,if=!talent.mind_spike.enabled,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
	{'Mind Flay', '!talent(7,2)', 'target'},
 	--actions.s2m+=/mind_spike,if=talent.mind_spike.enabled
	{'Mind Spike', 'talent(7,2)'},
}

local VF_Clip = {
	{'!Void Eruption'},
 	--actions.vf=surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&{cooldown.void_bolt.up||cooldown.void_torrent.up||cooldown.shadow_word_death.up||buff.shadowy_insight.up}&target.time_to_die<=variable.s2mcheck-{buff.insanity_drain_stacks.stack}
	{'!Surrender to Madness', 'toggle(xS2M)&talent(7,3)&player.insanity>=25&{cooldown(Void Eruption).up||cooldown(Void Torrent).up||cooldown(Shadow Word: Death).up||player.buff(Shadowy Insight)}&target.time_to_die<=variable.s2mcheck-insanity_drain_stacks'},
 	--actions.vf+=/shadow_crash,if=talent.shadow_crash.enabled
	{'!Shadow Crash', 'talent(6,2)'},
	--actions.vf+=/void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60
	{'!Void Torrent', 'toggle(cooldowns)&target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	--actions.vf+=/void_torrent,if=talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+60
	{'!Void Torrent', 'toggle(cooldowns)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	--actions.vf+=/void_torrent,if=!talent.surrender_to_madness.enabled
	{'!Void Torrent', 'toggle(cooldowns)&!talent(7,3)'},
 	--actions.vf+=/mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
	{'!Mindbender', 'toggle(cooldowns)&talent(6,3)&!talent(7,3)'},
 	--actions.vf+=/mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+30
	{'!Mindbender', 'toggle(cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+30'},
 	--actions.vf+=/power_infusion,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=30&!talent.surrender_to_madness.enabled
	{'!Power Infusion', 'toggle(cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=30&!talent(7,3)'},
 	--actions.vf+=/power_infusion,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+15
	{'!Power Infusion', 'toggle(cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+15'},
 	--actions.vf+=/berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&!talent.surrender_to_madness.enabled
	{'!Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=20&!talent(7,3)'},
 	--actions.vf+=/berserking,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+70
	{'!Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+70'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&{talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
 	--actions.vf+=/void_bolt
	{'!Void Eruption'},
 	--actions.vf+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+10}<100
	{'!Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+10}<100'},
 	--actions.vf+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+30}<100
	{'!Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
 	--actions.vf+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.28'},
 	--actions.vf+=/mind_blast
	{'!Mind Blast'},
 	--actions.vf+=/wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
	{Mind_Blast_Clip, 'action(Mind Blast).cooldown<gcd.max*0.28'},
 	--actions.vf+=/shadow_word_death,if=cooldown.shadow_word_death.charges=2
	{'!Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
 	--actions.vf+=/shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
	{'!Shadowfiend', 'toggle(cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
 	--actions.vf+=/shadow_word_void,if={insanity-current_insanity_drain*gcd.max+25}<100
	{'!Shadow Word: Void', '{parser_bypass1+25}<100'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&{active_enemies<5||talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled||artifact.sphere_of_insanity.rank}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
 	--actions.vf+=/vampiric_touch,if=!ticking&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.vf+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'!Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'!Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.vf+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable||action.void_bolt.usable_in<gcd.max*0.8
	{Void_Eruption_Clip, 'action(Void Eruption).cooldown<gcd.max*0.8'},
}

local VF = {
	{VF_Clip, 'player.channeling(Mind Sear)||player.channeling(Mind Flay)'},
	{'!Void Eruption'},
 	--actions.vf=surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&{cooldown.void_bolt.up||cooldown.void_torrent.up||cooldown.shadow_word_death.up||buff.shadowy_insight.up}&target.time_to_die<=variable.s2mcheck-{buff.insanity_drain_stacks.stack}
	{'Surrender to Madness', 'toggle(xS2M)&talent(7,3)&player.insanity>=25&{cooldown(Void Eruption).up||cooldown(Void Torrent).up||cooldown(Shadow Word: Death).up||player.buff(Shadowy Insight)}&target.time_to_die<=variable.s2mcheck-insanity_drain_stacks'},
 	--actions.vf+=/shadow_crash,if=talent.shadow_crash.enabled
	{'Shadow Crash', 'talent(6,2)'},
	--actions.vf+=/void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60
	{'Void Torrent', 'toggle(cooldowns)&target.dot(Shadow Word: Pain).remains>5.5&target.dot(Vampiric Touch).remains>5.5&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	--actions.vf+=/void_torrent,if=talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+60
	{'Void Torrent', 'toggle(cooldowns)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+60'},
	--actions.vf+=/void_torrent,if=!talent.surrender_to_madness.enabled
	{'Void Torrent', 'toggle(cooldowns)&!talent(7,3)'},
 	--actions.vf+=/mindbender,if=talent.mindbender.enabled&!talent.surrender_to_madness.enabled
	{'Mindbender', 'toggle(cooldowns)&talent(6,3)&!talent(7,3)'},
 	--actions.vf+=/mindbender,if=talent.mindbender.enabled&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+30
	{'Mindbender', 'toggle(cooldowns)&talent(6,3)&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+30'},
 	--actions.vf+=/power_infusion,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=30&!talent.surrender_to_madness.enabled
	{'Power Infusion', 'toggle(cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=30&!talent(7,3)'},
 	--actions.vf+=/power_infusion,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+15
	{'Power Infusion', 'toggle(cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+15'},
 	--actions.vf+=/berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&!talent.surrender_to_madness.enabled
	{'Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>=10&insanity_drain_stacks<=20&!talent(7,3)'},
 	--actions.vf+=/berserking,if=buff.voidform.stack>=10&talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-{buff.insanity_drain_stacks.stack}+70
	{'Berserking', 'toggle(cooldowns)&player.buff(Voidform).stack>10&talent(7,3)&target.time_to_die>variable.s2mcheck-insanity_drain_stacks+70'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&dot.vampiric_touch.remains<3.5*gcd&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&target.dot(Vampiric Touch).remains<3.5*gcd&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&{talent(5,2)||talent(5,3)}&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.vampiric_touch.remains<3.5*gcd&{talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Vampiric Touch).remains<3.5*gcd&{talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}&target.time_to_die>10'},
 	--actions.vf+=/void_bolt,if=dot.shadow_word_pain.remains<3.5*gcd&artifact.sphere_of_insanity.rank&target.time_to_die>10
	{'!Void Eruption', 'target.dot(Shadow Word: Pain).remains<3.5*gcd&artifact(Sphere of Insanity).rank>0&target.time_to_die>10'},
 	--actions.vf+=/void_bolt
	{'!Void Eruption'},
 	--actions.vf+=/shadow_word_death,if=!talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+10}<100
	{'Shadow Word: Death', '!talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+10}<100'},
 	--actions.vf+=/shadow_word_death,if=talent.reaper_of_souls.enabled&current_insanity_drain*gcd.max>insanity&{insanity-current_insanity_drain*gcd.max+30}<100
	{'Shadow Word: Death', 'talent(4,2)&current_insanity_drain*gcd.max>player.insanity&{parser_bypass1+30}<100'},
 	--actions.vf+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.28'},
 	--actions.vf+=/mind_blast
	{'Mind Blast'},
 	--actions.vf+=/wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28
	{Mind_Blast, 'action(Mind Blast).cooldown<gcd.max*0.28'},
 	--actions.vf+=/shadow_word_death,if=cooldown.shadow_word_death.charges=2
	{'Shadow Word: Death', 'cooldown(Shadow Word: Death).charges=2'},
 	--actions.vf+=/shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
	{'Shadowfiend', 'toggle(cooldowns)&!talent(6,3)&player.buff(Voidform).stack>15'},
 	--actions.vf+=/shadow_word_void,if={insanity-current_insanity_drain*gcd.max+25}<100
	{'Shadow Word: Void', '{parser_bypass1+25}<100'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&{active_enemies<5||talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled||artifact.sphere_of_insanity.rank}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&{player.area(40).enemies<5||talent(5,2)||talent(5,3)||artifact(Sphere of Insanity).rank>0}'},
 	--actions.vf+=/vampiric_touch,if=!ticking&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&{talent.auspicious_spirits.enabled||talent.shadowy_insight.enabled}}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&{talent(5,2)||talent(5,3)}}'},
 	--actions.vf+=/vampiric_touch,if=!ticking&target.time_to_die>10&{active_enemies<4||talent.sanlayn.enabled||{talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank}}
	{'Vampiric Touch', '!prev_gcd(Vampiric Touch)&!target.dot(Vampiric Touch).ticking&target.time_to_die>10&{player.area(40).enemies<4||talent(5,1)||{talent(5,2)&artifact(Unleash the Shadows).rank>0}}'},
 	--actions.vf+=/shadow_word_pain,if=!ticking&target.time_to_die>10&{active_enemies<5&artifact.sphere_of_insanity.rank}
	{'Shadow Word: Pain', '!target.dot(Shadow Word: Pain).ticking&target.time_to_die>10&{player.area(40).enemies<5&artifact(Sphere of Insanity).rank>0}'},
 	--actions.vf+=/wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable||action.void_bolt.usable_in<gcd.max*0.8
	{Void_Eruption, 'action(Void Eruption).cooldown<gcd.max*0.8'},
	--actions.vf+=/mind_flay,line_cd=10,if=!talent.mind_spike.enabled&active_enemies>=2&active_enemies<4,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
	--actions.vf+=/mind_sear,if=active_enemies>=2,interrupt=1
	{'Mind Sear', 'target.area(10).enemies>1', 'target'},
 	--actions.vf+=/mind_flay,if=!talent.mind_spike.enabled,chain=1,interrupt_immediate=1,interrupt_if=action.void_bolt.usable
	{'Mind Flay', '!talet(7,2)', 'target'},
 	--actions.vf+=/mind_spike,if=talent.mind_spike.enabled
	{'Mind Spike', 'talent(7,2)'},
 	--actions.vf+=/shadow_word_pain
	{'Shadow Word: Pain'},
}

local xCombat = {
	 --actions=potion,name=deadly_grace,if=buff.bloodlust.up||target.time_to_die<=40||buff.voidform.stack>80
	--{'#Deadly Grace', 'player.buff(Bloodlust)||target.time_to_die<=40||player.buff(Voidform).stack>80'},
	 --actions+=/call_action_list,name=s2m,if=buff.voidform.up&buff.surrender_to_madness.up
	{S2M, 'player.buff(Voidform)&player.buff(Surrender to Madness)'},
	 --actions+=/call_action_list,name=vf,if=buff.voidform.up
	{VF, 'player.buff(Voidform)'},
	 --actions+=/call_action_list,name=main
	{MainRotation},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Silence'},
	{'Arcane Torrent', 'target.range<=8&spell(Silence).cooldown>gcd&!prev_gcd(Silence)'},
}

local Survival = { -- copy&pasta from MTS core :P
	--Healthstone at or below 20% health. Active when NOT channeling Void Torrent.
	--{'#Healthstone', 'player.health <= 20 & !player.channeling(Void Torrent)'},
	--Ancient Healing Potion at or below 20% health. Active when NOT channeling Void Torrent.
	--{'#Ancient Healing Potion', 'player.health <= 20 & !player.channeling(Void Torrent)'},
	--Gift of the Naaru at or below 40% health. Active when NOT channeling Void Torrent.
	{'Gift of the Naaru', 'player.health <= 40 & !player.channeling(Void Torrent)'},
	--Power Word: Shield at or below 40% health. Active when NOT in Surrender to Madness or channeling Void Torrent.
	{'Power Word: Shield', 'player.health <= 40 & !player.buff(Surrender to Madness) & !player.channeling(Void Torrent)'},
	--Dispersion at or below 15% health. Last attempt at survival.
	{'!Dispersion', 'player.health <= 15'},
	--Power Word: Shield for Body and Soul to gain increased movement speed if moving. Active when NOT in Surrender to Madness or channeling Void Torrent.
	{'Power Word: Shield', 'talent(2,2) & player.moving & !player.buff(Surrender to Madness)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<40'},
	--{Survival, 'player.health < 100'},
	{xCombat, 'target.range<40&target.infront&!player.channeling(Void Torrent)'},
}

local outCombat = {
	{Keybinds},
	{PreCombat},
}

NeP.CR:Add(258, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] PRIEST - Shadow',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
--NeP.CR:Add(258, '[Xeer] aaaPriest - Shadow', inCombat, outCombat)
