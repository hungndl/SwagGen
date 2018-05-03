//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class Pagination: Codable, Equatable {

    /** The total number of pages available given the current page size.

A value of -1 indicates that the total has not yet been determined. This may
arise when embedding secure list pagination info in a page which must be cached
by a CDN. For example a Bookmarks list.
 */
    public var total: Int

    /** The current page number.

A value of 0 indicates that the fist page has not yet been loaded. This is
useful when wanting to return the paging metadata to indicate how to
load in the first page.
 */
    public var page: Int

    /** The authorization requirements to load a page of items.

This will only be present on lists which are protected by some form
of authorization token e.g. Bookmarks, Watched, Entitlements.
 */
    public var authorization: PaginationAuth?

    /** Path to load next page of data, or null if not available */
    public var next: String?

    /** Any active list sort and filter options.

If an option has a default value then it won't be defined.
 */
    public var options: PaginationOptions?

    /** Path to load previous page of data, or null if not available. */
    public var previous: String?

    /** The current page size.

A value of -1 indicates that the size has not yet been determined. This may
arise when embedding secure list pagination info in a page which must be cached
by a CDN. For example a Bookmarks list.
 */
    public var size: Int?

    public init(total: Int, page: Int, authorization: PaginationAuth? = nil, next: String? = nil, options: PaginationOptions? = nil, previous: String? = nil, size: Int? = nil) {
        self.total = total
        self.page = page
        self.authorization = authorization
        self.next = next
        self.options = options
        self.previous = previous
        self.size = size
    }

    private enum CodingKeys: String, CodingKey {
        case total
        case page
        case authorization
        case next
        case options
        case previous
        case size
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        total = try container.decode(.total)
        page = try container.decode(.page)
        authorization = try container.decodeIfPresent(.authorization)
        next = try container.decodeIfPresent(.next)
        options = try container.decodeIfPresent(.options)
        previous = try container.decodeIfPresent(.previous)
        size = try container.decodeIfPresent(.size)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(total, forKey: .total)
        try container.encode(page, forKey: .page)
        try container.encode(authorization, forKey: .authorization)
        try container.encode(next, forKey: .next)
        try container.encode(options, forKey: .options)
        try container.encode(previous, forKey: .previous)
        try container.encode(size, forKey: .size)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? Pagination else { return false }
      guard self.total == object.total else { return false }
      guard self.page == object.page else { return false }
      guard self.authorization == object.authorization else { return false }
      guard self.next == object.next else { return false }
      guard self.options == object.options else { return false }
      guard self.previous == object.previous else { return false }
      guard self.size == object.size else { return false }
      return true
    }

    public static func == (lhs: Pagination, rhs: Pagination) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
