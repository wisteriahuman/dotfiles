hs.hotkey.bind({ "alt" }, "space", function()
  local app = hs.application.find("WezTerm")
  if app and app:isFrontmost() then
    app:hide()
  elseif app then
    app:activate()
  else
    hs.application.open("/Applications/WezTerm.app")
  end
end)
