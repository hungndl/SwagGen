//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class ServiceFrequency: Codable, Equatable {

    public var highestFrequency: Double?

    public var lowestFrequency: Double?

    public init(highestFrequency: Double? = nil, lowestFrequency: Double? = nil) {
        self.highestFrequency = highestFrequency
        self.lowestFrequency = lowestFrequency
    }

    private enum CodingKeys: String, CodingKey {
        case highestFrequency
        case lowestFrequency
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        highestFrequency = try container.decodeIfPresent(.highestFrequency)
        lowestFrequency = try container.decodeIfPresent(.lowestFrequency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(highestFrequency, forKey: .highestFrequency)
        try container.encode(lowestFrequency, forKey: .lowestFrequency)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ServiceFrequency else { return false }
      guard self.highestFrequency == object.highestFrequency else { return false }
      guard self.lowestFrequency == object.lowestFrequency else { return false }
      return true
    }

    public static func == (lhs: ServiceFrequency, rhs: ServiceFrequency) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
