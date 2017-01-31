//
//  PropertyReflectable.swift
//  Alarm-ios-swift
//
//  Created by natsu1211 on 2017/01/30.
//  Copyright © 2017年 LongGames. All rights reserved.
//

import Foundation

protocol PropertyReflectable : CustomReflectable{
    typealias RepresentationType = [String:Any]
    typealias ValuesType = [Any]
    typealias NamesType = [String]
    var propertyDictRepresentation: RepresentationType {get}
    var propertyValues: ValuesType {get}
    var propertyNames: NamesType {get}
    //construction from representation type
    init(_ r:RepresentationType)
}


//default implementation
extension PropertyReflectable{
    
    var customMirror: Mirror {
        return Mirror(reflecting: self)
    }
    
    var propertyDictRepresentation: RepresentationType {
        var ret: [String:Any] = [:]
        for case let (label, value) in customMirror.children {
            guard let l = label else{
                continue
            }
            ret.updateValue(value, forKey: l)
        }
        return ret
    }
    
    var propertyValues: ValuesType {
        return Array(propertyDictRepresentation.values)
    }
    
    var propertyNames: NamesType {
        return Array(propertyDictRepresentation.keys)
    }
}
