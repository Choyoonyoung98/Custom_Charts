//
//  Extension+View.swift
//  Charts
//
//  Created by 조윤영 on 2020/08/03.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class PieChartView: UIView, CAAnimationDelegate {
    let circleLayer: CAShapeLayer = CAShapeLayer()
    
    var startAngle: CGFloat = (-(.pi) / 2)
    var endAngle: CGFloat = 0.0
    var values: [CGFloat] = []
    var colors: [UIColor] = []
    var currentIndex: Int = 0
    var myCenter = CGPoint.zero
  
    init(frame: CGRect, values: [CGFloat], colors:[UIColor]) {
        super.init(frame: frame)
        self.values = values
        self.colors = colors
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect:CGRect) {
        self.myCenter = CGPoint(x: rect.midX, y: rect.midY)
        self.add(value: values[currentIndex])
    }
  
    func add(value: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        let total = values.reduce(0, +)
        endAngle = (value/total) * (.pi*2)
    
        let path = UIBezierPath(arcCenter: self.myCenter, radius: 60, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = self.colors.randomElement()?.cgColor
        sliceLayer.lineWidth = 80
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
    
        self.layer.addSublayer(sliceLayer)
    }
  
    func animationDidStop(_ anim: CAAnimation, finished flag:Bool) {
        let isFinished = flag
        if isFinished && currentIndex < self.values.count - 1 {
            self.currentIndex += 1
            self.startAngle += endAngle
            self.add(value: self.values[currentIndex])
        }
    }
}

class LineGraphView: UIView {
    var values: [CGFloat] = []
  
    var graphPath: UIBezierPath!
    var zeroPath: UIBezierPath!
    var animated: Bool!
  
    let graphLayer = CAShapeLayer()
  
    init(frame: CGRect, values: [CGFloat], animated: Bool) {
        super.init(frame: frame)
        self.values = values
        self.animated = animated
      }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.graphPath = UIBezierPath()
        self.zeroPath = UIBezierPath()
        
        self.layer.addSublayer(graphLayer)
        
        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x: currentX, y: self.frame.height)
        self.graphPath.move(to: startPosition)
        self.zeroPath.move(to: startPosition)
        
        for i in 0..<values.count {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX,
                                    y: self.frame.height - self.values[i])
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
        }
        
        graphLayer.fillColor = nil
        graphLayer.strokeColor = UIColor.black.cgColor
        graphLayer.lineWidth = 2
        
        let oldPath = self.zeroPath.cgPath
        let newPath = self.graphPath.cgPath
        
        if self.animated {
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = 1.0
            animation.fromValue = oldPath
            animation.toValue = newPath
        
          self.graphLayer.path = newPath
          self.graphLayer.add(animation, forKey: "path")
        }
      
        self.graphLayer.path = newPath
    }
}
