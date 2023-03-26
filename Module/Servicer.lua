local CustomServices = {
	
}

local module = {
}




function module:Start()
	if #script.Modules:GetChildren() > 0 then
		for i,v in pairs(script.Modules:GetChildren()) do
			if v:IsA('ModuleScript') then
				module:CreateService(v.Name,v)
			end	
		end
	end
	_G.Servicer = require(script)
end


function module:GetService(Service:string)
	local Success,errormsg = pcall(function()
		game:GetService(Service)
	end)
	if not Success then
		if not CustomServices[Service] then
			warn("No Service with the name "..Service.." was found")
			return nil
		else
			return CustomServices[Service]
		end
	end
end

function module:CreateService(Service:string,moduleScript:ModuleScript)
	CustomServices[Service] = require(moduleScript)
end

function module:DeleteService(Service:string)
	CustomServices[Service] = nil
end




return setmetatable(module, {__index = game}) 

