import Foundation

protocol Parsable {
    init?(data: [String: Any])
}

enum ParseError: Error {
    case unparsable(String)

    var localizedDescription: String {
        let description: String
        switch self {
        case .unparsable(let key):
            description = "`\(key)` unparseable"
        }
        return description
    }
}

extension Dictionary where Key == String {
    func cast<T>(_ key: Key) throws -> T {
        guard let value = self[key] as? T else {
            throw ParseError.unparsable(key)
        }
        return value
    }

    func cast<T, U>(_ key: Key, transform: (T) throws -> U?) throws -> U {
        guard let initialValue = self[key] as? T,
            let finalValue = try transform(initialValue) else {
                throw ParseError.unparsable(key)
        }
        return finalValue
    }
}
