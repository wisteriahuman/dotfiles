local wezterm = "/Applications/WezTerm.app/Contents/MacOS/wezterm"

hs.hotkey.bind({ "alt" }, "space", function()
  local app = hs.application.find("WezTerm")
  if app and app:isFrontmost() then
    app:hide()
  elseif app then
    app:activate()
  else
    hs.execute("/Applications/WezTerm.app/Contents/MacOS/wezterm")
  end
end)
