local Parent = script.Parent

local Gui = Parent:WaitForChild('Gui')
local Other = Parent:WaitForChild('Other')

local GuiMaker = require(Gui:WaitForChild('GuiMaker'))
local IsRunning = require(Other:WaitForChild('IsRunning'))

if IsRunning == true then
	return
end



local Main = {}
Main.__index = Main

function Main.new(pluginy)
	local NewPlugin = {}
	setmetatable(NewPlugin,Main)
	
	NewPlugin.plugin = pluginy
	NewPlugin.OtherFunctions = require(Other:WaitForChild('OtherFunctions'))
	NewPlugin.Toolbar = pluginy:CreateToolbar("Service Creator")
	NewPlugin.Button = NewPlugin.Toolbar:CreateButton("Menu","Opens the Service tab","rbxassetid://12893415765")
	GuiMaker.CreateGui(NewPlugin)
	
	
end

return Main
