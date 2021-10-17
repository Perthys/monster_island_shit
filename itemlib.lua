local math_round = math.round
local table_insert = table.insert
local table_remove = table.remove
local Region3_new = Region3.new
local math_random = math.random
local math_huge = math.huge

local task = task;
local wait = task.wait;

local assert = assert

local game = game;
local workspace = workspace;

local GetService = game.GetService;

local Players = GetService(game,"Players");
local RunService = GetService(game,"RunService");
local UserInputService = GetService(game, "UserInputService");
local ReplicatedStorage = GetService(game, "ReplicatedStorage");

local LocalPlayer = Players.LocalPlayer;

local Character, Head, HumanoidRootPart, Humanoid, Camera;
local Backpack = LocalPlayer.Backpack;

local function ReLocalize()
	Camera = workspace.CurrentCamera
	Character = LocalPlayer.Character 
    
    Head = Character:WaitForChild("Head");
    HumanoidRootPart = Character:WaitForChild('HumanoidRootPart') or Character.PrimaryPart;
    Humanoid = Character:WaitForChild("Humanoid"); 
end

ReLocalize()

local Remote = ReplicatedStorage.InvolvedRemotes.MainEquipmentManagement

local WeaponType = {
    "PW";
    "SW1";
    "SW2";
    "SP";
    "EN";
    "ARM";
}

local Library = {}
function Library.GetItems(Items)

    assert(#Items == 6, "Invalid Amount of Items")
    
    for I = 1,#WeaponType do
        Remote:InvokeServer("Overwrite", {
	        ["Type"] = WeaponType[I], 
	        ["getTool"] = true, 
	        ["rentvalue"] = 0, 
	        ["itemname"] = Items[I], 
	        ["Current"] = "Super Sniper"
        })
    end
    wait()
end

function Library.ApplyEquipment()
    Remote:InvokeServer("ApplyEquipment")
    wait()
end

function Library.ApplyAllPotions()
    for Index, Potion in pairs(Character:GetChildren()) do
        if Potion:IsA("Tool") then
            local Doses    = Potion:FindFirstChild("Doses")
            local MaxDoses = Doses:FindFirstChild("Max")
            
            local _Remote = Potion:FindFirstChild("Event");
            
            if _Remote then
                if Doses and MaxDoses then
                    if Doses.Value <= MaxDoses.Value and Doses.Value ~= 0 then
                        _Remote:FireServer()
                    end
                end
            end
        end
    end
    
    for Index, Potion in pairs(Backpack:GetChildren()) do
        if Potion:IsA("Tool") then
            local Doses    = Potion:FindFirstChild("Doses")
            
            local _Remote = Potion:FindFirstChild("Event");
            
            if _Remote then
                if Doses then
                    local MaxDoses = Doses:FindFirstChild("Max")
                    if MaxDoses then
                        if Doses.Value <= MaxDoses.Value and Doses.Value ~= 0 then
                            _Remote:FireServer()
                        end
                    end
                end
            end
        end
    end
end

function Library.ClearAllParticles()
    for Index, Particles in pairs(Character:GetDescendants()) do
        if Particles:IsA("ParticleEmitter") then
            Particles:Destroy()
        end
    end
    wait()
end


return Library
