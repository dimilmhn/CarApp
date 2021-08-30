//
//  CarsListService.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation

struct CarsListService: NetworkServiceProtocol {
    
    var baseURL: URL? {
        return URL(string: Constants.API.baseURL)
    }
    
    var path: String {
        return "/article/get_articles_list"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .json
    }
}
