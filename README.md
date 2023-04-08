# AnyLogger

Example usage in a fictional BobsAddon:

![screenshot](https://tfc.blob.core.windows.net/public/Screenshot%202023-04-10%20090217.png)


Copy/pastable version:
```
BobsAddon = {}
logger = AnyLoggerClass:New("BobsAddon")
BobsAddon.LastGold = 0
function BobsAddon.Every10Secs()
	logger:Debug("Core","function Every10Secs called")
	if BobsAddon.addonHealth == "bad" then
		logger:Warn("Core","addonHealth is bad")
	else
		logger:DebugAll("Core","addonHealth is good")
	end
	local currentGold = zenimaxFunctionToGetGold()
	if currentGold = -1 then
		logger:Error("Core","zenimaxFunctionToGetGold returned -1")
		BobsAddon.addonHealth = "bad"
		return
	end
	if currentGold ~= BobsAddon.LastGold then
		logger:Info("Gold",currentGold)
		BobsAddon.LastGold = currentGold
		logger:Curio("GoldGps",gpsXCoord,gpsYCoord) -- maybe this will be useful some day to see where we gain the most gold; but it will probably just point to merchants and outlaws refuge
	end
end
```
