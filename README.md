JSONValue is the best way to represent JSON data in your Swift application. Each JSON type is a case in the JSONValue enum,
and with the use of new syntax and pattern matching, JSONValue provides a clean and robust way to access your data.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Usage

The best way to explain how to use JSONValue is to give an example. There are two ways to work with JSONValue. You can use
Pattern Matching, which is built into Swift for working with enums, or you can use the value() method, which will make
use of Swift's error handling when something goes wrong. For brevity, I'm unsafely unwrapping a lot of API calls. Don't do this 
in your production code!

## Pattern Matching

```swift
import JSONValue

// Our example string
let JSONDataString = "[\"wat\", 5, {\"foo\": 3.5, \"bar\": null, \"baz\": true}]"

// JSONValue comes with an NSData decoder; we'll use that to convert our string 
// to a JSONValue
let JSONData = JSONDataString.dataUsingEncoding(.utf8)!
let JSONRoot = try! JSONValueJSONDataCoder().decodeJSONValue(JSONData)

// Start by pulling out our root item; JSON will be a [JSONValue], and we can access it
// like any other array.
guard case .array(let JSON) = JSONRoot else {
    return
}

// Let's access the first item in our array, confirming its a String type
guard case .string(let firstItemValue) = JSON[0] else {
    // If this block gets hit, the first item in our array isn't a string.
    // In our case it is so it isn't hit. Using guard this way
    // allows you to fail early when the JSON isn't what you expect
    return
}

// Now we have a local variable called firstItemValue that is a Swift.String 
// containing the value "wat"
print(firstItemValue) // Prints "wat"

// You can also use if instead of guard, if you don't care as much about
// the variable being what you expect it to be.
if case .Int(let secondItemValue) = JSON[1] {
    print(secondItemValue) // Prints 5
}

// Our third item is a dictionary. We'll extract that data out into a regular 
// Swift dictionary of type [String: JSONValue]

// Guard also makes a matched variable available at the scope it was
// called. This allows you to prevent nesting ifs if the condition
// is required for subsequent statements. In this use of guard
// I'll place the let before the case; this is typical when
// an enum has more than one associated value.
guard case let .dictionary(thirdItemValue) = JSON[2] else { return }

// Now for some fancy Swift pattern matching. We want our JSONValue.Double's 
// value from thirdItemValue under the "foo" key:
guard case .double(let fooValue)? = thirdItemValue["foo"] else { return }

// Note that our ? in the above example is a use of the new Optional
// pattern matching in Swift 2. It unwraps the dictionary result for
// us.

print(fooValue) // Prints 3.5

// Let's skip over "bar" for now, and grab our "baz"

guard case .bool(let bazValue)? = thirdItemValue["baz"] else { return }

print(bazValue) // Prints true

```

### Nullability

In the previous example there was a dictionary item with the key "bar", and it was set to null. JSONValue has a case
for Null, but it's an awkward type to interact with; it's the only one without an associated value, and expecting it to 
be there isn't something one would typically do. To account for nullable values theres a property on JSONValue called
nullable. Its a simple method: It returns an optional JSONValue. If the case is .Null, it returns nil, otherwise it
returns self. In our previous example, lets assume that "bar" can return a String, but in this case the data wasn't
there so the API returns null. Here's how we'd make use of it:

```swift
if case .String(let barValue)? = thirdItemValue["bar"]?.nullable {
    print(barValue) // Would print the string contained in "bar", if it had one.
}
```

## value() and error handling

We're going to skip over decoding here as it's in the above example.

```swift
// Let's access the first item in our array, confirming it's a String type
let firstItemValue: String = try JSON[0].value()

// Now we have a local variable called firstItemValue that is a Swift.String 
// containing the value "wat"
print(firstItemValue) // Prints "wat"

let secondItemValue: Int64 = try JSON[1].value()
print(secondItemValue) // Prints 5


// Our third item is a dictionary. We'll extract that data out into a regular 
// Swift dictionary of type [String: JSONValue]

let thirdItemValue: [String: JSONValue] = try JSON[2].value()

// value() supports working with optionals. If there isn't a value at "foo", or the value
// is .Null, we'll return nil:
let fooValue: Double? = try thirdItemValue["foo"]?.value()

if let unwrapped = fooValue {
    print(unwrapped) // Prints 3.5
}

// You can also unwrap into a non-optional
if let unwrapped: Double = try thirdItemValue["foo"]?.value() {
    print(unwrapped) // Prints 3.5
}

// An example of a nil item:
let watValue: Double? = try thirdItemValue["wat"]?.value()

print(watValue) // Prints nil

```

# Custom Coders

JSONValue comes with a single coder, JSONValueJSONDataCoder. It implements the JSONValueCoder protocol, which has
an interface that defines best practices when working with JSON data, such as error handling and bi-directional
coding. JSONValueJSONDataCoder uses Foundation's NSJSONSerialization class under the hood to keep the library
small, but that may not be the fastest option for you. 

If you'd like create your own JSONValueCoder I suggest looking at the JSONValueJSONDataCoder implementation. Of 
course, if you'd prefer you can create your own encoder or decoder implementations and create them as you'd like. None
of JSONValue is bound to the JSONValueCoder protocol.

# Contact

* If you need help or have a general question use [Stack Overflow](https://stackoverflow.com/questions/tagged/jsonvalue)
* If you've found a bug or have a feature request [open an issue](https://github.com/weebly/JSONValue/issues/new)

We're also frequently in the [Gitter](https://gitter.im/weebly/JSONValue) chatroom!

# Contributing

We love to have your help to make JSONValue better. Feel free to

- open an issue if you run into any problem.
- fork the project and submit pull request.

# License

Copyright (c) 2015, Weebly All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. Neither the name of Weebly nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Weebly, Inc BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
