Ext.Require("Shared.lua")

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