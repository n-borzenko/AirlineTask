//
//  CityViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class CityViewController: BaseBlueViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityImageView: UIImageView!
    
    var currentCity: String?
    let unwindSegueId = "UnwinedToBooking"
    
    let cellName = String(describing: CityTableViewCell.self)
    
    var isSearching = false
    var data = ["Москва", "Санкт-Петербург", "Калининград", "Краснодар", "Новосибирск"]
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.rowHeight = 65
        
        cityImageView.image = UIImage(named: "GlobalDepartureCity")?.withRenderingMode(.alwaysTemplate)
        cityTextField.delegate = self
        
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if sender == cityTextField {
            let cityPattern = cityTextField.text?.lowercased() ?? ""
            if !cityPattern.isEmpty {
                filteredData = data.filter { $0.lowercased().hasPrefix(cityPattern) }
            } else {
                filteredData = data
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func closeSelection(_ sender: Any) {
        performSegue(withIdentifier: unwindSegueId, sender: self)
        //dismiss(animated: true, completion: nil)
    }
    
}

extension CityViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSearching = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSearching = false
        filteredData.removeAll()
    }
}

extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCity = data[indexPath.row]
    }
}

extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isSearching ? filteredData.count : data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! CityTableViewCell
        cell.cityView.cityLabel.text = isSearching ? filteredData[indexPath.row] : data[indexPath.row]
        return cell
    }
}
