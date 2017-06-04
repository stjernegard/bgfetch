import Foundation

struct Requester {
    static func makeJSONRequest(completion: @escaping ([String: Any]) -> Void) {
        let task = URLSession.shared.dataTask(with: Settings.SourceURL) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType == "application/json",
                let data = data, error == nil
                else {
                    print("main request failed")
                    return
            }

            let object = try? JSONSerialization.jsonObject(with: data, options: [])
            if let json = object as? [String: Any] {
                completion(json)
            }
        }
        task.resume()
    }

    static func download(file url: URL, completion: @escaping (URL) -> Void) {
        print("downloading \(url)")
        let task = URLSession.shared.downloadTask(with: url) { (location, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let location = location, error == nil
                else {
                    print("an image request failed")
                    return
            }

            completion(location)
        }
        task.resume()
    }
}
