//
//  UIViewController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard(_ sender: UIGestureRecognizer) {
        view.endEditing(true)
    }
}
