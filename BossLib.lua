local BossLib = {}
BossLib.__index = BossLib

local game = game
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
local error = error

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

function BossLib.new(Info)
    local self = {
        BossName = Info["BossName"] or error("No boss name provided");
        WalkSpeed = Info["WalkSpeed"] or error("No WalkSpeed provided");
        StartingMessages = Info["StartingMessages"] or error("No StartingMessages Provided");
        Abilities = Info["Abilities"] {};
        Enabled = false;
    }
    
    return setmetatable(self, BossLib)
end

function BossLib:AddAbility(Ability)
    self.Abilities[#Abilities + 1] = Ability;
end

function BossLib:Start()
    assert(not Enabled, "Already Enabled")
    
    self.Enabled = true;
    
    local Message = self.StartingMessages[math_random(1, #self.StartingMessages)];
    
    Chat(("%s | %s"):format(self.BossName,Message))
    
    
    while self.Enabled do
        Humanoid.WalkSpeed = self.WalkSpeed
        for Index, Variable in pairs(self.Abilities) do
            Variable:Activate(self)
        end
        
        wait()
    end
end

function BossLib:Disable()
    self.Enabled = false;
end

return BossLib
