import Foundation

let semaphore = DispatchSemaphore(value: 0)
print("Fetching images")
Requester.makeJSONRequest { data in
    guard let data = data else {
        semaphore.signal()
        return
    }

    guard let listing = Listing(data: data) else { return }
    let urls = listing.images
        .prefix(Settings.NumberOfImages)
        .map { $0.url }

    var finishedDownloads: Int = 0

    for (index, url) in urls.enumerated() {
        Requester.download(file: url) { (location) in
            defer {
                finishedDownloads += 1
                if finishedDownloads == urls.count {
                    semaphore.signal()
                }
            }

            guard let location = location else { return }

            do {
                let newFileURL = Settings.OutputDir
                    .appendingPathComponent("\(index).\(url.pathExtension)")

                print("Saving \(url.lastPathComponent) to \(newFileURL.lastPathComponent)")

                try? FileManager.default.removeItem(at: newFileURL)

                try FileManager.default.moveItem(at: location,
                                                 to: newFileURL)
            } catch let e {
                print(e.localizedDescription)
            }
        }
    }
}
semaphore.wait()
