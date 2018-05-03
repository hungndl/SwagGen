//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class List: Codable, Equatable {

    public var _123List: String?

    public init(_123List: String? = nil) {
        self._123List = _123List
    }

    private enum CodingKeys: String, CodingKey {
        case _123List = "123-list"
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        _123List = try container.decodeIfPresent(._123List)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(_123List, forKey: ._123List)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? List else { return false }
      guard self._123List == object._123List else { return false }
      return true
    }

    public static func == (lhs: List, rhs: List) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
