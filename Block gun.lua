local Settings = {
    ["Velocity"] = Vector3.new(30,0,0),
    ["Animation"] = true, --Must be true for this to work
    ["Fling"] = true, --Fling adds fling
    ["AlignHats"] = true, --Reduces jitter when off
    ["BulletFling"] = true --Where you click the bullet goes. Fling must be on.
}

if Settings["BulletFling"] == true then
    Settings["Velocity"] = Vector3.new(30,0,0)
elseif Settings["BulletFling"] == false then
    Settings["Velocity"] = Vector3.new(28,0,0)
end

local Player = game.Players.LocalPlayer
local Character = Player.Character

local Mouse = Player:GetMouse()


--Please credit me
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "SSS Reanimate";
	Text = "Credits to SSS";
	Duration = 3;
})

Character.Archivable = true

local Rig = Character:Clone()
Rig.Parent = Character
Rig.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame

if Settings["Animation"] == true then
    Character.Animate:Destroy()
elseif Settings["Animation"] == false then
    Character.Animate:Destroy()
    Rig.Animate:Destroy()
end

game:GetService("RunService").Stepped:Connect(function()
	for i,v in next, Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for i,v in next, Rig:GetDescendants() do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for i,v in next, Rig:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for i,v in next, Rig:GetDescendants() do
		if v:IsA("Decal") then
			v.Transparency = 1
		end
	end
end)

--Align functions
function Align(Character,Rig,Position,Rotation)
	Character:BreakJoints()
	local AlignPosition = Instance.new("AlignPosition",Character)
	AlignPosition.RigidityEnabled = false
	AlignPosition.MaxForce = math.huge
	AlignPosition.ReactionForceEnabled = false
	AlignPosition.Responsiveness = 200
	AlignPosition.MaxVelocity = math.huge
	AlignPosition.ApplyAtCenterOfMass = true
	
	local AlignOrientation = Instance.new("AlignOrientation",Character)
	AlignOrientation.RigidityEnabled = false
	AlignOrientation.ReactionTorqueEnabled = false
	AlignOrientation.Responsiveness = math.huge
	AlignOrientation.MaxTorque = math.huge
	AlignOrientation.MaxAngularVelocity = math.huge
	AlignOrientation.PrimaryAxisOnly = false;
	
	local A1 = Instance.new("Attachment",Character)
	local A2 = Instance.new("Attachment",Rig)
	AlignPosition.Attachment0 = A1
	AlignPosition.Attachment1 = A2
	AlignOrientation.Attachment0 = A1
	AlignOrientation.Attachment1 = A2
	A1.Position = Position
	A1.Orientation = Rotation
end

function AlignNon(Character,Rig,Position,Rotation)
	local AlignPosition = Instance.new("AlignPosition",Character)
	AlignPosition.RigidityEnabled = false
	AlignPosition.MaxForce = math.huge
	AlignPosition.ReactionForceEnabled = false
	AlignPosition.Responsiveness = 200
	AlignPosition.MaxVelocity = math.huge
	
	local AlignOrientation = Instance.new("AlignOrientation",Character)
	AlignOrientation.RigidityEnabled = false
	AlignOrientation.ReactionTorqueEnabled = false
	AlignOrientation.Responsiveness = math.huge
	AlignOrientation.MaxTorque = math.huge
	AlignOrientation.MaxAngularVelocity = math.huge
	AlignOrientation.PrimaryAxisOnly = false;
	
	local A1 = Instance.new("Attachment",Character)
	local A2 = Instance.new("Attachment",Rig)
	AlignPosition.Attachment0 = A1
	AlignPosition.Attachment1 = A2
	AlignOrientation.Attachment0 = A1
	AlignOrientation.Attachment1 = A2
	A1.Position = Position
	A1.Orientation = Rotation
end

local Gun = Instance.new("Part",Character)
Gun.Size = Vector3.new(1,1,2)
Gun.CFrame = Character.Head.CFrame
Gun.Name = "Gun"
Gun.Transparency = 1

