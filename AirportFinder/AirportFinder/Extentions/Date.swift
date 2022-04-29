//
//  Date.swift
//  AirportFinder
//
//  Created by Amin on 2/9/1401 AP.
//

import Foundation

extension Data {
    init<T>(from value: T) {
        var value = value
        var myData = Data()
        withUnsafePointer(to: &value, { (ptr: UnsafePointer<T>) -> Void in
            myData = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
        })
        self.init(myData)
    }
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
