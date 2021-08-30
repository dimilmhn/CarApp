//
//  Constants.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://www.apphusetreach.no/application/119267"
    }
    
    struct DateFormatter {
        static let apiFormat = "dd.MM.yyyy HH:mm"
        static let requiredFormat = "dd MMMM yyyy, HH:mm"
        static let requiredCurrentYearFormat = "dd MMMM, HH:mm"
    }
    
    struct Entity {
        static let carItem = "CarItem"
        struct Keypath {
            static let id = "id"
            static let title = "title"
            static let details = "details"
            static let dateTime = "dateTime"
            static let url = "url"
        }
    }
}
