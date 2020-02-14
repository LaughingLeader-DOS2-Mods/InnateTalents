local player_stats = {
	--["_Base"] = true,
	["_Hero"] = true,
	["HumanFemaleHero"] = true,
	["HumanMaleHero"] = true,
	["DwarfFemaleHero"] = true,
	["DwarfMaleHero"] = true,
	["ElfFemaleHero"] = true,
	["ElfMaleHero"] = true,
	["LizardFemaleHero"] = true,
	["LizardMaleHero"] = true,
	["HumanUndeadFemaleHero"] = true,
	["HumanUndeadMaleHero"] = true,
	["DwarfUndeadFemaleHero"] = true,
	["DwarfUndeadMaleHero"] = true,
	["ElfUndeadFemaleHero"] = true,
	["ElfUndeadMaleHero"] = true,
	["LizardUndeadFemaleHero"] = true,
	["LizardUndeadMaleHero"] = true,
	["_Companions"] = true,
	["StoryPlayer"] = true,
	["CasualPlayer"] = true,
	["NormalPlayer"] = true,
	["HardcorePlayer"] = true,
	["Player_Ifan"] = true,
	["Player_Lohse"] = true,
	["Player_RedPrince"] = true,
	["Player_Sebille"] = true,
	["Player_Beast"] = true,
	["Player_Fane"] = true,
	--["Summon_Earth_Ooze_Player"] = true,
}

local function ModuleLoad()
	Ext.Print("[InnateTalents:Bootstrap.lua] Adding The Pawn/Savage Sortilege to all Character stats.")
	Ext.Print("===================================================================")
	local totalOverrides = 0
	for i,stat in pairs(Ext.GetStatEntries("Character")) do
		if not player_stats[stat] then
			local talents = Ext.StatGetAttribute(stat, "Talents")
			local next_talents = talents

			if talents == nil or talents == "" then
				next_talents = "QuickStep;ViolentMagic"
			else
				if talents:find("QuickStep", 1, true) ~= nil then
					Ext.Print("[InnateTalents:Bootstrap.lua] Stat ("..stat..") already has The Pawn ("..talents.."). Skipping.")
				else
					next_talents = next_talents..";QuickStep"
				end
				if talents:find("ViolentMagic", 1, true) ~= nil then
					Ext.Print("[InnateTalents:Bootstrap.lua] Stat ("..stat..") already has Savage Sortilege ("..talents.."). Skipping.")
				else
					next_talents = next_talents..";ViolentMagic"
				end
			end

			-- if player_stats[stat] == true then
			-- 	if next_talents == "" then
			-- 		next_talents = next_talents .. "AnimalEmpathy"
			-- 	else
			-- 		next_talents = next_talents .. ";AnimalEmpathy"
			-- 	end
			-- end

			Ext.StatSetAttribute(stat, "Talents", next_talents)
			totalOverrides = totalOverrides + 1
		end
	end
	Ext.Print("[InnateTalents:Bootstrap.lua] Added the The Pawn/Savage Sortilege talent to "..tostring(totalOverrides).." Character stats.")
	Ext.Print("===================================================================")
end

Ext.RegisterListener("ModuleLoading", ModuleLoad)

function LLINNATE_Ext_AddTalent(character, talent)
	if CharacterHasTalent(character, talent) ~= 1 then
		if Ext.Version() >= 40 then
			Osi.NRD_CharacterSetPermanentBoostTalent(character, talent, 1)
			CharacterAddAttribute(character, "Dummy", 0)
		else
			Ext.Print("[InnateTalents:Bootstrap.lua] *WARNING* The extender is version ("..Ext.Version()..") but it requires >= 40 to add talents to NPCs!")
		end
	end
end

function LLINNATE_Ext_TraceStats(character)
	Ext.Print("Character("..character..") stats: ("..tostring(Ext.GetCharacter(character).Stats.Name)..") root template stats ("..GetStatString(character)..")")
end