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
        
        let LineChartView = LineGraphView(frame: lineChartFrame, values: [20, 10, 30, 20, 50, 100, 10, 10, 0], animated: true)
        LineChartView.center = CGPoint(x: self.view1.frame.size.width / 2, y: self.view1.frame.size.height / 2)
        self.view1.addSubview(LineChartView)
        
    }
    
    func addPieChart() {
        let pieChartFrame = CGRect(x: 0, y: 0, width: self.view2.frame.width, height: self.view2.frame.height)
        let pieChartColors = [ #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.7960784314, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1) ]
        let pieChartView = PieChartView(frame: pieChartFrame, values: [53,17,15,15], colors: pieChartColors, width: 50)
        pieChartView.center = CGPoint(x:self.view2.frame.size.width / 2, y: self.view2.frame.size.height / 2)
        self.view2.addSubview(pieChartView)
    
    }
    
    func addBarChart() {
        let barChartFrame = CGRect(x: 0, y: 0, width: self.view3.frame.width, height: self.view3.frame.height)
        let barChartColors = [ #colorLiteral(red: 0.8, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1)]
        let barChartView = BarGraphView(frame: barChartFrame, values: [43, 66, 20], colors: barChartColors, animated: true)
        
        barChartView.center = CGPoint(x: self.view3.frame.size.width / 2, y: self.view3.frame.size.height / 2)
        self.view3.addSubview(barChartView)
    }

}

