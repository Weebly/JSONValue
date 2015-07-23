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
    case String(Swift.String)
    case Double(Swift.Double)
    case Int(Swift.Int64)
    case Bool(Swift.Bool)
    case Null
    case Array([JSONValue])
    case Dictionary([Swift.String: JSONValue])

    /** 
        Return an optional JSONValue. If self is .Null, returns nil; otherwise it returns self. This
        is useful for expressions like this:

        if case .String(let barValue) = JSONDictionary["bar"]?.nullable {
            print(barValue) // Would print the string contained in "bar", if "bar" had a value and was a string.
        }
    */
    public var nullable: JSONValue? {
        switch self {
        case .Null: return nil
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
        case .String(let value) where ValueType.self == Swift.String.self: return (value as! ValueType)
        case .Double(let value) where ValueType.self == Swift.Double.self: return (value as! ValueType)
        case .Int(let value) where ValueType.self == Swift.Int64.self: return (value as! ValueType)
        case .Bool(let value) where ValueType.self == Swift.Bool.self: return (value as! ValueType)
        case .Array(let value) where ValueType.self == Swift.Array<JSONValue>.self: return (value as! ValueType)
        case .Dictionary(let value) where ValueType.self == Swift.Dictionary<Swift.String, JSONValue>.self: return (value as! ValueType)
        case .Null: throw JSONValueError.NoValue
        default: throw JSONValueError.TypeMismatch
        }
    }

    /**
        Returns the value contained in the `JSONValue`. If the expected return type isn't supported by
        `JSONValue`, or the the expected return type mismatches what is contained in this `JSONValue`,
        an error will be thrown. If the value is Null, this method will return nil.

        - Throws:   JSONValueError.TypeMismatch     If Value isn't the correct type held by the `JSONValue`.
        - Returns:  The associated value contained in the `JSONValue` when the correct type is passed.
    */
    public func value<ValueType: NilLiteralConvertible>() throws -> ValueType {
        // FIXME: This switch is using unsafeBitCast. This isn't ideal, but (Optional.Some(value) as! Value.self) is resulting
        // in a runtime error so it was necessary. For some reason the compiler things we're trying to force-cast the type of value
        // instead of an optional.
        switch self {
        case .String(let value) where ValueType.self == Swift.String.self: return (value as! ValueType)
        case .String(let value) where ValueType.self == Optional<Swift.String>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Double(let value) where ValueType.self == Swift.Double.self: return (value as! ValueType)
        case .Double(let value) where ValueType.self == Optional<Swift.Double>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Int(let value) where ValueType.self == Swift.Int64.self: return (value as! ValueType)
        case .Int(let value) where ValueType.self == Optional<Swift.Int64>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Bool(let value) where ValueType.self == Swift.Bool.self: return (value as! ValueType)
        case .Bool(let value) where ValueType.self == Optional<Swift.Bool>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Array(let value) where ValueType.self == Swift.Array<JSONValue>.self: return (value as! ValueType)
        case .Array(let value) where ValueType.self == Optional<Swift.Array<JSONValue>>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Dictionary(let value) where ValueType.self == Swift.Dictionary<Swift.String, JSONValue>.self: return (value as! ValueType)
        case .Dictionary(let value) where ValueType.self == Optional<Swift.Dictionary<Swift.String, JSONValue>>.self: return unsafeBitCast(Optional.Some(value), ValueType.self)
        case .Null: return nil
        default: throw JSONValueError.TypeMismatch
        }
    }
}

public enum JSONValueError: ErrorType {
    case TypeMismatch
    case NoValue
}

extension JSONValue: Equatable { }

public func == (lhs: JSONValue, rhs: JSONValue) -> Bool {
    switch lhs {
    case .String(let l):
        if case .String(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .Double(let l):
        if case .Double(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .Int(let l):
        if case .Int(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .Bool(let l):
        if case .Bool(let r) = rhs {
            return l == r
        } else {
            return false
        }
        
    case .Null:
        if case .Null = rhs {
            return true
        } else {
            return false
        }
    
    case .Array(let l):
        if case .Array(let r) = rhs where l.count == r.count {
            for (index, leftObject) in l.enumerate() {
                if leftObject != r[index] {
                    return false
                }
            }
            
            return true
        } else {
            return false
        }
        
    case .Dictionary(let l):
        if case .Dictionary(let r) = rhs where l.count == r.count {
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
