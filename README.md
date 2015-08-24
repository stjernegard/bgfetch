# BGFetch

This is the script I use to have my desktop background rotate through images submitted to /r/EarthPorn.

If you want to use it, you need a working Go environment first.

1. Change the two constants in `bgfetch.go`

2. Install the script with `go install`

3. Make sure it works by running `bgfetch` from the console. The `OutputDir` folder should contain the images now.

4. Use launchd to run the service.
  * Edit `dk.stjernegard.bgfetch.plist.example` to your liking. Remember to change the Program path.
  * `mv dk.stjernegard.bgfetch.plist.example ~/Library/LaunchAgents/dk.stjernegard.bgfetch.plist`
  * `launchctl load dk.stjernegard.bgfetch.plist`

5. Use the `OutputDir` folder as source for your desktop background and let it autorotate as much as you want.
