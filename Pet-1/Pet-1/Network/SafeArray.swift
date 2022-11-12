//
//  SafeArray.swift
//  Pet-1
//
//  Created by Алексей on 11/12/22.
//

import Foundation


class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "Queue", attributes: .concurrent)
    public func append(_ value: T){
        queue.async( flags: .barrier){
            self.array.append(value)
        }
    }
    public var valueArray: [T]{
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
    
    
}
