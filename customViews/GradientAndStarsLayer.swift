//
//  GradientAndStarsLayer.swift
//  nasaAsteroids
//
//  Created by Андрей Коноплев on 25.11.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class GradientAndStarsLayer {
    static func configureStarsLayer(view: UIView, shapeLayer: CAShapeLayer) {
        shapeLayer.lineWidth = 1.2
        shapeLayer.lineCap = "round"
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        
        for _ in 0...250 {
            let coordinate = CGFloat(arc4random_uniform(UInt32(view.frame.width)))
            let secCoordinate = CGFloat(arc4random_uniform(UInt32(view.frame.width)))
            path.move(to: CGPoint(x: coordinate, y: secCoordinate))
            path.addLine(to: CGPoint(x: coordinate, y: secCoordinate))
        }
        shapeLayer.path = path.cgPath
        
        //Animation for stars
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2

        // Animation option
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        shapeLayer.add(animation, forKey: nil)
    }
    
    static func configureGradient(gradientLayer: CAGradientLayer) {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        let startColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1).cgColor
        let middleColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradientLayer.colors = [startColor, middleColor,endColor]
    }
}
