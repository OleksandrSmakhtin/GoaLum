//
//  UIButtonExt.swift
//  Goalster
//
//  Created by Саша Смахтин on 06.07.2022.
//

import UIKit

extension UIButton {
    
    func selectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.1830278635, green: 0.6905899048, blue: 0.7804291844, alpha: 1)
    }
    
    func deselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.6901960784, blue: 0.7803921569, alpha: 0.6358290919)
    }
    
}
