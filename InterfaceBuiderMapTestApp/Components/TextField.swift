//
//  TextField.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 31.08.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TextField: UITextField {

    var nextField: TextField?
    
    private let border = CALayer()

    @IBInspectable public var lineColor: UIColor = .black {
        didSet{
            border.borderColor = lineColor.cgColor
        }
    }

    @IBInspectable public var lineHeight: CGFloat = 1 {
        didSet{
            border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: frame.size.height)
        }
    }
    
    @IBInspectable var hasEyeButton: Bool = false {
        didSet {
            guard hasEyeButton else { return }
            setupEyeButton()
        }
    }
    

    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
        border.borderColor = lineColor.cgColor
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: frame.size.height)
        border.borderWidth = lineHeight
        layer.addSublayer(border)
        layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: frame.size.height - lineHeight, width:  frame.size.width, height: frame.size.height)
    }
}

private extension TextField {
    
    func setupEyeButton() {
        let passwordEyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 17))
        passwordEyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 10, right: 0)
        passwordEyeButton.addTarget(self, action: #selector(didHandleEyeButton(_:)), for: .touchUpInside)
        passwordEyeButton.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        passwordEyeButton.alpha = 0.5
        rightView = passwordEyeButton
        rightViewMode = .always
    }
    
    
    @objc func didHandleEyeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.alpha = sender.isSelected ? 1 : 0.5
        isSecureTextEntry = !sender.isSelected
    }
}
