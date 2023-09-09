//
//  File.swift
//  
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public class Coder {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    public init() {}
    
    public func encode<T>(_ value: T) -> Data where T: Encodable {
        try! encoder.encode(value)
    }
    
    public func decode<T>(_ data: Data) -> T where T: Decodable {
        try! decoder.decode(T.self, from: data)
    }
    
    public func encodeToJson<T>(value: T) -> String where T: Encodable {
        let data = encode(value)
        let result = String(data: data, encoding: .utf8)
        return result!
    }
    
    public func decodeFromJson<T>(jsonString: String) -> T where T: Decodable {
        let jsonData = jsonString.data(using: .utf8)!
        return decode(jsonData)
    }
    
    public func encodeBase64<T>(value: T) -> String where T: Codable {
        let jsonString = encodeToJson(value: value)
        return encodeBase64(string: jsonString)
    }
    
    public func decodeBase64<T>(base64String: String) -> T where T: Codable {
        let jsonString = decodeBase64(base64String: base64String) ?? ""
        return decodeFromJson(jsonString: jsonString)
    }
    
    
    public func encodeBase64(string value: String) -> String {
        return encodeBase64(data: Data(value.utf8))
    }
    
    public func encodeBase64(data value: Data) -> String {
        return value.base64EncodedString()
    }
    
    
    public func decodeBase64(base64String: String) -> String? {
        guard let data = Data(base64Encoded: base64String) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
