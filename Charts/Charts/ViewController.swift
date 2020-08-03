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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLineChart()
        addPieChart()
    }
    
    func addLineChart() {
        let lineChartFrame = CGRect(x: 0, y: 0, width: self.view1.frame.width, height: self.view1.frame.height)
        let LineChartView = LineGraphView(frame: lineChartFrame, values: [20, 10, 30, 20, 50, 100, 10, 10], animated: true)
        LineChartView.center = CGPoint(x: self.view1.frame.size.width / 2, y: self.view1.frame.size.height / 2)
        self.view1.addSubview(LineChartView)
    }
    
    func addPieChart() {
        let pieChartFrame = CGRect(x: 0, y: 0, width: self.view2.frame.width, height: self.view2.frame.height)
        let colors = [UIColor.black, UIColor.yellow, UIColor.red, UIColor.systemPink]
        let pieChartView = PieChartView(frame: pieChartFrame, values: [20,60,10,80], colors: colors)
        pieChartView.center = CGPoint(x:self.view2.frame.size.width / 2, y: self.view2.frame.size.height / 2)
        self.view2.addSubview(pieChartView)
    }

}