if Settings["Fling"] == true then
    
    AlignNon(Character["HumanoidRootPart"],Rig["Torso"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Left Arm"],Rig["Left Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Right Arm"],Rig["Right Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Pal Hair"].Handle,Rig["Left Leg"],Vector3.new(0,0,0),Vector3.new(90,0,0))
    Align(Character["Right Leg"],Rig["Right Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Left Leg"],Rig["Torso"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Character["Pal Hair"].Handle.Mesh:Destroy()
    Align(Character["LavanderHair"].Handle,Gun,Vector3.new(0,0,0),Vector3.new(0,0,0))
    Character["LavanderHair"].Handle.Mesh:Destroy()
    
    local BodyAngularVelocity = Instance.new("BodyAngularVelocity", Character["Left Leg"])
    BodyAngularVelocity.AngularVelocity = Vector3.new(9e9*10, 9e9*10, 9e9*10)
    BodyAngularVelocity.MaxTorque = Vector3.new(9e9*10, 9e9*10, 9e9*10)

    local Selection = Instance.new("SelectionBox",Character["Left Leg"])
    Selection.Adornee = Character["Left Leg"]
    Selection.LineThickness = .05

    local Tick = 5

    game:GetService("RunService").Heartbeat:Connect(function()
        local Hue = tick() % Tick / Tick
        local Color = Color3.fromHSV(Hue,1,1)
        Selection.Color3 = Color
    end)
    
elseif Settings["Fling"] == false then
    
    AlignNon(Character["HumanoidRootPart"],Rig["Torso"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Left Arm"],Rig["Left Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Right Arm"],Rig["Right Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Left Leg"],Rig["Left Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["Right Leg"],Rig["Right Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
    Align(Character["LavanderHair"].Handle,Gun,Vector3.new(0,0,0),Vector3.new(0,0,0))
    Character["LavanderHair"].Handle.Mesh:Destroy()

end

for i,v in next, Character:GetDescendants() do
    if v:IsA("Accessory") and v.Name ~= "Pal Hair" and v.Name ~= "LavanderHair" then
        if Settings["AlignHats"] == true then
            Align(Character[v.Name].Handle,Rig[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
        elseif Settings["AlignHats"] == false then
            print("Off")
        end
    end
end

workspace.Camera.CameraSubject = Rig.Head
game.Players.LocalPlayer.Character = Rig

Rig.Humanoid.Died:Connect(function()
	Character.Humanoid.Health = 0
	game.Players.LocalPlayer.Character = Character
	Rig.Humanoid.Health = 0
	Character.Humanoid.Parent = nil
	Rig.Humanoid.Parent = nil
end)

for i,v in next, Character:GetDescendants() do
	if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
		game:GetService("RunService").Heartbeat:Connect(function()
			v.Velocity = Settings["Velocity"]
		end)
	end
end

Character.Humanoid:ChangeState(16)

local Down = false

if Settings["BulletFling"] == true then
    
game:GetService("RunService").Heartbeat:Connect(function()
    if Down == true then
        Character["Left Leg"].Position = Mouse.hit.p
    elseif Down == false then
        Character["Left Leg"].Position = Rig["Torso"].Position + Vector3.new(0,-40,0)
    end
end)

Mouse.Button1Down:Connect(function()
    Down = true
end)

Mouse.Button1Up:Connect(function()
    Down = false
end)

elseif Settings["BulletFling"] == false then
    print("Off")
end

local Player = game.Players.LocalPlayer
local Character = Player.Character
Character.Animate:Destroy()

local Mouse = Player:GetMouse()

local LeftArm = Character.Torso["Left Shoulder"]
local RightArm = Character.Torso["Right Shoulder"]

local RightLeg = Character.Torso["Right Hip"]
local LeftLeg = Character.Torso["Left Hip"]

local Weld = Instance.new("Weld",Gun)
Weld.Part0 = Character.Torso
Weld.Part1 = Gun

local Sine = 1
local Speed = 1
local Div = 13

local Cos = math.cos
local Rad = math.rad

local IsHolding = false
local IsShooting = false

Mouse.KeyDown:Connect(function(Key)
    if Key == "f" then
        IsHolding = true
    end
end)

Mouse.KeyDown:Connect(function(Key)
    if Key == "q" then
        IsHolding = false
    end
end)

Mouse.Button1Down:Connect(function()
    if IsHolding == true then
        IsShooting = true
    else
        IsShooting = false
    end
end)

Mouse.Button1Up:Connect(function()
    IsShooting = false
end)

game:GetService("RunService").Stepped:Connect(function()
    Sine = Sine + Speed
    if Character.Humanoid.MoveDirection.Magnitude > 0 then
        LeftArm.C0 = LeftArm.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+30*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightArm.C0 = RightArm.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+-30*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightLeg.C0 = RightLeg.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(-20+40*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        LeftLeg.C0 = LeftLeg.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(-20+-40*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
    elseif IsShooting == true then
        LeftArm.C0 = LeftArm.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(160+0*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightArm.C0 = RightArm.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightLeg.C0 = RightLeg.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        LeftLeg.C0 = LeftLeg.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
    elseif IsHolding == true then
        Weld.Part0 = Character["Left Arm"]
        Weld.Part1 = Gun
        LeftArm.C0 = LeftArm.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(70+0*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightArm.C0 = RightArm.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(-10+0*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightLeg.C0 = RightLeg.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(80+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        LeftLeg.C0 = LeftLeg.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(-80+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        Weld.C0 = Weld.C0:Lerp(CFrame.new(0+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
    else
        Weld.Part0 = Character.Torso
        Weld.Part1 = Gun
        LeftArm.C0 = LeftArm.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightArm.C0 = RightArm.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),0.5+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(10+0*math.cos(Sine/Div)),math.rad(100+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        RightLeg.C0 = RightLeg.C0:Lerp(CFrame.new(1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        LeftLeg.C0 = LeftLeg.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(-10+0*math.cos(Sine/Div)),math.rad(-90+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
        Weld.C0 = Weld.C0:Lerp(CFrame.new(-1+0*math.cos(Sine/Div),-1+0*math.cos(Sine/Div),0+0*math.cos(Sine/Div)) * CFrame.Angles(math.rad(0+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div)),math.rad(0+0*math.cos(Sine/Div))),.1)
    end
end)
