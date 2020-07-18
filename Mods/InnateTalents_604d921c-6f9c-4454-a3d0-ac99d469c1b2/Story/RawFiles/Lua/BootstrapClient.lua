Ext.Require("Shared.lua")

local function PrintArrayValue(ui, index, arrayName)
	local val = ui:GetValue(arrayName, "number", index)
	if val == nil then
		val = ui:GetValue(arrayName, "string", index)
		if val == nil then
			val = ui:GetValue(arrayName, "boolean", index)
		else
			val = "\""..val.."\""
		end
	end
	if val ~= nil then
		print(" ["..index.."] = ["..tostring(val).."]")
	end
end

local function PrintArray(ui, arrayName)
	print("==============")
	print(arrayName)
	print("==============")
	local i = 0
	while i < 300 do
		PrintArrayValue(ui, i, arrayName)
		i = i + 1
	end
	print("==============")
end

local DIVINITY_UNLEASHED = "e844229e-b744-4294-9102-a7362a926f71"
local DIVINITY_CONFLUX = "723ad06b-0241-4a2e-a9f3-4d2b419e0fe3"

local TALENT_ENUM = {
	[42] = "AnimalEmpathy",
	[97] = "ViolentMagic",
	[98] = "QuickStep",
}

local function IsInRacialArray(ui, id)
	local i = 0
	while i < 150 do
		local check = ui:GetValue("racialTalentArray","number", i)
		if check ~= nil and math.tointeger(check) == id then
			print(id, "is in racial talent array")
			return true
		end
		i = i + 2
	end
	return false
end

local function AddToRacialArray(ui, id, text)
	local i = 0
	while i < 150 do
		local check = ui:GetValue("racialTalentArray","number", i)
		if check == nil then
			if not IsInRacialArray(ui, id) then
				ui:SetValue("racialTalentArray", id, i)
				ui:SetValue("racialTalentArray", text, i+1)
				break
			else
				break
			end
		end
		i = i + 2
	end
end

Ext.RegisterListener("SessionLoaded", function()
	if not Ext.IsModLoaded(DIVINITY_UNLEASHED) and not Ext.IsModLoaded(DIVINITY_CONFLUX) then
		---@param ui UIObject
		---@param call string
		Ext.RegisterUINameInvokeListener("updateTalents", function(ui, call, ...)
			local i = 1
			while i < 150 do
				local id = ui:GetValue("talentArray","number", i) or nil
				local name = ui:GetValue("talentArray", "string", i+1)
				local state = ui:GetValue("talentArray", "boolean", i+2)
				local choosable = ui:GetValue("talentArray", "boolean", i+3)
				--local isRacial = ui:GetValue("talentArray", "boolean", i+4) -- Always nil in the regular talentArray
				
				if id ~= nil then
					if TALENT_ENUM[id] ~= nil then
						AddToRacialArray(ui, id, name)
						AddToRacialArray(ui, id, name)
						-- Disabling this talent in the original array
						ui:SetValue("talentArray", 999, i)
						ui:SetValue("talentArray", "", i+1)
						ui:SetValue("talentArray", false, i+2)
						ui:SetValue("talentArray", false, i+3)
					end
				end
				i = i + 4
			end
		end)
	end
end)