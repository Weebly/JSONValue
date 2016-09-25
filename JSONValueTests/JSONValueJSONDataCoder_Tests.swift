//
//  JSONValueJSONDataCoder_Tests.swift
//  JSONValue
//
//  Created by James Richard on 6/26/15.
//  Copyright © 2015 Weebly. All rights reserved.
//

import JSONValue
import XCTest

class JSONValueJSONDataCoder_Tests: XCTestCase {
    var subject: JSONValueJSONDataCoder!
    
    override func setUp() {
        super.setUp()
        subject = JSONValueJSONDataCoder()
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    // MARK: encodeJSONValue
    
    func testEncodeJSONValue_withArray_encodesCorrectly() {
        let array: [JSONValue] = [
            .string("foo"),
            .int(5),
            .double(1.8),
            .bool(false),
            .null
        ]
        let value = JSONValue.array(array)
        let data = try! subject.encodeJSONValue(value)
        let result = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        let expected: NSArray = ["foo", 5, 1.8, false, NSNull()]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withDictionary_encodesCorrectly() {
        let dict: [String: JSONValue] = [
            "s": .string("bar"),
            "i": .int(10),
            "d": .double(5.3),
            "b": .bool(true),
            "n": .null
        ]
        let value = JSONValue.dictionary(dict)
        let data = try! subject.encodeJSONValue(value)
        let result = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        let expected: NSDictionary = ["s": "bar", "i": NSNumber(value: 10 as Int), "d": NSNumber(value: 5.3 as Double), "b": NSNumber(value: true as Bool), "n": NSNull()]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withComplicatedContents_encodesCorrectly() {
        let array: [JSONValue] = [
            .string("foo"),
            .dictionary([
                "bar": .int(7),
                "arr": .array([
                    .int(3),
                    .bool(true)
                ])
            ])
        ]
        
        let value = JSONValue.array(array)
        let data = try! subject.encodeJSONValue(value)
        let result = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        let expected: NSArray = ["foo", ["bar": 7, "arr": [3, true]]]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withJustString_throwsError() {
        do {
            _ = try subject.encodeJSONValue(.string("foo"))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustInt_throwsError() {
        do {
            _ = try subject.encodeJSONValue(.int(5))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustDouble_throwsError() {
        do {
            _ = try subject.encodeJSONValue(.double(5.3))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustBool_throwsError() {
        do {
            _ = try subject.encodeJSONValue(.bool(false))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustNull_throwsError() {
        do {
            _ = try subject.encodeJSONValue(.null)
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
   
    // MARK: decodeJSONValue

    func testDecodeJSONValue_withInvalidRootType_throwsError() {
        do {
            _ = try subject.decodeJSONValue(dataFromString("test"))
        } catch JSONValueCoderError.notRootType {
            return
        } catch { }
        
        XCTFail("Expected a JSONValueCoderError")
    }
    
    func testDecodeJSONValue_decodesCorrectly() {
        let data = "[\"wat\", 5, {\"foo\": 3.5, \"bar\": null, \"baz\": true}]"
        let value: JSONValue

        do {
            value = try subject.decodeJSONValue(dataFromString(data))
        } catch {
            XCTFail("Decoding failed when it shouldn't have.")
            return
        }

        guard case .array(let rootArray) = value else {
            XCTFail("Decoding generated an incorrect root element")
            return
        }

        guard case .string(let watValue) = rootArray[0] else {
            XCTFail("Decoding generated an incorrect first element")
            return
        }

        XCTAssertEqual(watValue, "wat")

        guard case .int(let fiveValue) = rootArray[1] else {
            XCTFail("Decoding generated an incorrect second element")
            return
        }

        XCTAssertEqual(fiveValue, 5)

        guard case .dictionary(let dictionaryValue) = rootArray[2] else {
            XCTFail("Decoding generated an incorrect third element")
            return
        }

        guard case .double(let fooValue)? = dictionaryValue["foo"] else {
            XCTFail("Decoding generated an incorrect foo element")
            return
        }

        XCTAssertEqual(fooValue, 3.5)

        guard let nullValue = dictionaryValue["bar"] else {
            XCTFail("Decoding generated an incorrect bar element")
            return
        }

        XCTAssertEqual(nullValue, JSONValue.null)

        guard case .bool(let bazValue)? = dictionaryValue["baz"] else {
            XCTFail("Decoding generated an incorrect baz element")
            return
        }

        XCTAssertEqual(bazValue, true)
    }
    
    // MARK: Helpers
    
    func dataFromString(_ s: String) -> Data {
        return s.data(using: String.Encoding.utf8)!
    }
}
