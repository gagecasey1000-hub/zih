--[[ ArmorManager Module Script
Place in ServerScriptService
Handles armor equipping/unequipping logic ]]

local ArmorManager = {}
ArmorManager.__index = ArmorManager

local Assets = game:GetService("ServerStorage"):WaitForChild("zih")

function ArmorManager.new(character)
	local self = setmetatable({}, ArmorManager)
	self.character = character
	self.humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	self.armor = nil
	return self
end

function ArmorManager:EquipArmor()
	if self.armor then
		return
	end
	
	-- Clone the armor morph
	local armorClone = Assets:Clone()
	armorClone.Parent = self.character
	self.armor = armorClone
	
	-- Weld all armor parts to the character
	self:WeldArmor()
end

function ArmorManager:WeldArmor()
	if not self.armor then return end
	
	local function weldDescendants(parent, targetParent)
		for _, part in pairs(parent:GetDescendants()) do
			if part:IsA("BasePart") then
				-- Skip the head part, use top instead
				if part.Name == "Head" then
					return
				end
				
				local weld = Instance.new("Weld")
				weld.Part0 = part
				weld.Part1 = targetParent
				weld.C0 = part.CFrame:Inverse() * targetParent.CFrame
				weld.Parent = part
				part.CanCollide = false
			end
		end
	end
	
	weldDescendants(self.armor, self.humanoidRootPart)
end

function ArmorManager:UnequipArmor()
	if self.armor then
		self.armor:Destroy()
		self.armor = nil
	end
end

function ArmorManager:Cleanup()
	self:UnequipArmor()
end

return ArmorManager
