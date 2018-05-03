//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class FaresPeriod: Codable, Equatable {

    public var endDate: Date?

    public var id: Int?

    public var isFuture: Bool?

    public var startDate: Date?

    public var viewableDate: Date?

    public init(endDate: Date? = nil, id: Int? = nil, isFuture: Bool? = nil, startDate: Date? = nil, viewableDate: Date? = nil) {
        self.endDate = endDate
        self.id = id
        self.isFuture = isFuture
        self.startDate = startDate
        self.viewableDate = viewableDate
    }

    private enum CodingKeys: String, CodingKey {
        case endDate
        case id
        case isFuture
        case startDate
        case viewableDate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        endDate = try container.decodeIfPresent(.endDate)
        id = try container.decodeIfPresent(.id)
        isFuture = try container.decodeIfPresent(.isFuture)
        startDate = try container.decodeIfPresent(.startDate)
        viewableDate = try container.decodeIfPresent(.viewableDate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(endDate, forKey: .endDate)
        try container.encode(id, forKey: .id)
        try container.encode(isFuture, forKey: .isFuture)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(viewableDate, forKey: .viewableDate)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? FaresPeriod else { return false }
      guard self.endDate == object.endDate else { return false }
      guard self.id == object.id else { return false }
      guard self.isFuture == object.isFuture else { return false }
      guard self.startDate == object.startDate else { return false }
      guard self.viewableDate == object.viewableDate else { return false }
      return true
    }

    public static func == (lhs: FaresPeriod, rhs: FaresPeriod) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
