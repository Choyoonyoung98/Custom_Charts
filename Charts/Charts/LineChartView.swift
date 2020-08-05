//
//  LineChartView.swift
//  Charts
//
//  Created by 조윤영 on 2020/08/05.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class LineChartView: UIView {
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
        
        var max:CGFloat = 0
        for i in 0..<values.count {
            max = max < values[i] ? values[i] : max
        }
        
        for i in 0..<5 {
            let xGridLayer = CAShapeLayer()
            let xGridPath = UIBezierPath()
            
            xGridLayer.lineWidth = 1
            xGridLayer.lineDashPattern = .some([2,2])

            xGrideHeight += (self.frame.height / 6)

            xGridPath.move(to: CGPoint(x: 0, y: xGrideHeight))
            xGridPath.addLine(to: CGPoint(x: self.frame.width, y: xGrideHeight))
            
            xGridLayer.path = xGridPath.cgPath
            
            xGridLayer.strokeColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.layer.addSublayer(xGridLayer)
            
            //그리드 선에 맞는 값라벨 표시하기
            var valueDescriptionLabel: UILabel!
            valueDescriptionLabel = UILabel(frame: CGRect(x: -15, y: xGrideHeight, width: 100, height: 100))
            valueDescriptionLabel.text = "\(Int(max) - i * (Int(max) / 5))"
            valueDescriptionLabel.center = CGPoint(x: -15, y: xGrideHeight)
            valueDescriptionLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1)
            valueDescriptionLabel.textAlignment = .center
            
            self.addSubview(valueDescriptionLabel)
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
            let newPosition = CGPoint(x: currentX, y: self.frame.height - (self.frame.height * 5 / 6 * self.values[i]/max))
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
        }
        
        self.graphPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        self.zeroPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        
        graphLayer.fillColor = #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 0.36)
        graphLayer.strokeColor = nil
        graphLayer.lineJoin = .round
        
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
