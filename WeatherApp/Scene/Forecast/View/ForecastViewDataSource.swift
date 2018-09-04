//
//  ForecastViewDataSource.swift
//  WeatherApp
//
//  Created by Milos Stevanovic on 8/29/18.
//  Copyright © 2018 Milos Stevanovic. All rights reserved.
//
import Foundation
import UIKit

class ForecastViewDataSource : NSObject , UITableViewDataSource {
    
    private var viewModel       : ForecastViewModelProtocol!
    private var table           : UITableView!
    var didSelectRowAtIndex     : ((Int)->Void)?
    
    init(tableView : UITableView , viewModel : ForecastViewModel){
        super.init()
        self.viewModel = viewModel
        self.table     = tableView
        viewModel.didReceiveForecastModelCell = { 
             tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = viewModel.data(section: indexPath.section, forRowAt: indexPath.row)
        let cell  = tableView.dequeueReusableCell(CellForecast.self, at: indexPath)
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(inSection: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 16, y: 0 , width: view.frame.width, height: view.frame.height))
        label.textAlignment = .left
        label.text = viewModel.sectionTitle(inSection: section).uppercased()
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
extension ForecastViewDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             didSelectRowAtIndex?(indexPath.row)
    }
}
