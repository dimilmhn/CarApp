//
//  CarsListViewController.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class CarsListViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var carsListView: UITableView!
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private var viewModel = CarsListViewModel()
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.white
        return activityIndicator
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserInterface()
        bindCarsToList()
        initialiseViewModel()
    }
    
    // MARK: - Configurations

    func initialiseViewModel() {
        viewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.carsListView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.carsListView.alpha = 1.0
                    })
                }
            }
        }
        viewModel.initialise()
    }

    
    private func configureUserInterface() {
        self.title = "Cars"
        configureCarList()
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    private func configureCarList() {
        carsListView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        carsListView.rowHeight = UITableView.automaticDimension
        carsListView.estimatedRowHeight = 357
        let nib = UINib(nibName: CarsTableViewCell.identifier, bundle: nil)
        carsListView.register(nib, forCellReuseIdentifier:  CarsTableViewCell.identifier)
    }
    
    // MARK: - Rx Setup
    
    private func bindCarsToList() {
        viewModel
            .items
            .asObservable()
            .bind(to: carsListView.rx.items(cellIdentifier: CarsTableViewCell.identifier, cellType: CarsTableViewCell.self)) {
                row, item, cell in
                cell.populate(viewModel: item)
            }.disposed(by: disposeBag)
    }
}

extension CarsListViewController: UITableViewDelegate {}
