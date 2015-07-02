//
//  JSONValueCoder.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

/**
    A JSONValueCoder represents a way to convert to and from a JSONValue. Implementations 
    can convert to and from any data by specifying the ConversionType.
*/
public protocol JSONValueCoder {
    typealias ConversionType

    /**
        Encodes a JSONValue into the `ConversionType`.
    
        This method will throw an error if the `JSONValue` is not a proper root type.
    
        - parameter value: The `JSONValue` to convert.
    */
    func encodeJSONValue(value: JSONValue) throws -> ConversionType

    /**
        Decodes a `JSONValue` from the `ConversionType`.
    
        This method will throw an error if the `ConversionType` cannot be represented completely
        by a `JSONValue`.
    
        - parameter     from:   The ConversionType to transform into a `JSONValue`
    */
    func decodeJSONValue(from: ConversionType) throws -> JSONValue
}

/// Common errors thrown while coding `JSONValue`s.
public enum JSONValueCoderError: ErrorType {
    case NotRootType
    case InvalidObjectKey
    case InvalidObject
}
