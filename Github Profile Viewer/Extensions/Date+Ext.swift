//
//  Date+Ext.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 7/15/22.
//

import Foundation

extension Date {
    var convertToMonthYearFormat: String {
        formatted(.dateTime.month().year())
    }
}
