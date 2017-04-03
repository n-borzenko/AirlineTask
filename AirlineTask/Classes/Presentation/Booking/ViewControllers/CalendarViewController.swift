//
//  CalendarViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    weak var delegate: CalendarControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var startDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancel(_:)))
        view.addGestureRecognizer(tapRecognizer)
        datePicker.date = startDate
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.clearDateDirection()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDate(_ sender: Any) {
        if delegate == nil || delegate!.checkDate(datePicker.date) {
            dismiss(animated: true, completion: nil)
        }
    }
}
