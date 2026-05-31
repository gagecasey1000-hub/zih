# Armor Equip System Setup

## Files Overview
- **zih.rbxm** - Your armor morph file
- **ArmorManager.lua** - Module script that handles armor logic
- **ServerArmorScript.lua** - Server script that manages equipping
- **SETUP_INSTRUCTIONS.md** - This file

## Installation Steps

### Step 1: Load Your RBXM File into ReplicatedFirst
1. In Roblox Studio, open your game
2. Go to **ReplicatedFirst** service
3. In the menu bar: **File** → **Insert from File**
4. Select **zih.rbxm**
5. It should import as a folder or model called "zih"
6. Make sure it's directly in **ReplicatedFirst**

### Step 2: Add the Module Script
1. In **ReplicatedStorage**, create a new **ModuleScript**
2. Name it **ArmorManager**
3. Paste the contents of `ArmorManager.lua` into it

### Step 3: Add the Server Script
1. In **ServerScriptService**, create a new **Script** (not LocalScript)
2. Paste the contents of `ServerArmorScript.lua` into it
3. Make sure this script has access to ReplicatedStorage

## How It Works

1. **When a player equips a tool** (puts it in their hand), the armor will automatically equip
2. **When they unequip the tool**, the armor disappears
3. **All players see the armor** - it's replicated across the server
4. **Works with character respawns** - armor system resets when player respawns

## Customization

### To only equip armor for specific tools:
In `ServerArmorScript.lua`, modify the `ToolGrip.ChildAdded` section:
```lua
humanoidRootPart:WaitForChild("ToolGrip").ChildAdded:Connect(function(tool)
	if tool.Name == "YourSpecificToolName" then
		armorManager:EquipArmor()
	end
end)
```

### To adjust armor positioning:
Edit the `WeldArmor()` function in `ArmorManager.lua` to adjust `C0` offsets:
```lua
weld.C0 = part.CFrame:Inverse() * targetParent.CFrame * CFrame.new(0, 0, 0)
```

## Troubleshooting

- **Armor doesn't appear**: Make sure zih.rbxm is imported into ReplicatedFirst as "zih"
- **Armor floats in wrong position**: Adjust the weld C0 offsets
- **Script errors**: Check console (F9) - make sure all scripts are in the right locations

That's it! Your armor system is ready to go. 🎮
