//
//  String.swift
//
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension String {
    func shorten(_ count: Int) -> String {
        if self.isEmpty {
            return ""
        } else if count <= 0 {
            return ""
        } else if self.count <= count {
            return self
        } else {
            let index = self.index(self.startIndex, offsetBy: count)
            return String(self[..<index])
        }
    }

    func fromBase64() -> String? {
        Coder().decodeBase64(base64String: self)
    }

    func toBase64() -> String {
        Coder().encodeBase64(string: self)
    }

    func isEmptyOrWhitespace() -> Bool {
        self.isEmpty && self.trim().isEmpty
    }

    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func isNumeric() -> Bool {
        NumberFormatter().number(from: self) != nil
    }
}
