Ext.Require("Shared.lua")

function AddTalent(character, talent)
	if CharacterHasTalent(character, talent) ~= 1 then
		if Ext.Version() >= 40 then
			Osi.NRD_CharacterSetPermanentBoostTalent(character, talent, 1)
			CharacterAddAttribute(character, "Dummy", 0)
		else
			Ext.Print("[InnateTalents:Bootstrap.lua] *WARNING* The extender is version ("..Ext.Version()..") but it requires >= 40 to add talents to NPCs!")
		end
	end
end

function SendRegionToClients(region)
	Ext.BroadcastMessage("LLINNATE_SetCurrentLevel", region, nil)
end

Ext.RegisterNetListener("LLINNATE_AddTalentPoint", function(call, uuid)
	CharacterAddTalentPoint(uuid, 1)
end)