local WidgetColorLibrary = {}
WidgetColorLibrary.__index = WidgetColorLibrary

--Functions
function WidgetColorLibrary.syncGuiColors(obj)
	local function setColors()
		obj.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	end
	setColors()
	settings().Studio.ThemeChanged:Connect(setColors)
end

function WidgetColorLibrary.syncImage(obj)
	local function setColors()
		obj.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainButton)
	end
	setColors()
	settings().Studio.ThemeChanged:Connect(setColors)
end

function WidgetColorLibrary.syncTextGuiColors(obj)
	local function setColors()
		obj.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.BrightText)
	end
	setColors()
	settings().Studio.ThemeChanged:Connect(setColors)
end


function WidgetColorLibrary.GetColorTheme()
	return settings().Studio.Theme
end

return WidgetColorLibrary