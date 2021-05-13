//
//  DispatchQueue+Ext.swift
//  Films
//
//  Created by iOS_Coder on 13.05.2021.
//

import Foundation

extension DispatchQueue {
    static func anywayOnMain<T>(closure: () throws -> T) throws -> T {
        guard Thread.isMainThread else {
            return try main.sync(execute: closure)
        }

        return try closure()
    }
}
