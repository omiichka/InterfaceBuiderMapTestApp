//
//  TextField.swift
//  InterfaceBuiderMapTestApp
//
//  Created by Artem Golovanev on 31.08.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

class TextField: UITextField {

    private let border = CALayer()

    @IBInspectable open var lineColor: UIColor = UIColor.black {
        didSet{
            border.borderColor = lineColor.cgColor
        }
    }

    @IBInspectable open var lineHeight: CGFloat = CGFloat(1.0) {
        didSet{
            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        }
    }
    

    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])


        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
////        self.delegate = self
//    }
}

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        border.borderColor = selectedLineColor.cgColor
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        border.borderColor = lineColor.cgColor
//    }
//}
//import UIKit
//
//final class TextField: UITextField {
//
//    @IBInspectable var borderColor: UIColor? {
//        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
//        set { layer.borderColor = newValue?.cgColor }
//    }
//
//    @IBInspectable underlineColor
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//private extension TextField {
//
//    func setup() {
////        attributedText = NSAttributedString(
//    }
//}
