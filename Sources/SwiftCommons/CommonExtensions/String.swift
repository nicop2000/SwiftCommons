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

    func toBool() -> Bool {
        ["TRUE", "YES", "1"].contains(self.lowercased())
    }
    
    func containsOrSimilarityTo(_ str: String, _ percentage: Double) -> Bool {
        if str.starts(with: self) {
            return true
        }
        if self.starts(with: str) {
            return true
        }
        if self.contains(str) {
            return true
        }
        if str.contains(self) {
            return true
        }
        
        let length1 = self.count
        let length2 = str.count
        
        let maxLength = max(length1, length2)
        if maxLength == 0 {
            return true
        }
        
        let distance = {
            
                let length1 = self.count
                let length2 = str.count
                
                var dp = Array(repeating: Array(repeating: 0, count: length2 + 1), count: length1 + 1)
                
                for i in 0...length1 {
                    for j in 0...length2 {
                        if i == 0 {
                            dp[i][j] = j
                        } else if j == 0 {
                            dp[i][j] = i
                        } else {
                            let cost = self[self.index(self.startIndex, offsetBy: i - 1)] == str[str.index(str.startIndex, offsetBy: j - 1)] ? 0 : 1
                            dp[i][j] = min(dp[i - 1][j - 1] + cost, min(dp[i - 1][j] + 1, dp[i][j - 1] + 1))
                        }
                    }
                }
                
                return dp[length1][length2]
            }()
        
        let similarity = 1.0 - (Double(distance) / Double(maxLength))
        
        return similarity >= percentage
    }

}
