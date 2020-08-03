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
    var graphiWdth: CGFloat = 0
  
    init(frame: CGRect, values: [CGFloat], colors:[UIColor], width:CGFloat) {
        super.init(frame: frame)
        self.values = values
        self.colors = colors
        self.graphiWdth = width
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
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        let total = values.reduce(0, +)
        endAngle = (value/total) * (.pi*2)
    
        let path = UIBezierPath(arcCenter: self.myCenter, radius: 60, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = self.colors[currentIndex].cgColor

        sliceLayer.lineWidth = CGFloat(graphiWdth)
        
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
    let xLayer = CAShapeLayer()
  
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
        
        
        //MARK: x좌표선 선 그리기
        let xPath = UIBezierPath()
        xPath.lineWidth = 0.5
        xPath.move(to: CGPoint(x: 0, y: self.frame.height))
        xPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        
        xLayer.path = xPath.cgPath
        
        xLayer.strokeColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        self.layer.addSublayer(xLayer)
        
        //MARK: x 그리드 선 그리기
        var xGrideHeight:CGFloat = 0
        
        for i in 0..<4 {
            let xGridLayer = CAShapeLayer()
            let xGridPath = UIBezierPath()
            
            xGridLayer.lineWidth = 1
            xGridLayer.lineDashPattern = .some([2,2])

            xGrideHeight += (self.frame.height / 5)

            xGridPath.move(to: CGPoint(x: 0, y: xGrideHeight))
            xGridPath.addLine(to: CGPoint(x: self.frame.width, y: xGrideHeight))
            
            xGridLayer.path = xGridPath.cgPath
            
            xGridLayer.strokeColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.layer.addSublayer(xGridLayer)
        }

        //MARK: Line차트 그래프 그리기
        self.graphPath = UIBezierPath()
        self.zeroPath = UIBezierPath()
        
        self.layer.addSublayer(graphLayer)
        
        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x:currentX, y: self.frame.height)
        self.graphPath.move(to: startPosition)
        self.zeroPath.move(to: startPosition)
        
        for i in 0..<values.count {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX, y: self.frame.height - self.values[i])
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
        }
        
        self.graphPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        self.zeroPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        
        graphLayer.fillColor = #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 0.36)
        graphLayer.strokeColor = nil
        
        let oldPath = self.zeroPath.cgPath
        let newPath = self.graphPath.cgPath

        if self.animated {
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = 0.5
            animation.fromValue = oldPath
            animation.toValue = newPath
        
          self.graphLayer.path = newPath
          self.graphLayer.add(animation, forKey: "path")
        }

        self.graphLayer.path = newPath
    
    }
}

class BarGraphView: UIView {
    var values: [CGFloat] = []
    var colors: [UIColor] = []
    var animated: Bool!
  
    var graphPath: UIBezierPath!
    var zeroPath: UIBezierPath!
  
    let graphLayer = CAShapeLayer()
  
    init(frame: CGRect, values: [CGFloat], colors: [UIColor], animated: Bool) {
        super.init(frame: frame)
        self.values = values
        self.colors = colors
        self.animated = animated
      }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        //Bar차트 그래프 그리기
        
        var currentX: CGFloat = 0
        
        for i in 0..<values.count {
            self.graphPath = UIBezierPath()
            self.zeroPath = UIBezierPath()
            
            self.layer.addSublayer(graphLayer)
            graphLayer.lineWidth = 20
            
            let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
            
            let startPosition = CGPoint(x:xOffset, y: self.frame.height)
            self.graphPath.move(to: startPosition)
            self.zeroPath.move(to: startPosition)
            
            currentX += xOffset
            let newPosition = CGPoint(x: currentX, y: self.frame.height - self.values[i])
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
            
            graphLayer.fillColor = #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 0.36)
            graphLayer.strokeColor = self.colors[i].cgColor
            
            let oldPath = self.zeroPath.cgPath
            let newPath = self.graphPath.cgPath

            if self.animated {
                let animation = CABasicAnimation(keyPath: "path")
                animation.duration = 0.5
                animation.fromValue = oldPath
                animation.toValue = newPath
            
              self.graphLayer.path = newPath
              self.graphLayer.add(animation, forKey: "path")
            }

            self.graphLayer.path = newPath
            
        }
    }
}
