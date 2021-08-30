//
//  UIView+Extension.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import UIKit

extension UIView {
    func addGradient(for yAxis: CGFloat, height: CGFloat) {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: yAxis, width: self.bounds.size.width, height: height)
        let colorTop = UIColor(white: 0.0, alpha: 0.0).cgColor
        let colorBottom = UIColor(white: 0.0, alpha: 1.0).cgColor
        let colorMiddle = UIColor(white: 0.0, alpha: 0.82).cgColor
        
        layer.colors = [colorTop, colorMiddle, colorBottom]
        self.layer.addSublayer(layer)
    }
}
