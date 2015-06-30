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
    case Array([JSONValueWrapper])
    case Dictionary([Swift.String: JSONValueWrapper])
//    indirect case Array([JSONValue])
//    indirect case Dictionary([Swift.String: JSONValue])

    public var nullable: JSONValue? {
        switch self {
        case .Null: return nil
        default: return self
        }
    }
}

// TODO: When we can support recurisve enums, remove this
public struct JSONValueWrapper {
    public let value: JSONValue
    public init(value: JSONValue) {
        self.value = value
    }
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
                if leftObject.value != r[index].value {
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
                if leftObject.value != r[key]?.value {
                    return false
                }
            }
            
            return true
        } else {
            return false
        }
    }
}
