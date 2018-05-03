//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class MatchedRoute: Codable, Equatable {

    /** eg: Destination */
    public var destination: String?

    /** eg: Destination Name */
    public var destinationName: String?

    /** eg: N or S or I or O */
    public var direction: String?

    /** Name such as "72" */
    public var name: String?

    /** eg: Origination Name */
    public var originationName: String?

    /** eg: Origination */
    public var originator: String?

    /** The route code */
    public var routeCode: String?

    /** eg: Regular, Night */
    public var serviceType: String?

    public init(destination: String? = nil, destinationName: String? = nil, direction: String? = nil, name: String? = nil, originationName: String? = nil, originator: String? = nil, routeCode: String? = nil, serviceType: String? = nil) {
        self.destination = destination
        self.destinationName = destinationName
        self.direction = direction
        self.name = name
        self.originationName = originationName
        self.originator = originator
        self.routeCode = routeCode
        self.serviceType = serviceType
    }

    private enum CodingKeys: String, CodingKey {
        case destination
        case destinationName
        case direction
        case name
        case originationName
        case originator
        case routeCode
        case serviceType
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        destination = try container.decodeIfPresent(.destination)
        destinationName = try container.decodeIfPresent(.destinationName)
        direction = try container.decodeIfPresent(.direction)
        name = try container.decodeIfPresent(.name)
        originationName = try container.decodeIfPresent(.originationName)
        originator = try container.decodeIfPresent(.originator)
        routeCode = try container.decodeIfPresent(.routeCode)
        serviceType = try container.decodeIfPresent(.serviceType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(destination, forKey: .destination)
        try container.encode(destinationName, forKey: .destinationName)
        try container.encode(direction, forKey: .direction)
        try container.encode(name, forKey: .name)
        try container.encode(originationName, forKey: .originationName)
        try container.encode(originator, forKey: .originator)
        try container.encode(routeCode, forKey: .routeCode)
        try container.encode(serviceType, forKey: .serviceType)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? MatchedRoute else { return false }
      guard self.destination == object.destination else { return false }
      guard self.destinationName == object.destinationName else { return false }
      guard self.direction == object.direction else { return false }
      guard self.name == object.name else { return false }
      guard self.originationName == object.originationName else { return false }
      guard self.originator == object.originator else { return false }
      guard self.routeCode == object.routeCode else { return false }
      guard self.serviceType == object.serviceType else { return false }
      return true
    }

    public static func == (lhs: MatchedRoute, rhs: MatchedRoute) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
