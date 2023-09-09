//
//  AppInformation.swift
//
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public enum AppInformation {
    public static func version() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        return "\(version).\(build)"
    }

    public static func name() -> String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }

    public static func buildDate() -> String? {
        let bundle = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "Info.plist"
        guard let path = Bundle.main.path(forResource: bundle, ofType: nil),
              let attributes = try? FileManager.default.attributesOfItem(atPath: path),
              let date = attributes[FileAttributeKey.creationDate] as? Date
        else {
            return nil
        }
        return date.format("dd.MM.YYYY HH:mm:ss")
    }
}
