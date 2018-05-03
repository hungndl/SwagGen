//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class Ticket: Codable, Equatable {

    public var cost: String?

    public var description: String?

    public var displayOrder: Int?

    public var messages: [Message]?

    public var mode: String?

    public var passengerType: String?

    public var ticketTime: TicketTime?

    public var ticketType: TicketType?

    public init(cost: String? = nil, description: String? = nil, displayOrder: Int? = nil, messages: [Message]? = nil, mode: String? = nil, passengerType: String? = nil, ticketTime: TicketTime? = nil, ticketType: TicketType? = nil) {
        self.cost = cost
        self.description = description
        self.displayOrder = displayOrder
        self.messages = messages
        self.mode = mode
        self.passengerType = passengerType
        self.ticketTime = ticketTime
        self.ticketType = ticketType
    }

    private enum CodingKeys: String, CodingKey {
        case cost
        case description
        case displayOrder
        case messages
        case mode
        case passengerType
        case ticketTime
        case ticketType
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        cost = try container.decodeIfPresent(.cost)
        description = try container.decodeIfPresent(.description)
        displayOrder = try container.decodeIfPresent(.displayOrder)
        messages = try container.decodeIfPresent(.messages)
        mode = try container.decodeIfPresent(.mode)
        passengerType = try container.decodeIfPresent(.passengerType)
        ticketTime = try container.decodeIfPresent(.ticketTime)
        ticketType = try container.decodeIfPresent(.ticketType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(cost, forKey: .cost)
        try container.encode(description, forKey: .description)
        try container.encode(displayOrder, forKey: .displayOrder)
        try container.encode(messages, forKey: .messages)
        try container.encode(mode, forKey: .mode)
        try container.encode(passengerType, forKey: .passengerType)
        try container.encode(ticketTime, forKey: .ticketTime)
        try container.encode(ticketType, forKey: .ticketType)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? Ticket else { return false }
      guard self.cost == object.cost else { return false }
      guard self.description == object.description else { return false }
      guard self.displayOrder == object.displayOrder else { return false }
      guard self.messages == object.messages else { return false }
      guard self.mode == object.mode else { return false }
      guard self.passengerType == object.passengerType else { return false }
      guard self.ticketTime == object.ticketTime else { return false }
      guard self.ticketType == object.ticketType else { return false }
      return true
    }

    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}