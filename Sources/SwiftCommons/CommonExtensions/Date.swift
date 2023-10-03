//
//  File.swift
//
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension Date {
    func utc(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        self.format(format, timeZone: TimeZone(identifier: "UTC")!)
    }

    func format(_ format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func dateGerman() -> String {
        DateFormatter.dateGerman.string(from: self)
    }
    func dateEnglish() -> String {
        DateFormatter.dateEnglish.string(from: self)
    }
    func dateShortGerman() -> String {
        DateFormatter.dateShortGerman.string(from: self)
    }
    func dateShortEnglish() -> String {
        DateFormatter.dateShortEnglish.string(from: self)
    }
    func dateNoDotsGerman() -> String {
        DateFormatter.dateNoDotsGerman.string(from: self)
    }
    func dateNoDotsEnglish() -> String {
        DateFormatter.dateNoDotsEnglish.string(from: self)
    }
    func dateShortNoDotsGerman() -> String {
        DateFormatter.dateShortNoDotsGerman.string(from: self)
    }
    func dateShortNoDotsEnglish() -> String {
        DateFormatter.dateShortNoDotsEnglish.string(from: self)
    }
    func dateOnlyYear() -> String {
        DateFormatter.dateOnlyYear.string(from: self)
    }
    func timeOnly() -> String {
        DateFormatter.timeOnly.string(from: self)
    }
    func timeOnlyWithSeconds() -> String {
        DateFormatter.timeOnlyWithSeconds.string(from: self)
    }
    func dateAndTime() -> String {
        DateFormatter.dateAndTime.string(from: self)
    }
}
