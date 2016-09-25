//
//  JSONValueJSONDataSerialization.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

import Foundation

private let trueNumber = NSNumber(value: true)
private let falseNumber = NSNumber(value: false)
private let trueObjCType = String(cString: trueNumber.objCType)
private let falseObjCType = String(cString: falseNumber.objCType)

extension NSNumber {
    fileprivate var isBool: Bool {
        let type = String(cString: objCType)
        return (compare(trueNumber) == .orderedSame && type == trueObjCType) || (compare(falseNumber) == .orderedSame && type == falseObjCType)
    }
    
    fileprivate var isDouble: Bool {
        let type = objCType.pointee
        return type == Int8(UnicodeScalar("d").value) || type == Int8(UnicodeScalar("f").value)
    }
}

/**
    A `JSONValueJSONDataCoder` handles conversion between a `Data` containing JSON Data and a
    `JSONValue`. Internally it uses the existing `JSONSerialization` class to handle the
    conversion.
*/
public class JSONValueJSONDataCoder: JSONValueCoder {
    public typealias ConversionType = Data
    
    public init() { }

    public func encodeJSONValue(_ value: JSONValue) throws -> ConversionType {
        switch value {
        case .array(_), .dictionary(_): return try JSONSerialization.data(withJSONObject: serializeJSONValue(toObject: value), options: [])
        default: throw JSONValueCoderError.notRootType
        }
    }

    public func decodeJSONValue(_ from: ConversionType) throws -> JSONValue {
        let object: Any
        
        do {
            object = try JSONSerialization.jsonObject(with: from, options: [])
        } catch let error as NSError {
            if error.code == 3840 && error.domain == NSCocoaErrorDomain {
                throw JSONValueCoderError.notRootType
            } else {
                throw error
            }
        }

        return try deserializeObject(object)
    }
    
    private func serializeJSONValue(toObject value: JSONValue) -> Any {
        var object: Any
        
        switch value {
        case .string(let s): object = s
        case .null: object = NSNull()
        case .int(let v): object = NSNumber(value: v as Int64)
        case .double(let v): object = NSNumber(value: v as Double)
        case .bool(let v): object = NSNumber(value: v as Bool)
        case .dictionary(let dict):
            let mutableDict = NSMutableDictionary()
            for (key, val) in dict {
                mutableDict.setValue(serializeJSONValue(toObject: val), forKey: key)
            }
            object = NSDictionary(dictionary: mutableDict)
        case .array(let array):
            let mutableArray = NSMutableArray()
            for obj in array {
                mutableArray.add(serializeJSONValue(toObject: obj))
            }
            
            object = NSArray(array: mutableArray)
        }
        
        return object
    }
    
    private func deserializeObject(_ object: Any) throws -> JSONValue {
        let convertedData: JSONValue
        
        if let array = object as? NSArray {
            var dataArray = [JSONValue]()
            
            for obj in array {
                dataArray.append(try deserializeObject(obj as AnyObject))
            }
            
            convertedData = JSONValue.array(dataArray)
        } else if let dict = object as? NSDictionary {
            var dataDict = [String: JSONValue]()
            
            for (key, obj) in dict {
                guard let k = key as? String else {
                    throw JSONValueCoderError.invalidObjectKey
                }
                
                dataDict[k] = try deserializeObject(obj as AnyObject)
            }
            
            convertedData = JSONValue.dictionary(dataDict)
        } else if let number = object as? NSNumber {
            if number.isBool {
                convertedData = JSONValue.bool(number.boolValue)
            } else if number.isDouble {
                convertedData = JSONValue.double(number.doubleValue)
            } else {
                convertedData = JSONValue.int(number.int64Value)
            }
        } else if let string = object as? NSString {
            convertedData = JSONValue.string(string as String)
        } else if object is NSNull {
            convertedData = JSONValue.null
        } else {
            throw JSONValueJSONDataCoderError.invalidObject
        }
        
        return convertedData
    }
}

/// Errors that are thrown during coding using a JSONValueJSONDataCoder.
public enum JSONValueJSONDataCoderError: Error {
    case invalidObject /// Thrown when an unconvertable type is found deserialized.
}
