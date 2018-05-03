//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public class AccountTokenRequest: Codable, Equatable {

    /** The scope(s) of the tokens required.
    For each scope listed an Account and Profile token of that scope will be returned
     */
    public enum Scopes: String, Codable {
        case catalog = "Catalog"
        case commerce = "Commerce"
        case settings = "Settings"
        case playback = "Playback"

        public static let cases: [Scopes] = [
          .catalog,
          .commerce,
          .settings,
          .playback,
        ]
    }

    /** If you specify a cookie type then a content filter cookie will be returned
    along with the token(s). This is only really intended for web based clients which
    need to pass the cookies to a server to render a page based on the users
    content filters, e.g subscription code.

    If type `Session` the cookie will be session based.
    If type `Persistent` the cookie will have a medium term lifespan.
    If undefined no cookies will be set.
     */
    public enum CookieType: String, Codable {
        case session = "Session"
        case persistent = "Persistent"

        public static let cases: [CookieType] = [
          .session,
          .persistent,
        ]
    }

    /** The email associated with the account. */
    public var email: String

    /** The scope(s) of the tokens required.
For each scope listed an Account and Profile token of that scope will be returned
 */
    public var scopes: [Scopes]

    /** If you specify a cookie type then a content filter cookie will be returned
along with the token(s). This is only really intended for web based clients which
need to pass the cookies to a server to render a page based on the users
content filters, e.g subscription code.

If type `Session` the cookie will be session based.
If type `Persistent` the cookie will have a medium term lifespan.
If undefined no cookies will be set.
 */
    public var cookieType: CookieType?

    /** The password associated with the account.

Either a pin or password should be supplied. If both are supplied the password will take precedence.
 */
    public var password: String?

    /** The pin associated with the account.

Either a pin or password should be supplied. If both are supplied the password will take precedence.
 */
    public var pin: String?

    public init(email: String, scopes: [Scopes], cookieType: CookieType? = nil, password: String? = nil, pin: String? = nil) {
        self.email = email
        self.scopes = scopes
        self.cookieType = cookieType
        self.password = password
        self.pin = pin
    }

    private enum CodingKeys: String, CodingKey {
        case email
        case scopes
        case cookieType
        case password
        case pin
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        email = try container.decode(.email)
        scopes = try container.decode(.scopes)
        cookieType = try container.decodeIfPresent(.cookieType)
        password = try container.decodeIfPresent(.password)
        pin = try container.decodeIfPresent(.pin)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
        try container.encode(scopes, forKey: .scopes)
        try container.encode(cookieType, forKey: .cookieType)
        try container.encode(password, forKey: .password)
        try container.encode(pin, forKey: .pin)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? AccountTokenRequest else { return false }
      guard self.email == object.email else { return false }
      guard self.scopes == object.scopes else { return false }
      guard self.cookieType == object.cookieType else { return false }
      guard self.password == object.password else { return false }
      guard self.pin == object.pin else { return false }
      return true
    }

    public static func == (lhs: AccountTokenRequest, rhs: AccountTokenRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
