//
//  ScheduleViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var semeterPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pickerTapHandler(_ sender: Any) {
        print("a")
    }
}
