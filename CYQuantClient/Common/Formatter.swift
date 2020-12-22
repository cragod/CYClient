//
//  Formatter.swift
//  GatroQuant
//
//  Created by HYL on 2020/12/19.
//

import Foundation

class NumberValueFormatter {
    static func formattedFloat(_ value: Float, digits: Int = 2) -> String {
        if value.isZero {
            return "0"
        } else {
            return String(format: "%.2f", value)
        }
    }
    
    static func formattedPercent(_ value: Float) -> String {
        formattedFloat(value * 100) + "%"
    }
}

class DateValueFormatter {
    
    static func analyseISO8601(_ str: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateformatter.date(from: str)
    }
    
    static func formatDate(_ date: Date, formatString: String = "YYYY-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: date)
    }
}
