//
//  ViewController.swift
//  Charts
//
//  Created by 조윤영 on 2020/08/03.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addLineChart()
        addPieChart()
        addBarChart()
    }
    
    func addLineChart() {
        let lineChartFrame = CGRect(x: 0, y: 0, width: self.view1.frame.width, height: self.view1.frame.height)
        
        let lineChartView = LineChartView(frame: lineChartFrame, values: [15, 10, 12, 5, 10, 7, 15], animated: true)
        lineChartView.center = CGPoint(x: self.view1.frame.size.width / 2, y: self.view1.frame.size.height / 2)
        self.view1.addSubview(lineChartView)
        
    }
    
    func addPieChart() {
        let pieChartFrame = CGRect(x: 0, y: 0, width: self.view2.frame.width, height: self.view2.frame.height)
        let pieChartColors = [ #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.7960784314, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1) ]
        let pieChartView = PieChartView(frame: pieChartFrame, values: [53,17,15,15], colors: pieChartColors, width: 50)
        pieChartView.center = CGPoint(x: self.view2.frame.size.width / 2, y: self.view2.frame.size.height / 2)
        self.view2.addSubview(pieChartView)
        
        addPieChartLabel()
    }
    
    func addPieChartLabel() {
        //설명 Label 추가
        var pieChartDesciptionLabel: UILabel!
        pieChartDesciptionLabel = UILabel(frame: CGRect(x: self.view2.frame.width/2, y: self.view2.frame.height/2, width: 50, height: 50))
        pieChartDesciptionLabel.text = "언어 비율 (%)"
        pieChartDesciptionLabel.center = CGPoint(x: self.view2.frame.size.width / 2, y: self.view2.frame.size.height / 2)
        pieChartDesciptionLabel.numberOfLines = 2
        pieChartDesciptionLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
        view2.addSubview(pieChartDesciptionLabel)
    }
    
    func addBarChart() {
        let barChartFrame = CGRect(x: 0, y: 0, width: self.view3.frame.width, height: self.view3.frame.height)
        let barChartColors = [ #colorLiteral(red: 0.8, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1)]
        let barTitles:[String] = ["iOS", "카멜레온"]
        let barValues:[CGFloat] = [4, 1]
        let barChartView = BarChartView(frame: barChartFrame, values: barValues, titles: barTitles, colors: barChartColors, animated: true)
        
        barChartView.center = CGPoint(x: self.view3.frame.size.width / 2, y: self.view3.frame.size.height / 2)
        self.view3.addSubview(barChartView)
    }
}

