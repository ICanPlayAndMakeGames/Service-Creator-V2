local Parent = script.Parent

local Useful = Parent:WaitForChild('Useful')

--Gui stuff



-- Module Stuff
local ColorLibrary = require(Useful:WaitForChild('WidgetColorLibrary'))

local Others = require(script:WaitForChild('Extras'))



--Syncing Colors
local Light = Color3.fromRGB(200, 200, 200)
local Dark = Color3.fromRGB(66,66,66)




local Theme = ColorLibrary.GetColorTheme()




--Creating dock


local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,  -- Widget will be initialized in floating panel
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	75,    -- Default width of the floating window
	75,    -- Default height of the floating window
	75,    -- Minimum width of the floating window
	75     -- Minimum height of the floating window
)	



local Toolbar = nil
local Button = nil




local function Start(self)
	
	
	Button.ClickableWhenViewportHidden = true
	
	Button.Click:Connect(function()
		self.Extras.OnWidgetClick(self)
	end)
		
	
	self.Widget:BindToClose(function()
		Button:SetActive(false)
		self.Widget.Enabled = false
		self.Main.Visible = false
		self.Editor.Visible = false
		self.Updator.Visible = false
	end)
	
	self.MainCreate.MouseButton1Click:Connect(function()
		self.Main.Visible = false
		self.Updator.Visible = false
		self.Editor.Visible = true
		self.EditorCreate.Text = "Create"
		self.EditorNamey.Text = ""
		self.EditorScripty.Text = self.DefaultText
	end)
	
	self.EditorCreate.MouseButton1Click:Connect(function()
		if self.EditorCreate.Text == "Create" then
			if self.EditorNamey.Text ~= nil then
				self.MainWarning.Visible = false
				self.MainMessage.Visible = false
				
				self.OtherFunctions.CreateService(self)
				self.Editor.Visible = false
				self.Updator.Visible = false
				self.Main.Visible = true
				
			end
		end	
	end)
	
	
	
	self.Extras.CanvasSize(self.MainScrollingFrame,self.MainScrollingFrame.UIListLayout)
	self.Extras.ControlText(self.EditorScripty,self.EditorScrollingFrame)
	self.Extras.ControlText(self.UpdatorScripty,self.UpdatorScrollingFrame)
	
	self.MainScrollingFrame.ChildRemoved:Connect(function()
		task.wait(0.1)
		if #self.MainScrollingFrame:GetChildren() == 1 then
			self.MainMessage.Visible = true
		else
			self.MainMessage.Visible = false
		end
	end)
	
	self.MainMessage:GetPropertyChangedSignal("Visible"):Connect(function()
		task.wait(0.1)
		if #self.MainScrollingFrame:GetChildren() == 1 then
		else
			self.MainMessage.Visible = false
		end
	end)
	
end

local Widget = {}

local function Create(self)
	 self.Frames = Useful:WaitForChild('Frames')


	self.Main = self.Frames:WaitForChild('Main'):Clone()
	self.Editor = self.Frames:WaitForChild('Editor'):Clone() --Frames
	self.Updator = self.Frames:WaitForChild('Updator'):Clone()
	self.Tempframe = self.Frames:WaitForChild('Tempframe')


	self.MainScrollingFrame = self.Main:WaitForChild('ScrollingFrame')
	self.MainWarning = self.Main:WaitForChild('Warning') --Main things
	self.MainCreate = self.Main:WaitForChild('CreateService')

	self.EditorCode = self.Editor:WaitForChild('Code')
	self.EditorServiceName = self.Editor:WaitForChild('ServiceName') -- editor things
	self.EditorCreate = self.Editor:WaitForChild('Create')

	self.UpdatorCode = self.Updator:WaitForChild('Code')
	self.UpdatorServiceName = self.Updator:WaitForChild('ServiceName') -- updator things
	self.UpdatorUpdate = self.Updator:WaitForChild('Update')

	self.MainMessage = self.Main:WaitForChild('Message') -- more main things

	self.EditorNamey = self.EditorServiceName:WaitForChild('Namey')
	self.EditorScrollingFrame = self.EditorCode:WaitForChild('ScrollingFrame') -- more editor things
	self.EditorScripty = self.EditorScrollingFrame:WaitForChild('Scripty')

	self.UpdatorNamey = self.UpdatorServiceName:WaitForChild('Namey')
	self.UpdatorScrollingFrame = self.UpdatorCode:WaitForChild('ScrollingFrame') -- more updator things
	self.UpdatorScripty = self.UpdatorScrollingFrame:WaitForChild('Scripty')
	
	self.DefaultText = Useful:WaitForChild('DefaultText').Source
	
	
	
end


function Widget.CreateGui(self)
	
	Create(self)
	
	local Widget = self.plugin:CreateDockWidgetPluginGui("CustomServicer", widgetInfo) --Making widget
	Widget.Title = "Service Menu"
	Widget.Name = "Service Creator Gui"
	
	
	self.Main.Parent = Widget
	self.Editor.Parent = Widget
	self.Updator.Parent = Widget
	self.Extras = require(script.Extras)
	
	if Theme == "Light" then

		self.MainScrollingFrame.BackgroundColor3 = Light
	else

		self.MainScrollingFrame.BackgroundColor3 = Dark
	end
	
	ColorLibrary.syncGuiColors(self.Main)
	ColorLibrary.syncGuiColors(self.MainWarning)
	
	Toolbar = self.Toolbar
	Button = self.Button
	
	
	self.Widget = Widget
	Start(self)
end

return Widget
