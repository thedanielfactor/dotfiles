--[[
    Hammerspoon configuration for a drop down terminal for kitty that emulates the behavior of iterm2 hotkey

    Hammerspoon will always open the terminal in the screen and space where the mouse is.

    The script can handle the following cases when pressing the hotkey:
    - If Kitty is closed, launch the app and resize.
    - If Kitty is running but has no active window, create one and resize.
    - If kitty is running but has a hidden window, bring it to the front and resize it.
    - If kitty has focus, hide the window
    When Kitty looses focus the window is automatically hidden.
--]]

shellName = "kitty"
app = hs.application.get(shellName)

-- hs.geometry object X, Y, Width, Height
-- Example of left-slide terminal that ocuppies 40% of the width of the screen where it opens
-- location = '[0,0,40,100]'
-- Example of drop down terminal that ocuppies 30% of the height of the screen where it opens
location = "[0,0,100,30]"

function applicationWatcher(appName, eventType, appObject)
  -- Upon launch resize the window that opens by default to the right size
  if eventType == hs.application.watcher.launched then
    if appName == shellName then
      while not appObject:mainWindow() do
      end
      appObject:mainWindow():moveToUnit(location)
    end
    -- Hide the app when it looses focus
  elseif eventType == hs.application.watcher.deactivated then
    if appName == shellName then
      appObject:hide()
    end
  end
end

function dropDown()
  app = hs.application.get(shellName)
  if app then
    -- If there is no hidden window, create one and resize it
    if not app:mainWindow() then
      if app:selectMenuItem({ "Shell", "New OS Window" }) then
        while not app:mainWindow() do
          app = hs.application.get(shellName)
        end
        app:mainWindow():moveToUnit(location)
      end
      -- If the terminal is the forefront window hide it
    elseif app:isFrontmost() then
      app:hide()
      -- If the terminal window is hidden, bring it to the forefront
    else
      hs.spaces.moveWindowToSpace(app:mainWindow(), hs.spaces.focusedSpace())
      app:activate()
      app:mainWindow():moveToScreen(hs.mouse.getCurrentScreen())
      app:mainWindow():moveToUnit(location)
    end
  else
    -- Launch Kitty since it's not open. applicationWatcher will resize the window once the app is fully loaded
    hs.application.launchOrFocus(shellName)
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

hs.hotkey.bind("ctrl", "space", dropDown)
