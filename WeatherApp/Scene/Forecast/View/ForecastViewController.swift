
//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/25/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import UIKit

class ForecastViewController: BaseViewController  {

    @IBOutlet private weak var tableView: UITableView!
    private var viewModel  = ForecastViewModel()
    private var dataSource : ForecastViewDataSource!
    @IBOutlet private weak var navigationItme: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallbacks()
        dataSource = ForecastViewDataSource(tableView: tableView, viewModel: viewModel)
        tableView.dataSource = dataSource
        tableView.delegate   = dataSource
        tableView.accessibilityLabel = "testTableViewForecast"
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupCallbacks()
    }
    private func setupCallbacks(){
        guard let coordinate = CoreLocationManager.coordinate else {
            return
        }
        viewModel.didReceiveForecastData = { [unowned self] (forecastModel,error) in
            guard  error == nil else {
                Logger.error(error!.localizedDescription)
                self.showAlert(title: "Error".localizedLowercase, message: error!.localizedDescription)
                return
            }
            self.navigationItem.title = forecastModel?.city.name
        }
        viewModel.getForecastData(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
extension ForecastViewController : UIViewStyling {
    func setupViews() {
        tableView?.tableFooterView = UIView()
    }
}
