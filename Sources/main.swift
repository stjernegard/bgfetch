import Foundation

do {
    let manager = FileManager.default
    let directoryContents = try manager
        .contentsOfDirectory(at: Settings.OutputDir,
                             includingPropertiesForKeys: nil)
    for file in directoryContents {
        do {
            try manager.removeItem(at: file)
        } catch let e {
            print(e.localizedDescription)
        }
    }
} catch let error {
    print(error.localizedDescription)
}

let semaphore = DispatchSemaphore(value: 0)
print("Fetching images")
Requester.makeJSONRequest { data in
    guard let listing = Listing(data: data) else { return }
    let urls = listing.images
        .prefix(Settings.NumberOfImages)
        .map { $0.url }

    var locations: [URL] = []

    for url in urls {
        Requester.download(file: url) { (location) in
            print(url.lastPathComponent)
            locations.append(url)

            do {
                try FileManager.default.moveItem(
                    at: location,
                    to: Settings.OutputDir
                      .appendingPathComponent(url.lastPathComponent))
            } catch let e {
                print(e.localizedDescription)
            }

            if locations.count == urls.count {
                semaphore.signal()
            }
        }
    }
}
semaphore.wait()
