//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class Period: Codable, Equatable {

    public enum `Type`: String, Codable {
        case normal = "Normal"
        case frequencyHours = "FrequencyHours"
        case frequencyMinutes = "FrequencyMinutes"
        case unknown = "Unknown"

        public static let cases: [`Type`] = [
          .normal,
          .frequencyHours,
          .frequencyMinutes,
          .unknown,
        ]
    }

    public var frequency: ServiceFrequency?

    public var fromTime: TwentyFourHourClockTime?

    public var toTime: TwentyFourHourClockTime?

    public var type: `Type`?

    public init(frequency: ServiceFrequency? = nil, fromTime: TwentyFourHourClockTime? = nil, toTime: TwentyFourHourClockTime? = nil, type: `Type`? = nil) {
        self.frequency = frequency
        self.fromTime = fromTime
        self.toTime = toTime
        self.type = type
    }

    private enum CodingKeys: String, CodingKey {
        case frequency
        case fromTime
        case toTime
        case type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        frequency = try container.decodeIfPresent(.frequency)
        fromTime = try container.decodeIfPresent(.fromTime)
        toTime = try container.decodeIfPresent(.toTime)
        type = try container.decodeIfPresent(.type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(frequency, forKey: .frequency)
        try container.encode(fromTime, forKey: .fromTime)
        try container.encode(toTime, forKey: .toTime)
        try container.encode(type, forKey: .type)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? Period else { return false }
      guard self.frequency == object.frequency else { return false }
      guard self.fromTime == object.fromTime else { return false }
      guard self.toTime == object.toTime else { return false }
      guard self.type == object.type else { return false }
      return true
    }

    public static func == (lhs: Period, rhs: Period) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
