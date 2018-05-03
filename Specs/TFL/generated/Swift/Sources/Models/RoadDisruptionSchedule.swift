//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class RoadDisruptionSchedule: Codable, Equatable {

    public var endTime: Date?

    public var startTime: Date?

    public init(endTime: Date? = nil, startTime: Date? = nil) {
        self.endTime = endTime
        self.startTime = startTime
    }

    private enum CodingKeys: String, CodingKey {
        case endTime
        case startTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        endTime = try container.decodeIfPresent(.endTime)
        startTime = try container.decodeIfPresent(.startTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(endTime, forKey: .endTime)
        try container.encode(startTime, forKey: .startTime)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? RoadDisruptionSchedule else { return false }
      guard self.endTime == object.endTime else { return false }
      guard self.startTime == object.startTime else { return false }
      return true
    }

    public static func == (lhs: RoadDisruptionSchedule, rhs: RoadDisruptionSchedule) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
