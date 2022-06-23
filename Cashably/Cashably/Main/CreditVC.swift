//
//  CreditVC.swift
//  Cashably
//
//  Created by apollo on 6/20/22.
//

import Foundation
import UIKit
import MKRingProgressView
import Charts
import MKMagneticProgress

class CreditVC: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lbPercent: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMinPercent: UILabel!
    @IBOutlet weak var lbMaxPercent: UILabel!
    @IBOutlet weak var scoreChatView: MKMagneticProgress!
    
    @IBOutlet weak var weekIcon: UIImageView!
    @IBOutlet weak var lbWeekScore: UILabel!
    
    @IBOutlet weak var monthIcon: UIImageView!
    @IBOutlet weak var lbMonthScore: UILabel!
    
    @IBOutlet weak var breakdownChatView: PieChartView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var parties: [Double] = [235.0, 123.0, 203.0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MerchantTableViewCell", bundle: nil), forCellReuseIdentifier: "mercantCell")
        tableView.backgroundColor = .clear
//        tableView.rowHeight = 80
        
//        self.drawChart()
        self.drawHalfProgressBar()
        self.drawPieChart()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("crdit staus bar prefered")
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
   }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       self.navigationController?.isNavigationBarHidden = false
   }
    
    func drawHalfProgressBar() {
//        lbPercent.isHidden = true
//        lbTitle.isHidden = true
        
        
//        scoreChatView.progressShapeColor = UIColor(red: 0.886, green: 0.314, blue: 0.31, alpha: 1)
//        scoreChatView.lineWidth = 0
        scoreChatView.progressShapeColors = [
            UIColor(red: 0.886, green: 0.314, blue: 0.31, alpha: 1),
            UIColor(red: 1, green: 0.675, blue: 0.375, alpha: 1),
            UIColor(red: 0.759, green: 1, blue: 0.246, alpha: 1),
            UIColor(red: 0.291, green: 0.896, blue: 0.078, alpha: 1)
          ]
        scoreChatView.orientation = .bottom
        scoreChatView.percentLabelFormat = "%d"
//        scoreChatView.title = "Greate score"
//        scoreChatView.titleLabel = lbTitle
        scoreChatView.setProgress(progress: 0.9)
        scoreChatView.percent = ""
        
    }
    
    func drawChart() {
        let ringProgressView = RingProgressView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        ringProgressView.startColor = UIColor(red: 0.886, green: 0.314, blue: 0.31, alpha: 1)
        ringProgressView.endColor = UIColor(red: 0.291, green: 0.896, blue: 0.078, alpha: 1)
        ringProgressView.ringWidth = 15
        ringProgressView.progress = 0.9
        
        ringProgressView.translatesAutoresizingMaskIntoConstraints = false
        self.scoreChatView.addSubview(ringProgressView)
        ringProgressView.centerXAnchor.constraint(equalTo: self.scoreChatView.centerXAnchor).isActive = true
        ringProgressView.centerYAnchor.constraint(equalTo: self.scoreChatView.centerYAnchor).isActive = true
        ringProgressView.widthAnchor.constraint(equalTo: self.scoreChatView.widthAnchor).isActive = true
        ringProgressView.heightAnchor.constraint(equalTo: self.scoreChatView.heightAnchor).isActive = true
        
    }
    
    func drawPieChart() {
        breakdownChatView.delegate = self
        breakdownChatView.holeColor = .white
        breakdownChatView.legend.enabled = false
        breakdownChatView.drawEntryLabelsEnabled = false
//        breakdownChatView.
        self.setDataCount(3, range: 100)
    }
    
    
    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: parties[i % parties.count],
                                     label: "")
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.sliceSpace = 0
        set.selectionShift = 0
        set.colors = [
            NSUIColor(red: 0.996, green: 0.808, blue: 0.631, alpha: 1.0),
            NSUIColor(red: 0.38, green: 0.024, blue: 0.294, alpha: 1.0),
            NSUIColor(red: 0.976, green: 0.545, blue: 0.522, alpha: 1.0)
        ]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .currency
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.currencySymbol = " $"
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 11)!)
        data.setValueTextColor(.white)
        
        breakdownChatView.data = data
        
        breakdownChatView.setNeedsDisplay()
    }
}

extension CreditVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension CreditVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MerchantTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "mercantCell") as! MerchantTableViewCell
//        cell.progress.progress = 0.9
        return cell
    }
}
