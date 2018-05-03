//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class LineServiceType: Codable, Equatable {

    public var lineName: String?

    public var lineSpecificServiceTypes: [LineSpecificServiceType]?

    public init(lineName: String? = nil, lineSpecificServiceTypes: [LineSpecificServiceType]? = nil) {
        self.lineName = lineName
        self.lineSpecificServiceTypes = lineSpecificServiceTypes
    }

    private enum CodingKeys: String, CodingKey {
        case lineName
        case lineSpecificServiceTypes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        lineName = try container.decodeIfPresent(.lineName)
        lineSpecificServiceTypes = try container.decodeIfPresent(.lineSpecificServiceTypes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(lineName, forKey: .lineName)
        try container.encode(lineSpecificServiceTypes, forKey: .lineSpecificServiceTypes)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? LineServiceType else { return false }
      guard self.lineName == object.lineName else { return false }
      guard self.lineSpecificServiceTypes == object.lineSpecificServiceTypes else { return false }
      return true
    }

    public static func == (lhs: LineServiceType, rhs: LineServiceType) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
