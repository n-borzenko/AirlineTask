//
//  WeatherChartViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var tableView: UITableView!
    let cellName = String(describing: WeatherTableViewCell.self)
    
    var data = [
        ["09.00", "12.00", "15.00", "18.00", "21.00", "00.00"],
        ["03.00", "06.00", "09.00", "12.00", "15.00", "18.00", "21.00", "00.00"],
        ["03.00", "06.00", "09.00", "12.00"]
    ]
    var dates = ["20 апр, чт", "21 апр, пт", "22 апр, сб"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clear
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.sectionFooterHeight = CGFloat.leastNonzeroMagnitude
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WeatherHeaderView()
        headerView.dateLabel.text = dates[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == data[indexPath.section].count - 1 && indexPath.section != data.count - 1 {
            return 96
        } else {
            return 126
        }
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! WeatherTableViewCell
        cell.timeLabel.isHidden = indexPath.row == data[indexPath.section].count - 1 && indexPath.section != data.count - 1
        cell.timeLabel.text = data[indexPath.section][indexPath.row]
        return cell
    }
}
