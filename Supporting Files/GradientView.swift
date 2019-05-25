//
//  GradientView.swift
//  Music App
//
//  Created by AnDy on 5/2/19.
//  Copyright © 2019 AnDy. All rights reserved.
//

import UIKit
@IBDesignable

class GradientView: UIView {

    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.6705882353, green: 0.2666666667, blue: 0.02745098039, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.9647058824, green: 0.3803921569, blue: 0.05098039216, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
