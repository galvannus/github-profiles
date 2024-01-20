//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 20/01/24.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ex_US_POSIX")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }

        return date.convertTomMonthYearFormat()
    }
}
