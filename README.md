JSONValue is the best way to represent JSON data in your Swift application. Each JSON type is a case in the JSONValue enum,
and with the use of new syntax and pattern matching, JSONValue provides a clean and robust way to access your data.

# Usage

The best way to explain how to use JSONValue is to give an example. For brevity, I'm banging a lot of API calls. Don't do this 
in your production code!

```swift
import JSONValue

// Our example string
let JSONDataString = "[\"wat\", 5, {\"foo\": 3.5, \"bar\": null, \"baz\": true}]"

// JSONValue comes with an NSData decoder; we'll use that to convert our string 
// to a JSONValue
let JSONData = JSONDataString.dataUsingEncoding(NSUTF8StringEncoding)!
let JSON = try! JSONValueJSONDataCoder().decodeJSONValue(JSONData)

// Lets access the first item in our array, confirming its a String type
guard case let .String(firstItemValue) = JSON[0] else {
    // If this block gets hit, the first item in our array isn't a string.
    // In our case it is so it isn't hit.
    return
}

// Now we have a local variable called firstItemValue that is a Swift.String 
// containing the value "wat"
print(firstItemValue) // Prints "wat"

guard case let .Int(secondItemValue) = JSON[1] else { return }

print(secondItemValue) // Prints 5

// Our third item is a dictionary. We'll extract that data out into a regular 
// Swift dictionary of type [String: JSONValue]
guard case let .Dictionary(thirdItemValue) = JSON[2] else { return }

// Now for some fancy Swift pattern matching. We want our JSONValue.Double's 
// value from thirdItemValue under the "foo" key:
guard case let .Double(fooValue)? = thirdItemValue["foo"] else { return }

print(fooValue) // Prints 3.5

// Lets skip over "bar" for now, and grab our "baz"

guard case let .Bool(bazValue)? = thirdItemValue["baz"] else { return }

print(bazValue) // Prints true

```

## Nullability

In the previous example there was a dictionary item with the key "bar", and it was set to null. JSONValue has a case
for Null, but its an awkward type to interact with; its the only one without an associated value, and expecting it to 
be there isn't something one would typically do. To account for nullable values theres a property on JSONValue called
nullable. Its a simple method: It returns an optional JSONValue. If the case is .Null, it returns nil, otherwise it
returns self. In our previous example, lets assume that "bar" can return a String, but in this case the data wasn't
there so the API returns null. Here's how we'd make use of it:

```swift
if case let .String(barValue)? = thirdItemValue["bar"]?.nullable {
    print(barValue) // Would print the string contained in "bar", if it had one.
}
```
