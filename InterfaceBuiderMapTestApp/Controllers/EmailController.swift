//
//  EmailController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class EmailController: UIViewController {
    
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var emailTextField: TextField!
    
    private let viewModel = AutorizationViewModel()
    private let presenter = AutorizationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupObserver()
    }
}

private extension EmailController {
    
    func setup() {
        emailTextField.delegate = presenter
    }
    
    func setupObserver() {
        viewModel.observe(the: emailTextField) { [unowned self] in
            guard let text = self.emailTextField.text else {
                NSLog("Can't find input text in EmailController")
                return
            }
            self.navigationButton.isEnabled = text.isValidEmail()
        }
    }
}
