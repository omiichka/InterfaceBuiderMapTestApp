//
//  AutorizationPresenter.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 08.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class AutorizationPresenter: NSObject {
    
}

extension AutorizationPresenter: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let field = textField as? TextField, let nextField = field.nextField else { return textField.resignFirstResponder() }
        return nextField.becomeFirstResponder()
    }
}
