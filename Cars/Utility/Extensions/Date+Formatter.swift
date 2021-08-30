//
//  Date+Formatter.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/20.
//

import Foundation

extension Date {
    func isCurrentYear() -> Bool {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let actualYear = calendar.component(.year, from: self)
        return currentYear == actualYear
    }
}
