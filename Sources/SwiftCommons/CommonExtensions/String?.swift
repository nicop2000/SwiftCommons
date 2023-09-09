//
//  File.swift
//  
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension Optional where Wrapped == String {
    func isEmptyOrWhitespace() -> Bool {
        guard let this = self else { return true }
        return this.isEmptyOrWhitespace()
    }
}
