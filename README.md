# BGFetch

This is the script I use to have my desktop background rotate through
/r/EarthPorn's top 25 of the month.

If you want to use it, you need a working Go environment first.

1. Change the two constants in `bgfetch.go`

2. Install the script `go install`

3. Make sure it works by running `bgfetch` from the console. The `OutputDir` folder should contain the images now.

4. Use launchd to run the service.
  * Edit `dk.stjernegard.backgroundfetcher.plist.example` to your liking. Remember to change the Program path.
  * `mv dk.stjernegard.backgroundfetcher.plist.example ~/Library/LaunchAgents/dk.stjernegard.backgroundfetcher.plist`
  * `launchctl load dk.stjernegard.backgroundfetcher.plist`

5. Use the `OutputDir` folder as source for your desktop background and let it autorotate as much as you want.
