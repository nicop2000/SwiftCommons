//
//  XcodeConfigurationValue.swift
//
//
//  Created by Nico Petersen on 13.11.23.
//

import Foundation

public enum XcodeConfigurationValue {
    public static func value<T: LosslessStringConvertible>(from bundle: Bundle, for key: String, defaultValue: T) -> T {
        bundleValue(from: bundle, for: key) ?? defaultValue
    }

    private static func bundleValue<T: LosslessStringConvertible>(from bundle: Bundle, for key: String) -> T? {
        guard let valueFromPlist = bundle.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }
        return T(valueFromPlist)
    }
}
