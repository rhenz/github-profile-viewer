//
//  String+Ext.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/15/22.
//

import Foundation


extension String {
    
    var convertedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    var convertToDisplayFormat: String {
        guard let date = self.convertedDate else {
            return "N/A"
        }
        
        return date.convertToMonthYearFormat
    }
}
