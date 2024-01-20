//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 20/01/24.
//

import Foundation

extension Date {
    func convertTomMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}
