//
//  JSONValue.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

/**
    A JSONValue is a representatation of data in a JSON-compatible format. It contains a case for each
    of the JSON types, most containing an associated value for the native representation.
*/
public enum JSONValue {
    case string(String)
    case double(Double)
    case int(Int64)
    case bool(Bool)
    case null
    case array([JSONValue])
    case dictionary([String: JSONValue])

    /** 
        Return an optional JSONValue. If self is .Null, returns nil; otherwise it returns self. This
        is useful for expressions like this:

        if case .String(let barValue) = JSONDictionary["bar"]?.nullable {
            print(barValue) // Would print the string contained in "bar", if "bar" had a value and was a string.
        }
    */
    public var nullable: JSONValue? {
        switch self {
        case .null: return nil
        default: return self
        }
    }

    /**
        Returns the value contained in the `JSONValue`. If the expected return type isn't supported by
        `JSONValue`, the value is Null, or the expected return type mismatches what is contained in this `JSONValue`,
        an error will be thrown.
    
        - Throws:   JSONValueError.NoValue          When the value is .Null
        - Throws:   JSONValueError.TypeMismatch     If Value isn't the correct type held by the `JSONValue`.
        - Returns:  The associated value contained in the `JSONValue` when the correct type is passed.
    */
    public func value<ValueType>() throws -> ValueType {
        switch self {
        case .string(let value) where ValueType.self == Swift.String.self: return (value as! ValueType)
        case .double(let value) where ValueType.self == Swift.Double.self: return (value as! ValueType)
        case .int(let value) where ValueType.self == Swift.Int64.self: return (value as! ValueType)
        case .bool(let value) where ValueType.self == Swift.Bool.self: return (value as! ValueType)
        case .array(let value) where ValueType.self == Swift.Array<JSONValue>.self: return (value as! ValueType)
        case .dictionary(let value) where ValueType.self == Swift.Dictionary<Swift.String, JSONValue>.self: return (value as! ValueType)
        case .null: throw JSONValueError.noValue
        default: throw JSONValueError.typeMismatch
        }
    }

    /**
        Returns the value contained in the `JSONValue`. If the expected return type isn't supported by
        `JSONValue`, or the the expected return type mismatches what is contained in this `JSONValue`,
        an error will be thrown. If the value is Null, this method will return nil.

        - Throws:   JSONValueError.TypeMismatch     If Value isn't the correct type held by the `JSONValue`.
        - Returns:  The associated value contained in the `JSONValue` when the correct type is passed.
    */
    public func value<ValueType: ExpressibleByNilLiteral>() throws -> ValueType {
        // FIXME: This switch is using unsafeBitCast. This isn't ideal, but (Optional.Some(value) as! Value.self) is resulting
        // in a runtime error so it was necessary. For some reason the compiler things we're trying to force-cast the type of value
        // instead of an optional.
        switch self {
        case .string(let value) where ValueType.self == Swift.String.self: return (value as! ValueType)
        case .string(let value) where ValueType.self == Optional<Swift.String>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .double(let value) where ValueType.self == Swift.Double.self: return (value as! ValueType)
        case .double(let value) where ValueType.self == Optional<Swift.Double>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .int(let value) where ValueType.self == Swift.Int64.self: return (value as! ValueType)
        case .int(let value) where ValueType.self == Optional<Swift.Int64>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .bool(let value) where ValueType.self == Swift.Bool.self: return (value as! ValueType)
        case .bool(let value) where ValueType.self == Optional<Swift.Bool>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .array(let value) where ValueType.self == Swift.Array<JSONValue>.self: return (value as! ValueType)
        case .array(let value) where ValueType.self == Optional<Swift.Array<JSONValue>>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .dictionary(let value) where ValueType.self == Swift.Dictionary<Swift.String, JSONValue>.self: return (value as! ValueType)
        case .dictionary(let value) where ValueType.self == Optional<Swift.Dictionary<Swift.String, JSONValue>>.self: return unsafeBitCast(Optional.some(value), to: ValueType.self)
        case .null: return nil
        default: throw JSONValueError.typeMismatch
        }
    }
}

public enum JSONValueError: Error {
    case typeMismatch
    case noValue
}

extension JSONValue: Equatable { }

public func == (lhs: JSONValue, rhs: JSONValue) -> Bool {
    switch lhs {
    case .string(let l):
        if case .string(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .double(let l):
        if case .double(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .int(let l):
        if case .int(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .bool(let l):
        if case .bool(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .null:
        if case .null = rhs {
            return true
        } else {
            return false
        }
    
    case .array(let l):
        if case .array(let r) = rhs , l.count == r.count {
            for (index, leftObject) in l.enumerated() {
                if leftObject != r[index] {
                    return false
                }
            }
            
            return true
        } else {
            return false
        }
        
    case .dictionary(let l):
        if case .dictionary(let r) = rhs , l.count == r.count {
            for (key, leftObject) in l {
                if leftObject != r[key] {
                    return false
                }
            }
            
            return true
        } else {
            return false
        }
    }
}
