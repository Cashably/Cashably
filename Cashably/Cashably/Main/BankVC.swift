//
//  BankVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import Charts
import NVActivityIndicatorView

class BankVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var viewBalance: RoundView! {
        didSet {
            viewBalance.alpha = 0.15
            viewBalance.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var lbBalance: UILabel!
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    
    @IBOutlet weak var chartView: LineChartView!
    private var chartData: [ChartDataEntry]?
    private var maxValue = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.btnWeek.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnWeek.layer.cornerRadius = 10
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }
        self.btnMonth.layer.cornerRadius = 10
        
        self.drawChart()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("bank staus bar prefered")
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
        self.loadBank()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    @IBAction func actionFilter(_ sender: UIButton) {
    }
    
    @IBAction func actionUpdate(_ sender: Any) {
        let connectVC = self.storyboard?.instantiateViewController(withIdentifier: "ConnectBankVC") as! ConnectBankVC
        connectVC.delegate = self
        self.navigationController?.pushViewController(connectVC, animated: true)
    }
    
    func loadBank(duration: String = "week") {
        self.startAnimating()
        let params = ["duration": duration] as! NSDictionary
        RequestHandler.getRequest(url:Constants.URL.GET_BANK, parameter: params, success: { (successResponse) in
            self.stopAnimating()
            let dictionary = successResponse as! [String: Any]
            if let data = dictionary["data"] as? [String:Any] {
                if let balance = data["balance"] as? Double {
                    self.lbBalance.text = "$\(balance)"
                }
                if let transactions = data["transactions"] as? [[String: Any]] {
                    self.chartData = []
                    for item in transactions {
                        let value = item["value"] as! Double
                        if value > self.maxValue {
                            self.maxValue = value
                        }
                        self.chartData?.append(ChartDataEntry(x: item["timestamp"] as! Double, y: value))
                    }
                    
                    self.drawChart()
                }
            }
        }) { (error) in
            self.stopAnimating()
            
            let alert = Alert.showBasicAlert(message: error.message)
            self.presentVC(alert)
            
            
        }
    }
    
    func drawChart() {
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        xAxis.labelTextColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter()

        let leftAxis = chartView.leftAxis
        leftAxis.axisMaximum = self.maxValue
        leftAxis.axisMinimum = 0
        leftAxis.yOffset = -9
        leftAxis.granularityEnabled = true
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.gridColor = UIColor(red: 0.842, green: 0.824, blue: 0.824, alpha: 1)
        leftAxis.labelTextColor = UIColor(red: 0.631, green: 0.651, blue: 0.643, alpha: 1)
        leftAxis.labelPosition = .outsideChart
        leftAxis.drawAxisLineEnabled = false
        leftAxis.valueFormatter = IntAxisValueFormatter()

        chartView.rightAxis.enabled = false
        
        let marker = BalloonMarker(color: UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1),
                                           font: .systemFont(ofSize: 12),
                                           textColor: .white,
                                           insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker

        chartView.legend.form = .line
        
        setDataCount()
       
    }
    
    func setDataCount() {
//        let now = Date().timeIntervalSinceNow
//        let hourSeconds: TimeInterval = 3600
//
//        let from = now - (Double(count) / 2) * hourSeconds
//        let to = now
//
//        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
//            let y = arc4random_uniform(range)
//            return ChartDataEntry(x: x, y: Double(y))
//        }
        let values = self.chartData

        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        setup(set1)

        let data = LineChartData(dataSet: set1)

        chartView.data = data
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
    
        dataSet.lineDashLengths = nil
        dataSet.highlightLineDashLengths = nil
        dataSet.setColor(UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1))
        dataSet.setCircleColor(.black)
        dataSet.drawValuesEnabled = false
//        dataSet.gradientPositions = [0, 40, 100]
        dataSet.lineWidth = 2
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineDashLengths = nil
        dataSet.formLineWidth = 0
        dataSet.formSize = 15
        
        let gradientColors = [UIColor(red: 0.169, green: 0.706, blue: 0.396, alpha: 0).cgColor,
                              UIColor(red: 0.169, green: 0.706, blue: 0.396, alpha: 0.13).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        dataSet.fillAlpha = 1
        dataSet.fill = .fillWithLinearGradient(gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        dataSet.drawCirclesEnabled = false
        
    }
    
    @IBAction func actionWeek(_ sender: UIButton) {
        self.btnWeek.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }

        self.btnMonth.backgroundColor = .clear
        self.btnMonth.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
            return container
        }
        
        self.loadBank()
    }
    
    @IBAction func actionMonth(_ sender: UIButton) {
        self.btnMonth.backgroundColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        self.btnMonth.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = .white
            return container
        }

        self.btnWeek.backgroundColor = .clear
        self.btnWeek.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var container = incoming
            container.foregroundColor = UIColor(red: 0.388, green: 0.384, blue: 0.384, alpha: 1)
            return container
        }
        
        self.loadBank(duration: "month")
    }
    
    
}

extension BankVC: ConnectBankDelegate {
    func updated() {
//        self.loadBank()
    }
    
    func connected() {
        self.loadBank()
    }
}
