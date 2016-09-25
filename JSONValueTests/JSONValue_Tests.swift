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
        let value = JSONValue.string("foo")
        guard case .string(let fooString)? = value.nullable else {
            XCTFail("Nullable returned incorrect value")
            return
        }
        
        XCTAssertEqual(fooString, "foo")
    }

    func testNullable_withNull_expectingString_returnsNil() {
        let value = JSONValue.null
        if case .string(let nullString)? = value.nullable {
            XCTFail("Expected a null value, but extracted a String: \(nullString)")
        }
    }
    
    // MARK: String Equality
    
    func testEqualty_forEqualStrings_isTrue() {
        let left = JSONValue.string("foo")
        let right = JSONValue.string("foo")
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalStrings_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndDouble_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.double(5.9)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndInt_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.int(3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndBool_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndNull_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndArray_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forStringAndDictionary_isFalse() {
        let left = JSONValue.string("foo")
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Double Equality
    
    func testEquality_forEqualDoubles_isTrue() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.double(6.3)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalDoubles_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.double(3.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndString_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndInt_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.int(2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndBool_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndNull_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndArray_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDoubleAndDictionary_isFalse() {
        let left = JSONValue.double(6.3)
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Int Equality
    
    func testEquality_forEqualInts_isTrue() {
        let left = JSONValue.int(5)
        let right = JSONValue.int(5)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalInts_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.double(2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndString_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndDouble_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.double(0.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndBool_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndNull_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndArray_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forIntAndDictionary_isFalse() {
        let left = JSONValue.int(6)
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Bool Equality
    
    func testEquality_forEqualBools_isTrue() {
        let left = JSONValue.bool(true)
        let right = JSONValue.bool(true)
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalBools_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndString_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndDouble_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.double(5.2)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndInt_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndNull_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndArray_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forBoolAndDictionary_isFalse() {
        let left = JSONValue.bool(true)
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Null Equality
    
    func testEquality_forNulls_isTrue() {
        let left = JSONValue.null
        let right = JSONValue.null
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forNullAndString_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndDouble_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.double(5.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndInt_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndBool_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndArray_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forNullAndDictionary_isFalse() {
        let left = JSONValue.null
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Array Equality
    
    func testEquality_forEqualArrays_isTrue() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalArrays_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.array([JSONValue.int(2)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndString_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndDouble_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.double(0.5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndInt_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndBool_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndNull_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forArrayAndDictionary_isFalse() {
        let left = JSONValue.array([JSONValue.int(3)])
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }
    
    // MARK: Dictionary Equality
    
    func testEquality_forEqualDictionarys_isTrue() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.dictionary(["bar": JSONValue.int(3)])
        XCTAssertTrue(left == right)
    }
    
    func testEquality_forInequalDictionarys_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.dictionary(["bar": JSONValue.int(4)])
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndString_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.string("bar")
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndDouble_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.double(5.3)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndInt_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.int(5)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndBool_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.bool(false)
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndNull_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.null
        XCTAssertFalse(left == right)
    }
    
    func testEquality_forDictionaryAndArray_isFalse() {
        let left = JSONValue.dictionary(["bar": JSONValue.int(3)])
        let right = JSONValue.array([JSONValue.int(3)])
        XCTAssertFalse(left == right)
    }

    // MARK: Value

    func testValue_forString_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let value: String = try subject.value()
            XCTAssertEqual(value, "foo")
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forInt_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let value: Int64 = try subject.value()
            XCTAssertEqual(value, 6)
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forString_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let value: Bool = try subject.value()
            XCTAssertEqual(value, true)
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forString_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let value: Double = try subject.value()
            XCTAssertEqual(value, 5.3)
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forString_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let value: [JSONValue] = try subject.value()
            XCTAssertEqual(value, [JSONValue.int(5)])
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forString_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let value: [String: JSONValue] = try subject.value()
            XCTAssertEqual(value, ["foo": JSONValue.int(5)])
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testValue_forString_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forString_whenNull() {
        let subject = JSONValue.null
        do {
            let _: String = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forInt_whenNull() {
        let subject = JSONValue.null
        do {
            let _: Int64 = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forBool_whenNull() {
        let subject = JSONValue.null
        do {
            let _: Bool = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDouble_whenNull() {
        let subject = JSONValue.null
        do {
            let _: Double = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forArray_whenNull() {
        let subject = JSONValue.null
        do {
            let _: [JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testValue_forDictionary_whenNull() {
        let subject = JSONValue.null
        do {
            let _: [String: JSONValue] = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    // MARK: nullableValue

    func testNullableValue_forString_whenString() {
        let subject = JSONValue.string("foo")
        do {
            if let value: String = try subject.value() {
                XCTAssertEqual(value, "foo")
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalString_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let value: String? = try subject.value()
            if let unwrapped = value {
                XCTAssertEqual(unwrapped, "foo")
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forInt_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Int64? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Double? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: Bool? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: [JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenString() {
        let subject = JSONValue.string("foo")
        do {
            let _: [String: JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forInt_whenInt() {
        let subject = JSONValue.int(6)
        do {
            if let value: Int64 = try subject.value() {
                XCTAssertEqual(value, 6)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalInt_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let value: Int64? = try subject.value()
            if let unwrapped = value {
                XCTAssertEqual(unwrapped, 6)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forString_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: String? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: Double? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: Bool? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: [JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenInt() {
        let subject = JSONValue.int(6)
        do {
            let _: [String: JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            if let value: Bool = try subject.value() {
                XCTAssertTrue(value)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalBool_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let value: Bool? = try subject.value()
            if let unwrapped = value {
                XCTAssertTrue(unwrapped)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forString_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: String? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: Double? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forInt_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: Int64? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: [JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenBool() {
        let subject = JSONValue.bool(true)
        do {
            let _: [String: JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            if let value: Double = try subject.value() {
                XCTAssertEqual(value, 5.3)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalDouble_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let value: Double? = try subject.value()
            if let unwrapped = value {
                XCTAssertEqual(unwrapped, 5.3)
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forString_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: String? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forInt_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: Int64? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: Bool? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: [JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenDouble() {
        let subject = JSONValue.double(5.3)
        do {
            let _: [String: JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            if let value: [JSONValue] = try subject.value() {
                XCTAssertEqual(value, [JSONValue.int(5)])
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalArray_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let value: [JSONValue]? = try subject.value()
            if let unwrapped = value {
                XCTAssertEqual(unwrapped, [JSONValue.int(5)])
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forString_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: String? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forInt_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Int64? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Bool? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: Double? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenArray() {
        let subject = JSONValue.array([JSONValue.int(5)])
        do {
            let _: [String: JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDictionary_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            if let value: [String: JSONValue] = try subject.value() {
                XCTAssertEqual(value, ["foo": JSONValue.int(5)])
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forOptionalDictionary_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let value: [String: JSONValue]? = try subject.value()
            if let unwrapped = value {
                XCTAssertEqual(unwrapped, ["foo": JSONValue.int(5)])
            } else {
                XCTFail("Unexpected null value")
            }
        } catch {
            XCTFail("Invalid value returned")
        }
    }

    func testNullableValue_forString_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: String? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forInt_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Int64? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forBool_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Bool? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forDouble_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: Double? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forArray_whenDictionary() {
        let subject = JSONValue.dictionary(["foo": JSONValue.int(5)])
        do {
            let _: [JSONValue]? = try subject.value()
            XCTFail("Value returned successfully when it shouldn't have")
        } catch { }
    }

    func testNullableValue_forString_whenNull() {
        let subject = JSONValue.null
        do {
            let value: String? = try subject.value()
            XCTAssertNil(value)
        } catch { }
    }

    func testNullableValue_forInt_whenNull() {
        let subject = JSONValue.null
        do {
            let value: Int64? = try subject.value()
            XCTAssertTrue(value == nil)
        } catch { }
    }

    func testNullableValue_forBool_whenNull() {
        let subject = JSONValue.null
        do {
            let value: Bool? = try subject.value()
            XCTAssertTrue(value == nil)
        } catch { }
    }

    func testNullableValue_forDouble_whenNull() {
        let subject = JSONValue.null
        do {
            let value: Double? = try subject.value()
            XCTAssertTrue(value == nil)
        } catch { }
    }

    func testNullableValue_forArray_whenNull() {
        let subject = JSONValue.null
        do {
            let value: [JSONValue]? = try subject.value()
            XCTAssertTrue(value == nil)
        } catch { }
    }

    func testNullableValue_forDictionary_whenNull() {
        let subject = JSONValue.null
        do {
            let value: [String: JSONValue]? = try subject.value()
            XCTAssertTrue(value == nil)
        } catch { }
    }
}
