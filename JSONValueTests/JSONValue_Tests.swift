//
//  JSONValue_Tests.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

import JSONValue
import XCTest

class JSONValue_Tests: XCTestCase {

    // MARK: nullable

    func testNullable_withString_returnsString() {
        let value = JSONValue.String("foo")
        guard case .String(let fooString)? = value.nullable else {
            XCTFail("Nullable returned incorrect value")
            return
        }
        
        XCTAssertEqual(fooString, "foo")
    }

    func testNullable_withNull_expectingString_returnsNil() {
        let value = JSONValue.Null
        if case .String(let nullString)? = value.nullable {
            XCTFail("Expected a null value, but extracted a String: \(nullString)")
        }
    }
    
    // MARK: String Equality
    
    func testEqualty_forEqualStrings_isTrue() {
        let left = JSONValue.String("foo")
        let right = JSONValue.String("foo")
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalStrings_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndDouble_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Double(5.9)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndInt_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Int(3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndBool_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndNull_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndArray_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndDictionary_isFalse() {
        let left = JSONValue.String("foo")
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Double Equality
    
    func testEquality_forEqualDoubles_isTrue() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Double(6.3)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalDoubles_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Double(3.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndString_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndInt_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Int(2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndBool_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndNull_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndArray_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndDictionary_isFalse() {
        let left = JSONValue.Double(6.3)
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Int Equality
    
    func testEquality_forEqualInts_isTrue() {
        let left = JSONValue.Int(5)
        let right = JSONValue.Int(5)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalInts_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Double(2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndString_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndDouble_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Double(0.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndBool_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndNull_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndArray_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Array([JSONValue.Int(3)))
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndDictionary_isFalse() {
        let left = JSONValue.Int(6)
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Bool Equality
    
    func testEquality_forEqualBools_isTrue() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Bool(true)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalBools_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndString_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndDouble_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Double(5.2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndInt_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndNull_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndArray_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndDictionary_isFalse() {
        let left = JSONValue.Bool(true)
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Null Equality
    
    func testEquality_forNulls_isTrue() {
        let left = JSONValue.Null
        let right = JSONValue.Null
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forNullAndString_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndDouble_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.Double(5.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndInt_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.Int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndBool_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndArray_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndDictionary_isFalse() {
        let left = JSONValue.Null
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Array Equality
    
    func testEquality_forEqualArrays_isTrue() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalArrays_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Array([JSONValue.Int(2)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndString_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndDouble_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Double(0.5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndInt_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndBool_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndNull_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndDictionary_isFalse() {
        let left = JSONValue.Array([JSONValue.Int(3)])
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Dictionary Equality
    
    func testEquality_forEqualDictionarys_isTrue() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalDictionarys_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Dictionary(["bar": JSONValue.Int(4)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndString_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.String("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndDouble_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Double(5.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndInt_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndBool_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndNull_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndArray_isFalse() {
        let left = JSONValue.Dictionary(["bar": JSONValue.Int(3)])
        let right = JSONValue.Array([JSONValue.Int(3)])
        XCTAssertFalse(left == right)
    }
}
