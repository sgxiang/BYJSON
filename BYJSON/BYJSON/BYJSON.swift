//
//  BYJSON.swift
//  BYJSON
//
//  Created by ysq on 15/12/8.
//  Copyright © 2015年 ysq. All rights reserved.
//

import UIKit

public enum BYJsonError: ErrorType {
    case InvalidObject
    case InvalidData
}

public enum BYJsonType : Int{
    case Number
    case String
    case Bool
    case Array
    case Dictionary
}

public struct BYJson{
    
    private var jsonObject: AnyObject?
    private var type : BYJsonType!
    
    public init(data : NSData) throws{
        do{
            self.jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if self.jsonObject as? [AnyObject] != nil{
                self.type = .Array
            }else if self.jsonObject as? [String:AnyObject] != nil{
                self.type = .Dictionary
            }
        }catch _{
            throw BYJsonError.InvalidData
        }
    }
    
    private init(object : AnyObject) throws{
        switch object{
        case let num as NSNumber:
            if num.isBool{
                type = .Bool
            }else{
                type = .Number
            }
            jsonObject = num
        case let str as String:
            type = .String
            jsonObject = str
        case let arr as [AnyObject]:
            type = .Array
            jsonObject = arr
        case let dic as [String : AnyObject]:
            type = .Dictionary
            jsonObject = dic
        default:
            throw BYJsonError.InvalidObject
        }
    }
    
}

extension BYJson{
    
    public var isArray : Bool{
        get{
            return type == .Array
        }
    }
    public var isDictionary : Bool{
        get{
            return type == .Dictionary
        }
    }
    public var isNumber : Bool{
        get{
            return type == .Number
        }
    }
    public var isBool : Bool{
        get{
            return type == .Bool
        }
    }
    public var isString : Bool{
        get{
            return type == .String
        }
    }
    public var array : [AnyObject]{
        get{
            return jsonObject as? [AnyObject] ?? []
        }
    }
    public var dictionary : [String:AnyObject]{
        get{
            return jsonObject as? [String:AnyObject] ?? [String:AnyObject]()
        }
    }
    public var number : NSNumber{
        get{
            return jsonObject as? NSNumber ?? 0
        }
    }
    public var bool : Bool{
        get{
            return jsonObject as? Bool ?? false
        }
    }
    public var string : String{
        get{
            return jsonObject as? String ?? ""
        }
    }
    
}

extension BYJson{
    
    public subscript(key : String) -> BYJson?{
        guard self.type == .Dictionary && self.dictionary.keys.contains(key) else{
            return nil
        }
        do{
            let json = try BYJson(object: self.dictionary[key]!)
            return json
        }catch _{
            return nil
        }
    }
    
    public subscript(index : NSInteger) -> BYJson?{
        guard self.type == .Array && self.array.count > index else{
            return nil
        }
        do{
            let json = try BYJson(object: self.array[index])
            return json
        }catch _{
            return nil
        }
    }
}


// MARK: - NSNumber: Comparable

private let trueNumber = NSNumber(bool: true)
private let falseNumber = NSNumber(bool: false)
private let trueObjCType = String.fromCString(trueNumber.objCType)
private let falseObjCType = String.fromCString(falseNumber.objCType)

private extension NSNumber{
    var isBool:Bool {
        get {
            let objCType = String.fromCString(self.objCType)
            if (self.compare(trueNumber) == NSComparisonResult.OrderedSame && objCType == trueObjCType)
                || (self.compare(falseNumber) == NSComparisonResult.OrderedSame && objCType == falseObjCType){
                    return true
            } else {
                return false
            }
        }
    }
}
