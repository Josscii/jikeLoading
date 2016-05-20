//
//  JKLoaingView.swift
//  jikeLoading
//
//  Created by Josscii on 16/5/19.
//  Copyright © 2016年 Josscii. All rights reserved.
//

import UIKit

class JKLoaingView: UIView {
    
    var jLayer: CAShapeLayer!
    var jLayerBackground: CAShapeLayer!
    var jLayerMask: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayer()
    }
    
    func configureLayer() {
        jLayer = CAShapeLayer()
        jLayer.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        jLayer.path = jPath(frame: jLayer.frame).CGPath
        jLayer.fillColor = UIColor(red: 0.231, green: 0.329, blue: 0.416, alpha: 1).CGColor
        
        jLayerBackground = CAShapeLayer()
        jLayerBackground.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        jLayerBackground.path = jPath(frame: jLayerBackground.frame).CGPath
        jLayerBackground.fillColor = UIColor(red: 0.871, green: 0.886, blue: 0.898, alpha: 1).CGColor
        
        jLayerBackground.addSublayer(jLayer)
        
        jLayerMask = CALayer()
        jLayerMask.backgroundColor = UIColor.whiteColor().CGColor
        jLayerMask.frame = CGRect(x: 0, y: 45, width: 45, height: 45)
        
        jLayer.mask = jLayerMask
        
        layer.addSublayer(jLayerBackground)
    }
    
    var isLoading = false
    
    func startLoading() {
        
        isLoading = true
        self.jLayerBackground.fillColor = UIColor.whiteColor().CGColor
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.2)
        CATransaction.setCompletionBlock {
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
    
            self.jLayerMask.frame.origin.y = 0
            self.jLayer.path = self.circlePath(frame: CGRect(x: 10, y: 10, width: 25, height: 25)).CGPath
            self.jLayer.lineWidth = 6
            self.jLayer.fillColor = UIColor.whiteColor().CGColor
            self.jLayer.strokeColor = UIColor(red: 0.231, green: 0.329, blue: 0.416, alpha: 1).CGColor
            self.jLayer.strokeStart = 0
            self.jLayer.strokeEnd = 0.25
            
            CATransaction.commit()
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.5)
            self.jLayer.strokeEnd = 0.99
            
            CATransaction.setCompletionBlock({ 
                let ani1 = CABasicAnimation(keyPath: "transform.rotation.z")
                ani1.toValue = M_PI * 2
                ani1.duration = 0.5
                ani1.repeatCount = 4
                ani1.cumulative = true
                ani1.delegate = self
                self.jLayer.addAnimation(ani1, forKey: nil)
            })
            
            CATransaction.commit()
        }
        jLayerMask.frame.origin.y = 24
        CATransaction.commit()
        

    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        UIView.animateWithDuration(0.5, animations: { 
            let tableView = self.superview as! UITableView
            self.jLayer.lineWidth = 1
            tableView.contentInset.top = 64
        }) { finished in
            self.jLayerMask.frame.origin.y = 0
            self.jLayer.path = self.jPath(frame: self.jLayer.frame).CGPath
            self.jLayer.lineWidth = 1
            self.jLayer.fillColor = UIColor(red: 0.231, green: 0.329, blue: 0.416, alpha: 1).CGColor
            self.jLayerBackground.fillColor = UIColor(red: 0.871, green: 0.886, blue: 0.898, alpha: 1).CGColor
            self.isLoading = !flag
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 0.871 0.886 0.898
    // 0.231 0.329 0.416
    
    func jPath(frame frame: CGRect) -> UIBezierPath {
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 30.66, frame.minY + 7))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 38, frame.minY + 7))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 38, frame.minY + 26.47), controlPoint1: CGPointMake(frame.minX + 38, frame.minY + 7), controlPoint2: CGPointMake(frame.minX + 38, frame.minY + 16.57))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 24.28, frame.minY + 37), controlPoint1: CGPointMake(frame.minX + 38, frame.minY + 36.36), controlPoint2: CGPointMake(frame.minX + 24.28, frame.minY + 37))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 23, frame.minY + 30.94))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 30.66, frame.minY + 25.51), controlPoint1: CGPointMake(frame.minX + 23, frame.minY + 30.94), controlPoint2: CGPointMake(frame.minX + 30.66, frame.minY + 30.3))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 30.66, frame.minY + 7), controlPoint1: CGPointMake(frame.minX + 30.66, frame.minY + 20.72), controlPoint2: CGPointMake(frame.minX + 30.66, frame.minY + 7))
        bezierPath.closePath()
        
        bezierPath.fill()
        
        return bezierPath
    }
    
    func circlePath(frame frame: CGRect) -> UIBezierPath {
        return UIBezierPath(ovalInRect: frame)
    }
    
    var fillPercent: CGFloat = 0 {
        willSet {
            jLayerMask.frame.origin.y = 45 - 8 - 30 * newValue
        }
    }
}
