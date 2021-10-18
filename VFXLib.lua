local VFXLibrary = {}

local game = game;
local workspace = workspace;

local error = error;
local GetService = game.GetService;

local ReplicatedStorage = GetService(game, "ReplicatedStorage");

local Replicator = ReplicatedStorage.InvolvedRemotes.Replicator
local QuestTools = ReplicatedStorage.QuestTools;


local Effects = {
    ["RainbowBeam"] = function(Info)
        local Part = Info["Part"] or error("No Part Provided")
        Replicator:FireServer("Omega Rainbow Sword", "Boom", {["part"] = Part})
    end;
    
    ["Beam"] = function(Info)
        local Part = Info["Part"] or error("No Part Provided")
        local Color = Info["Color"] or error("No Color Provided");
        
        Replicator:FireServer("Golden Katana", "Effect", {["part"] = Part, ["color"] = BrickColor.new(Color) })
        
        
    end;
    
    ["TeleportEffect"] = function(Info)
        local Part = Info["Part"] or error("No Part Provided");
        local Frames = Info["Frames"] or error("No Frames Provided")
        
        Replicator:FireServer("Orinthian Greatsword", "Dash", {["hrp"] = Part, ["frames"] = Frames})
    end;
    
    ["SideWaysBeam"] = function (Info)
        local StartPosition = Info["StartPosition"] or error("No StartPosition Provided")
        local EndPosition = Info["EndPosition"] or error("No EndPosition Provided");
        local PartCount = Info["PartCount"] or error("No PartCount Provided")
        local Color = Info["Color"] or error("No Color Provided");
        local Amplitude = Info["Amplitude"] or error("No Amplitude Provided");
        local Size = Info["Size"] or error("No Size Provided");
        local Color = Info["Color"] or error("No Color Provided")
        
        Replicator:FireServer("Super Sniper", "Shot", {
	        ["ray"] = Ray.new(StartPosition, EndPosition), 
	        ["partCount"] = PartCount, 
	        ["amplitude"] = Amplitude, 
	        ["boltThickness"] = Size, 
	        ["VFX"] = QuestTools["Super Sniper"].RayGun.VFX, 
	        ["colour"] = Color
        })

    end;
    
    ["CircularExplosive"] = function(Info)
        local Part = Info["Part"] or error("No PartCount Provided")
        local Color = Info["Color"] or error("No Color Provided");

        Replicator:FireServer("All Hallow's Sword", "Effect", {
	        ["color"] = BrickColor.new(Color), 
	        ["part"] = Part, 
	        ["sword"] = QuestTools["All Hallow's Sword"].Handle, 
	        ["VFX"] = QuestTools["All Hallow's Sword"].SwordScript.VFX, 
	        ["pumpkins"] = {};
        })
    
    end;
    
    ["ShockWave"] = function(Info)
        local CFrameInfo = Info["CFrameInfo"] or error("No CFrameInfo Provided")
        Replicator:FireServer("Air Blast", "Skill", {["CF"] = CFrameInfo})
        -- only works if you have air elemental
    end;
    
    ["Lighting"] = function(Info)
        -- Only works if u have elmenetal Elemental
    
        local PlayerObjectTable = Info["PlayerObjectTable"] or error("No PlayerObjectTable Provided")
        Replicator:FireServer("Elemental Blast", "Skill_2", {
	        ["blast_impact"] = QuestTools["Elemental Blast"].Handle.BlastImpact, 
	        ["Tray"] = PlayerObjectTable;
	        ["skill_cast2"] = QuestTools["Elemental Blast"].Handle.CastSkill2
        })

    end;
}



function VFXLibrary:CreateEffect(EffectType, Info) 
    Effects[EffectType](Info)
end


function VFXLibrary:GetRainbow(Cycle)
    return Color3.fromHSV(tick() % Cycle / Cycle,1,1)
end


return VFXLibrary






        
