//
//  Data.swift
//  
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension Data {
    public var bytes: Array<UInt8> {
      Array(self)
    }
}
