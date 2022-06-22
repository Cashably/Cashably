//
//  IntAxisValueFormatter.swift
//  Cashably
//
//  Created by apollo on 6/21/22.
//

import Foundation
import Charts

public class IntAxisValueFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "$ \(Int(value))"
    }
}
