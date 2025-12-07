local Scripts = {}
local Settings = {}

Scripts.FindTextAndChange = function(title, text, IndexNumber)
	for i, v in pairs(game.CoreGui:GetDescendants()) do
		if v:IsA("TextLabel") and v.Text == "Disconnected" then
			v.Text = title
			return 'Gonna done'
		elseif v:IsA("TextLabel") and string.find(v.Text, tostring(IndexNumber)) then
			v.Text = text
			return true
		end
	end
	return nil
end

Scripts.Kick = function(Title , Reason)
	local Randoms = math.random(1000,99000)
	game.Players.LocalPlayer:Kick(Randoms)
	repeat task.wait()
		Scripts.FindTextAndChange(Title, Reason, Randoms)
	until Scripts.FindTextAndChange(Title, Reason, Randoms) == true
end

Scripts.SC = function()
	if not isfolder("YenixHubPremium") then
		makefolder("YenixHubPremium")
	end
	if not isfolder("YenixHubPremium/" .. game.PlaceId) then
		makefolder("YenixHubPremium/" .. game.PlaceId)
	end

	if isfile("YenixHubPremium/" .. game.PlaceId .. "/" .. game.Players.LocalPlayer.Name .. "-config.json") then
		local success, result =
			pcall(
				function()
					return game:GetService('HttpService'):JSONDecode(
						readfile(("YenixHubPremium/" .. game.PlaceId .. "/" .. game.Players.LocalPlayer.Name .. "-config.json"))
					)
				end
			)
		if success and type(result) == "table" then
			Settings = result
		end
	end

	for k, v in pairs(Settings) do
		_G[k] = v
	end
end

Scripts.S = function()
	return Settings
end

Scripts.SG = function()
	for k, v in pairs(_G) do
		if typeof(v) == "boolean" or typeof(v) == "string" or typeof(v) == "number" then
			Settings[k] = v
		end
	end
	writefile(
		"YenixHubPremium/" .. game.PlaceId .. "/" .. game.Players.LocalPlayer.Name .. "-config.json",
		game:GetService('HttpService'):JSONEncode(Settings)
	)
end

Scripts.GetPcall = function()
    local trace = debug.traceback("", 2)
    local line  = err:match(":(%d+):") or trace:match(":(%d+):") or "?"
    local time  = os.date("%H:%M:%S")
    warn(string.format([[ 
	realvisper say!
	----------------------------------------
	Time   : %s
	Line   : %s
	Error  : %s
	Trace  :
	%s
	----------------------------------------
	]], time, line, tostring(err), trace:gsub("\n", "\n  | ")))
end

return Scripts
