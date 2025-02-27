local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = workspace.CurrentCamera
workspace.Projectiles.ChildAdded:Connect(function(p_u_5)
	local v_u_6 = tick()
	p_u_5.Touched:Connect(function(p7)
		-- upvalues: (copy) p_u_5, (ref) v_u_6
		if p7.Material == Enum.Material.ForceField then
			return
		elseif p7:IsDescendantOf(workspace.Map) then
			if p_u_5.Velocity.Magnitude >= 5 and (p_u_5:FindFirstChild("Impact") and tick() - v_u_6 > 0.1) then
				v_u_6 = tick()
				local v8 = p_u_5:FindFirstChild("Impact"):Clone()
				v8.Name = "NO"
				v8.Volume = 0.5
				v8.RollOffMaxDistance = 200
				v8.RollOffMinDistance = 10
				v8.Parent = p_u_5
				v8:Play()
				game.Debris:AddItem(v8, v8.TimeLength + 1)
			end
		end
	end)
end)
v1:WaitForChild("GameEvent").OnClientEvent:Connect(function(p9, ...)
	-- upvalues: (copy) v_u_2
	local v10 = { ... }
	if p9 == "Ragdoll" then
		if v10[1] == nil or v10[1] and v10[1]:FindFirstChild("Head") == nil then
			return
		end
		local v11 = v_u_2:FindFirstChild("RagdollFolder") or Instance.new("Model")
		v11.Name = "RagdollFolder"
		v11.Parent = v_u_2
		local v12 = v10[1] or Instance.new("Model")
		v12.Archivable = true
		local v13 = v12:Clone()
		if v13:FindFirstChildWhichIsA("Highlight") then
			v13:FindFirstChildWhichIsA("Highlight"):Destroy()
		end
		local v14 = v13:FindFirstChild("HumanoidRootPart")
		local v15 = v13:FindFirstChild("Head")
		if v15 then
			v15.CanCollide = true
		end
		v13.Parent = v11
		local v16 = v13:FindFirstChildWhichIsA("Humanoid")
		v16.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		v16.AutoRotate = false
		v16:ChangeState(Enum.HumanoidStateType.Physics)
		for _, v17 in pairs(v13:GetDescendants()) do
			if v17:IsA("Motor6D") then
				local v18 = Instance.new("Attachment")
				local v19 = Instance.new("Attachment")
				v18.CFrame = v17.C0
				v19.CFrame = v17.C1
				v18.Parent = v17.Part0
				v19.Parent = v17.Part1
				local v20 = Instance.new("NoCollisionConstraint")
				v20.Part0 = v17.Part0
				v20.Part1 = v17.Part1
				v20.Parent = v17.Part1
				local v21 = Instance.new("BallSocketConstraint")
				v21.Attachment0 = v18
				v21.Attachment1 = v19
				v21.Parent = v17.Part0
				v17.Enabled = false
			elseif v17:IsA("BasePart") then
				v17.CollisionGroupId = 3
			end
		end
		if not v13:FindFirstChild("LowerTorso") then
			v13:FindFirstChild("Torso")
		end
		local v22 = v13:FindFirstChild("KnockbackDirection")
		if v22 then
			v14.Velocity = v22.Value.Velocity
			local v23 = Instance.new("Sound")
			v23.SoundId = "rbxassetid://8745852008"
			v23.Parent = v15
			v23:Play()
		end
		if game.Players:GetPlayerFromCharacter(v12) == game.Players.LocalPlayer then
			game.Workspace.CurrentCamera.CameraSubject = v13:WaitForChild("Head")
			return
		end
	elseif p9 == "ClearAll" then
		v_u_2:ClearAllChildren()
	end
end)
