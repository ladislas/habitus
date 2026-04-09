/// Returns a greeting string.
///
/// - Parameter firstName: An optional first name. When `nil` or empty,
///   the greeting defaults to "Hello, world!".
/// - Returns: A greeting string.
public func greeting(firstName: String? = nil) -> String {
    if let firstName, !firstName.isEmpty {
        return "Hello, \(firstName)!"
    }
    return "Hello, world!"
}
