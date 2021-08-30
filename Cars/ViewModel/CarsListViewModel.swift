//
//  CarsViewModel.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import Foundation
import RxSwift
import RxCocoa

class CarsListViewModel {
    
    // MARK: - Properties

    private let sessionProvider = NetworkServiceProvider()
    private let repository = CarsRepository()
    
    var items = BehaviorRelay<[CarsCellViewModel]>(value: [])
    var showAlert: (()->())?
    var updateLoadingStatus: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            showAlert?()
        }
    }
    
    // MARK: - Functionalities

    func initialise() {
        self.isLoading = true
        retrieveCarList(completion: { [weak self] items in
            guard let carItems = items else {
                self?.tryOfflineData(with: NetworkError.noJSONData)
                return
            }
            self?.isLoading = false
            self?.processToCellViewModels(items: carItems)
            self?.repository.saveToDB(carItems)
        }, failure: { [weak self] error in
            self?.isLoading = false
            self?.tryOfflineData(with: error as? NetworkError)
        })
    }
    
    private func processToCellViewModels(items: [Cars]) {
        let cellViewModels = items.map { CarsCellViewModel(id: $0.id, title: $0.title, dateTime: $0.dateTime, description: $0.details, url: $0.url) }
        self.items.accept(cellViewModels)
    }
    
    private func tryOfflineData(with error: NetworkError?) {
        if let cellViewModels = repository.fetch(), cellViewModels.count != 0 {
            items.accept(cellViewModels)
        } else {
            processError(error: error)
        }
    }
    
    private func processError(error: NetworkError?) {
        if let networkError = error { self.alertMessage = networkError.rawValue }
        else { self.alertMessage = NetworkError.unknown.rawValue }
    }
    
    // MARK: - Session Request API
    
    func retrieveCarList(completion: @escaping(_ list: [Cars]?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        sessionProvider.request(type: CarList.self, service: CarsListService()) { [weak self] response in
            switch response {
            case let .success(list):
                completion(list.items)
            case let .failure(error):
                failure(error)
            }
        }
    }
}
