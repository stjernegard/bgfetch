import Foundation

struct Settings {
    static let SourceURL = URL(string: "https://www.reddit.com/r/EarthPorn/top.json?sort=top&t=week")!
    static let OutputDir = URL(fileURLWithPath: "/Users/dannistjernegard/Pictures/EarthPorn/",
                               isDirectory: true)
    static let NumberOfImages = 3
    static let MinDimentions = (w: 2550, h: 1430)
}
