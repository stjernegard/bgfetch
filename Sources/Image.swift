import Foundation

struct Image: Parsable {
    let url: URL
    let dimentions: (w: Int, h: Int)

    init?(data: [String: Any]) {
        guard (data["kind"] as? String) == "t3" else {
            print("an Image failed parsing")
            return nil
        }

        do {
            let dataObject: [String: Any] = try data.cast("data")

            let preview: [String: Any] = try dataObject.cast("preview")
            guard let image: [String: Any] = (try preview.cast("images") as [[String: Any]]).first else { return nil }
            let source: [String: Any] = try image.cast("source")

            let url: URL = try source.cast("url", transform: URL.init(string:))
            let width: Int = try source.cast("width")
            guard width > Settings.MinDimentions.w else { return nil }
            let height: Int = try source.cast("height")
            guard height > Settings.MinDimentions.h else { return nil }

            guard width > height else { return nil }

            self.url = url
            self.dimentions = (width, height)
        } catch let e {
            print(e.localizedDescription)
            return nil
        }
    }
}
