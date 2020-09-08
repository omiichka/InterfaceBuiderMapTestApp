//
//  FCsController.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit
import RxCocoa

final class FCsController: UIViewController {
    
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var surnameTextField: TextField!
    @IBOutlet weak var navigationButton: UIButton!
    
    private let viewModel = AutorizationViewModel()
    private let presenter = AutorizationPresenter()
    
    override func viewDidLoad() {
        setup()
        addHideKeyboard()
        setupObserver()
    }
}

private extension FCsController {
    
    func setup() {
        [nameTextField, surnameTextField].forEach { $0?.delegate = presenter }
        nameTextField.nextField = surnameTextField
    }
    
    func setupObserver() {
        [nameTextField: viewModel.nameTextPublishSubject, surnameTextField: viewModel.surnameTextPublishSubject].forEach {
            $0.key.rx.text
                .map { $0 ?? "" }
                .bind(to: $0.value)
                .disposed(by: viewModel.disposeBag)
        }
        
        viewModel.observe().bind(to: navigationButton.rx.isEnabled).disposed(by: viewModel.disposeBag)
    }
}
