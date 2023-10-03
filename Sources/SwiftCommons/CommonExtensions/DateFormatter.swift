//
//  File.swift
//  
//
//  Created by Nico Petersen on 09.09.23.
//

import Foundation

public extension DateFormatter {
    static var dateGerman: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    static var dateEnglish: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    static var dateShortGerman: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    static var dateShortEnglish: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }()

    static var dateNoDotsGerman: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "ddMMyyyy"
        return formatter
    }()
    
    static var dateNoDotsEnglish: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMddyyyy"
        return formatter
    }()

    static var dateShortNoDotsGerman: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "ddMMyy"
        return formatter
    }()
    
    static var dateShortNoDotsEnglish: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMddyy"
        return formatter
    }()

    static var dateOnlyYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy"
        return formatter
    }()

    static var timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static var timeOnlyWithSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    static var dateAndTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd.MM.yyyy'T'HH:mm"
        return formatter
    }()
}
