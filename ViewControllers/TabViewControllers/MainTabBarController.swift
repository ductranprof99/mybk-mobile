//
//  MainTabBarController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    @IBInspectable private var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initialIndex
        self.navigationController?.navigationBar.isHidden = true
    }
}
