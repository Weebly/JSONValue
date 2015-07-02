//
//  JSONValueJSONDataSerialization.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

import Foundation

private let trueNumber = NSNumber(bool: true)
private let falseNumber = NSNumber(bool: false)
private let trueObjCType = String.fromCString(trueNumber.objCType)
private let falseObjCType = String.fromCString(falseNumber.objCType)

extension NSNumber {
    private var isBool: Bool {
        let type = String.fromCString(objCType)
        return (compare(trueNumber) == .OrderedSame && type == trueObjCType) || (compare(falseNumber) == .OrderedSame && type == falseObjCType)
    }
    
    private var isDouble: Bool {
        let type = objCType.memory
        return type == Int8(UnicodeScalar("d").value) || type == Int8(UnicodeScalar("f").value)
    }
}

/**
    A `JSONValueJSONDataCoder` handles conversion between an `NSData` containing JSON Data and a
    `JSONValue`. Internally it uses the existing `NSJSONSerialization` class to handle the
    conversion.
*/
public class JSONValueJSONDataCoder: JSONValueCoder {
    public typealias ConversionType = NSData
    
    public init() { }

    public func encodeJSONValue(value: JSONValue) throws -> ConversionType {
        switch value {
        case .Array(_), .Dictionary(_): return try NSJSONSerialization.dataWithJSONObject(serializeJSONValueToObject(value), options: [])
        default: throw JSONValueCoderError.NotRootType
        }
    }

    public func decodeJSONValue(from: ConversionType) throws -> JSONValue {
        let object: AnyObject
        
        do {
            object = try NSJSONSerialization.JSONObjectWithData(from, options: [])
        } catch let error as NSError {
            if error.code == 3840 && error.domain == NSCocoaErrorDomain {
                throw JSONValueCoderError.NotRootType
            } else {
                throw error
            }
        }

        return try deserializeObject(object)
    }
    
    private func serializeJSONValueToObject(value: JSONValue) -> AnyObject {
        var object: AnyObject
        
        switch value {
        case .String(let s): object = s
        case .Null: object = NSNull()
        case .Int(let v): object = NSNumber(longLong: v)
        case .Double(let v): object = NSNumber(double: v)
        case .Bool(let v): object = NSNumber(bool: v)
        case .Dictionary(let dict):
            let mutableDict = NSMutableDictionary()
            for (key, val) in dict {
                mutableDict.setValue(serializeJSONValueToObject(val.value), forKey: key)
            }
            object = NSDictionary(dictionary: mutableDict)
        case .Array(let array):
            let mutableArray = NSMutableArray()
            for obj in array {
                mutableArray.addObject(serializeJSONValueToObject(obj.value))
            }
            
            object = NSArray(array: mutableArray)
        }
        
        return object
    }
    
    private func deserializeObject(object: AnyObject) throws -> JSONValue {
        let convertedData: JSONValue
        
        if let array = object as? NSArray {
            var dataArray = [JSONValueWrapper]()
            
            for obj in array {
                dataArray.append(JSONValueWrapper(value: try deserializeObject(obj)))
            }
            
            convertedData = JSONValue.Array(dataArray)
        } else if let dict = object as? NSDictionary {
            var dataDict = [String: JSONValueWrapper]()
            
            for (key, obj) in dict {
                guard let k = key as? String else {
                    throw JSONValueCoderError.InvalidObjectKey
                }
                
                dataDict[k] = JSONValueWrapper(value: try deserializeObject(obj))
            }
            
            convertedData = JSONValue.Dictionary(dataDict)
        } else if let number = object as? NSNumber {
            if number.isBool {
                convertedData = JSONValue.Bool(number.boolValue)
            } else if number.isDouble {
                convertedData = JSONValue.Double(number.doubleValue)
            } else {
                convertedData = JSONValue.Int(number.longLongValue)
            }
        } else if let string = object as? NSString {
            convertedData = JSONValue.String(string as String)
        } else if object is NSNull {
            convertedData = JSONValue.Null
        } else {
            throw JSONValueJSONDataCoderError.InvalidObject
        }
        
        return convertedData
    }
}

/// Errors that are thrown during coding using a JSONValueJSONDataCoder.
public enum JSONValueJSONDataCoderError: ErrorType {
    case InvalidObject /// Thrown when an unconvertable type is found deserialized.
}
