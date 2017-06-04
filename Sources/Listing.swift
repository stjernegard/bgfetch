import Foundation

struct Listing: Parsable {
    let images: [Image]

    init?(data: [String: Any]) {
        guard (data["kind"] as? String) == "Listing" else {
            print("a Listing failed parsing")
            return nil
        }

        do {
            let dataObject: [String: Any] = try data.cast("data")
            let children: [[String: Any]] = try dataObject.cast("children")

            self.images = children.flatMap(Image.init(data:))
        } catch let e {
            print(e.localizedDescription)
            return nil
        }
    }
}
