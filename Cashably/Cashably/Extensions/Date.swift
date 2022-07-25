//
//  Date.swift
//  Cashably
//
//  Created by apollo on 7/22/22.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    var secondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func dateFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format //Specify your format that you want
        let strDate = dateFormatter.string(from: self)
        
        return strDate
    }
}
