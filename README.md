# BYJSON
简洁的JSON辅助库

--------

![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

## Requirements

- iOS 8.0+ 
- Xcode 7.0
- Swift 2.0

## Usage 

```swift
import BYJSON
```

```swift
let data = NSData(contentsOfURL: NSURL(string: "http://httpbin.org/get?hello=world")!)!
do{
	let json : BYJson = try BYJson(data: data)
	print(json)
    //method
    print(json.isArray)          // false
    print(json.isDictionary)     // true
    print(json.isNumber)         // false
    print(json.isBool)           // false
    print(json.isString)         // false
    
    print(json.array)            // []
    print(json.dictionary)       // some dic
    print(json.number)           // 0
    print(json.bool)             // false
    print(json.string)           // ""
    
    print(json["args"]?.dictionary)         // ["hello":"world"]
    print(json[0])                         // nil
    print(json["args"]?["hello"]?.string)  // Optional("world")
    
}catch let error{
	print(error)
}


```

## Communication

- Found a bug or have a feature request? [Open an issue](https://github.com/sgxiang/BYJSON/issues).

- Want to contribute? [Submit a pull request](https://github.com/sgxiang/BYJSON/pulls).

## Author

- [sgxiang](https://twitter.com/sgxiang1992)

