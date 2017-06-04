# BGFetch

This is the script I use to have my desktop background rotate through images submitted to /r/EarthPorn.

If you want to use it, you need a working Swift environment first.

1. Change the OutputDir path in `Sources/Settings.swift`

2. Build the script with `swift build -c release`

3. Use launchd to run the service.
  * Edit `dk.stjernegard.bgfetch.plist.example` to your liking. Remember to change the Program path.
  * `mv dk.stjernegard.bgfetch.plist.example ~/Library/LaunchAgents/dk.stjernegard.bgfetch.plist`
  * `launchctl load dk.stjernegard.bgfetch.plist`

4. Use the `OutputDir` folder as source for your desktop background and let it autorotate as much as you want.
