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
    @IBOutlet weak var airportsLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    
    var presentationModel = CitiesPresentationModel()
    let unwindSegueId = "UnwinedToBooking"
    let cellName = String(describing: CityTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.rowHeight = 65
        
        let image = UIImage(named: presentationModel.cityType.imageName)!
        cityImageView.image = image.withRenderingMode(.alwaysTemplate)
        cityTextField.placeholder = presentationModel.cityType.placeholder
        
        if let city = presentationModel.selectedCity {
            airportsLabel.text = city.airports
            cityTextField.text = city.name
        }

        presentationModel.delegate = self
        presentationModel.updateData()
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if sender == cityTextField {
            let cityPattern = cityTextField.text?.lowercased() ?? ""
            presentationModel.filterData(cityPattern)
        }
    }
    
    @IBAction func closeSelection(_ sender: Any) {
        clearState()
    }
    
    func clearState() {
        cityTextField.endEditing(true)
        performSegue(withIdentifier: unwindSegueId, sender: self)
    }
}

extension CityViewController: CitiesPresentationDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentationModel.selectedCity = presentationModel.filteredData[indexPath.row]
        airportsLabel.text = presentationModel.selectedCity!.airports
        cityTextField.text = presentationModel.selectedCity!.name
        clearState()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cityTextField.endEditing(true)
    }
}

extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? presentationModel.filteredData.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! CityTableViewCell
        cell.fill(with: presentationModel.filteredData[indexPath.row])
        return cell
    }
}
