//
//  BacktestModels.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import Foundation

struct BacktestTaskModel {
    var name: String
    var count: Int
}

struct BacktestDetailModel: Codable {
    var taskIdentifier: String
    var paramIdentifier: String
    var equityCurve: Double
    
    var strategyName: String? {
        String(paramIdentifier.split(separator: "|")[0])
    }
    
    var strategyParams: String? {
        String(paramIdentifier.split(separator: "|")[1])
    }
    
    var strategyTimeFrame: String? {
        String(paramIdentifier.split(separator: "|")[2])
    }
    
    var strategyDuration: String? {
        String(paramIdentifier.split(separator: "|")[3])
    }

    private enum CodingKeys: String, CodingKey {
        case taskIdentifier = "task_identifier"
        case paramIdentifier = "param_identifier"
        case equityCurve = "equity_curve"
    }
}
