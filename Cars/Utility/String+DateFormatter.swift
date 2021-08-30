//
//  DateFormatter.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/20.
//

import Foundation

extension String {
    func format() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormatter.apiFormat
        guard let date = dateFormatter.date(from: self) else { return nil }
        let newDateFormatter = DateFormatter()
        if date.isCurrentYear() { newDateFormatter.dateFormat = Constants.DateFormatter.requiredCurrentYearFormat }
        else { newDateFormatter.dateFormat = Constants.DateFormatter.requiredFormat }
        let convertedDateString = newDateFormatter.string(from: date)
        return convertedDateString
    }
}


