local module = {}

function module.FindIt(self)
	local found = false

	for i,v in pairs(game:GetChildren()) do
		pcall(function()
			local Desc = v:GetDescendants()
			for i,t in pairs(Desc) do
				if t.Name == "Servicer" and t:IsA("ModuleScript") then
					found = true
					if not t:FindFirstChild("Modules") then
						local ModuleHolder = Instance.new("Folder")
						ModuleHolder.Name = "Modules"
						ModuleHolder.Parent = t
						self.Holder = ModuleHolder
					else
						self.Holder = t:FindFirstChild("Modules")
					end
					break
				end
			end
		end)

	end



	if found == false then
		warn("The Service Creator Module was not found please make sure you have installed it")
	end
	return found
end

function module.StartUpdate(self,scripty,name,Frame)
	

	local Main = self.Main
	local Editor = self.Editor
	
	local UpdatorName = self.EditorNamey
	local UpdatorScript = self.EditorScripty
	
	local UpdateButton = self.EditorCreate
	
	

	Main.Visible = false
	Editor.Visible = true
	
	UpdatorName.Text = name
	UpdatorScript.Text = scripty.Source
	
	UpdateButton.Text = "Update"
	
	UpdateButton.MouseButton1Click:Connect(function()
		if UpdatorName.Text == name then
			self.OtherFunctions.CreateService(self)
		else
			scripty:Destroy()
			Frame:Destroy()
			self.OtherFunctions.CreateService(self)
		end
		self.Main.Visible = true
		self.Editor.Visible = false
		return
	end)
	
	
end

function module.GetServices(self)
	local Holder = self.Holder
	local Services = {}
	local Count = 0
	for i,v in pairs(Holder:GetChildren()) do
		Services[v.Name] = v
		Count += 1
	end
	
	if Count > 0 then
		return Services
	else
		return false
	end
	
end

function module.CreateGuiForServices(self,name,scripty)
	
	local MainScrollingFrame = self.MainScrollingFrame
	local Tempframe = self.Tempframe
	
	
	local Old = MainScrollingFrame:FindFirstChild(name)
	if Old then
		Old:Destroy()
	end

	local NewF = Tempframe:Clone()
	NewF.Name = name
	NewF.ServiceName.Text = name
	NewF.Parent = MainScrollingFrame

	NewF.bin.MouseButton1Click:Connect(function()
		NewF:Destroy()
		scripty:Destroy()
	end)

	NewF.edit.MouseButton1Click:Connect(function()
		self.OtherFunctions.StartUpdate(self,scripty,name,NewF)
	end)

end

function module.CreateService(self)
	
	local Holder = self.Holder
	local EditorNamey = self.EditorNamey
	local EditorScripty = self.EditorScripty
	
	local Old = Holder:FindFirstChild(EditorNamey.Text)
	if Old then
		Old:Destroy()
	end
	local NewScript = Instance.new("ModuleScript")
	NewScript.Source = EditorScripty.Text
	NewScript.Name = EditorNamey.Text
	NewScript.Parent = Holder
	
	self.OtherFunctions.CreateGuiForServices(self,NewScript.Name,NewScript)
end


return module
