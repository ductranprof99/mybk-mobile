//
//  UIViewController.swift
//  MybkMobile
//
//  Created by DucTran on 05/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

    func additionalBottomView(week: String, day: String) {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: week, attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
             .foregroundColor: UIColor(rgb: 0x11425E)])
        attributedText.append(NSAttributedString(string: " " + day, attributes: [.font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(rgb: 0x11425E)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.067, green: 0.259, blue: 0.369, alpha: 1.0)
       
        bottomView.addSubview(label)

        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 23),

            label.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
        ])
    }

}
