
local BossMoveAPI = {}
BossMoveAPI.__index = BossMoveAPI;

local workspace = workspace;

local math_round = math.round
local table_insert = table.insert
local table_remove = table.remove
local Region3_new = Region3.new
local math_random = math.random
local math_huge = math.huge

local task = task;
local wait = task.wait;
local spawn = task.spawn;

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

local ChatRemote = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest

local function ReLocalize()
	Camera = workspace.CurrentCamera
	Character = LocalPlayer.Character 
    
    Head = Character:WaitForChild("Head");
    HumanoidRootPart = Character:WaitForChild('HumanoidRootPart') or Character.PrimaryPart;
    Humanoid = Character:WaitForChild("Humanoid"); 
    Torso = Character.Torso
end

ReLocalize()

local function Chat(Message)    
    ChatRemote:FireServer(Message, "All")
end

local function GiveDamage(Enemy, Damage)
    local DamageEvent = Enemy:FindFirstChild("TakeDamage")
    
    if DamageEvent then
        DamageEvent:FireServer(Damage, "Omega Rainbow Blaster", {"", false})
    end
end


function BossMoveAPI.new(Info)
    local self = {
        Name = Info["MoveName"] or error("No Move Name Provided");
        Cooldown = Info["Cooldown"] or error("No Cooldown");
        AbilityFunction = Info["AbilityFunction"] or error("No Ability");
        ActivationMessage = Info["ActivationMessage"] or error("No Messages");
        DamageAmount = Info["ActivationMessage"] or error("No DamageAmount");
        IsOnCooldown = false;
    }
    
    return setmetatable(self, BossMoveAPI)
end

function BossMoveAPI:Activate(Boss)
    spawn(function()
        if not self.IsOnCooldown then
            local RandomMessage = self.ActivationMessage[math_random(1, #self.ActivationMessage)]
                Chat(("%s | %s [%s]"):format(Boss.BossName, RandomMessage, self.Name))
                self.IsOnCooldown = true;
                self.AbilityFunction()
            wait(self.Cooldown)
        end
    end)
end


return BossMoveAPI





