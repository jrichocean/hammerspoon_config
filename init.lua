-- Auto Reload
-- 
function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config Reloaded")



-- Caffeine
-- 
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("C₈H₁₀N₄O₂")
    else
        caffeine:setTitle("Sleepy")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end



-- Bluetooth toggle
-- 
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
  local checkState = io.popen("/usr/local/bin/blueutil power")
  local state = checkState:read()
  
  if state == "0" then
    os.execute("/usr/local/bin/blueutil power 1")
    hs.alert("Bluetooth on")
  elseif state == "1" then
    os.execute("/usr/local/bin/blueutil power 0")
    hs.alert("Bluetooth off")
  end
end)


