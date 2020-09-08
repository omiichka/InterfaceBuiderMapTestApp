//
//  PasswordController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class PasswordController: UIViewController {
    
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var passwordTextField: TextField!
    
    private let viewModel = AutorizationViewModel()
    private let presenter = AutorizationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupObserver()
    }
}

private extension PasswordController {
    
    func setup() {
        passwordTextField.delegate = presenter
    }
    
    func setupObserver() {
        viewModel.observe(the: passwordTextField) { [unowned self] in
            guard let text = self.passwordTextField.text else {
                NSLog("Can't find input text in PasswordController")
                return
            }
            self.navigationButton.isEnabled = text.count > 6
        }
    }
}

