local module = {}

function module.OnWidgetClick(self)
	
	local Widget = self.Widget
	local Main = self.Main
	local EditorScripty = self.EditorScripty
	local DefaultText = self.DefaultText
	local MainWarning = self.MainWarning
	local MainMessage = self.MainMessage
	
	Widget.Enabled = not Widget.Enabled


	if Widget.Enabled == true then
		Main.Visible = true

		EditorScripty = DefaultText


		local Found = self.OtherFunctions.FindIt(self)
		if Found == false then
			MainWarning.BackgroundColor3 = Main.BackgroundColor3
			MainWarning.Visible = true
		else

			MainWarning.Visible = false
			local Services = self.OtherFunctions.GetServices(self)
			if Services == false then
				MainMessage.Visible = true
			
				
			else
				MainMessage.Visible = false
				for i,v in pairs(Services) do
					self.OtherFunctions.CreateGuiForServices(self,i,v)
				end



			end
		end
	else
		self.Main.Visible = false
		self.Editor.Visible = false
		self.Updator.Visible = false
	end

end


function module.CanvasSize(Frame,List)
	local function Update()
		local CanvasSize = List.AbsoluteContentSize
		Frame.CanvasSize = UDim2.new(0, 0, 0, CanvasSize.Y)
	end

	Frame.ChildAdded:Connect(Update)
end

function module.ControlText(Text,Scrolling)
	
	Text:GetPropertyChangedSignal("TextFits"):Connect(function()
		if Text.TextFits == false then
			repeat
				Scrolling.CanvasSize = UDim2.new(0, 0, 0, Scrolling.CanvasSize.Y.Offset + 16)
				Scrolling.CanvasPosition = Vector2.new(0, Scrolling.CanvasSize.Y.Offset - Scrolling.AbsoluteWindowSize.Y)
			until Text.TextFits == true
		end	
	end)


	Text:GetPropertyChangedSignal("TextBounds"):Connect(function()
		if Scrolling.CanvasSize.Y.Offset > Text.TextBounds.Y + 16 then
			Scrolling.CanvasSize = UDim2.new(0, 0, 0, Text.TextBounds.Y)
			Scrolling.CanvasPosition = Vector2.new(0, Scrolling.CanvasSize.Y.Offset - Scrolling.AbsoluteWindowSize.Y)
		end
	end)
end


return module
