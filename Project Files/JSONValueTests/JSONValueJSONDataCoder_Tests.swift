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
        let array: [JSONValueWrapper] = [
            JSONValueWrapper(value: .String("foo")),
            JSONValueWrapper(value: .Int(5)),
            JSONValueWrapper(value: .Double(1.8)),
            JSONValueWrapper(value: .Bool(false)),
            JSONValueWrapper(value: .Null)
        ]
        let value = JSONValue.Array(array)
        let data = try! subject.encodeJSONValue(value)
        let result = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
        let expected: NSArray = ["foo", 5, 1.8, false, NSNull()]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withDictionary_encodesCorrectly() {
        let dict: [String: JSONValueWrapper] = [
            "s": JSONValueWrapper(value: .String("bar")),
            "i": JSONValueWrapper(value: .Int(10)),
            "d": JSONValueWrapper(value: .Double(5.3)),
            "b": JSONValueWrapper(value: .Bool(true)),
            "n": JSONValueWrapper(value: .Null)
        ]
        let value = JSONValue.Dictionary(dict)
        let data = try! subject.encodeJSONValue(value)
        let result = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
        let expected: NSDictionary = ["s": "bar", "i": NSNumber(integer: 10), "d": NSNumber(double: 5.3), "b": NSNumber(bool: true), "n": NSNull()]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withComplicatedContents_encodesCorrectly() {
        let array: [JSONValueWrapper] = [
            JSONValueWrapper(value: .String("foo")),
            JSONValueWrapper(value: .Dictionary([
                "bar": JSONValueWrapper(value: .Int(7)),
                "arr": JSONValueWrapper(value: .Array([
                    JSONValueWrapper(value: .Int(3)),
                    JSONValueWrapper(value: .Bool(true))
                ]))
            ]))
        ]
        
        let value = JSONValue.Array(array)
        let data = try! subject.encodeJSONValue(value)
        let result = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
        let expected: NSArray = ["foo", ["bar": 7, "arr": [3, true]]]
        XCTAssertEqual(result, expected)
    }
    
    func testEncodeJSONValue_withJustString_throwsError() {
        do {
            try subject.encodeJSONValue(.String("foo"))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustInt_throwsError() {
        do {
            try subject.encodeJSONValue(.Int(5))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustDouble_throwsError() {
        do {
            try subject.encodeJSONValue(.Double(5.3))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustBool_throwsError() {
        do {
            try subject.encodeJSONValue(.Bool(false))
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
    
    func testEncodeJSONValue_withJustNull_throwsError() {
        do {
            try subject.encodeJSONValue(.Null)
        } catch {
            return
        }
        
        XCTFail("Expected an error")
    }
   
    // MARK: decodeJSONValue

    func testDecodeJSONValue_withInvalidRootType_throwsError() {
        do {
            try subject.decodeJSONValue(dataFromString("test"))
        } catch JSONValueCoderError.NotRootType {
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

        guard case let .Array(rootArray) = value else {
            XCTFail("Decoding generated an incorrect root element")
            return
        }

        guard case let .String(watValue) = rootArray[0].value else {
            XCTFail("Decoding generated an incorrect first element")
            return
        }

        XCTAssertEqual(watValue, "wat")

        guard case let .Int(fiveValue) = rootArray[1].value else {
            XCTFail("Decoding generated an incorrect second element")
            return
        }

        XCTAssertEqual(fiveValue, 5)

        guard case let .Dictionary(dictionaryValue) = rootArray[2].value else {
            XCTFail("Decoding generated an incorrect third element")
            return
        }

        guard case let .Double(fooValue)? = dictionaryValue["foo"]?.value else {
            XCTFail("Decoding generated an incorrect foo element")
            return
        }

        XCTAssertEqual(fooValue, 3.5)

        guard let nullValue = dictionaryValue["bar"]?.value else {
            XCTFail("Decoding generated an incorrect bar element")
            return
        }

        XCTAssertEqual(nullValue, JSONValue.Null)

        guard case let .Bool(bazValue)? = dictionaryValue["baz"]?.value else {
            XCTFail("Decoding generated an incorrect baz element")
            return
        }

        XCTAssertEqual(bazValue, true)
    }
    
    // MARK: Helpers
    
    func dataFromString(s: String) -> NSData {
        return s.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
