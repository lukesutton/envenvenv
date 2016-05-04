#if os(Linux)
import Glibc
#else
import Darwin
#endif

public class Env {
  public struct Variable {
    let value: String?
    init(_ value: String?) {
      self.value = value
    }

    public var string: String? {
      return value
    }

    public var int: Int? {
      guard let value = value else { return nil}
      return Int(value)
    }

    public var double: Double? {
      guard let value = value else { return nil}
      return Double(value)
    }

    public var bool: Bool? {
      guard let value = value else { return nil}
      return value == "true"
    }
  }

  private var cache: [String: Variable] = [:]
  private var defaults: [String: String]

  init(defaults: [String: String] = [:]) {
    self.defaults = defaults
  }

  init() {
    self.defaults = [:]
  }

  public subscript(name: String) -> Variable {
    if let value = cache[name] {
      return value
    }
    else if let envVar = getenv(name) {
      let variable = Variable(String(validatingUTF8: envVar))
      cache[name] = variable
      return variable
    }
    else {
      let variable = Variable(defaults[name])
      cache[name] = variable
      return variable
    }
  }
}
