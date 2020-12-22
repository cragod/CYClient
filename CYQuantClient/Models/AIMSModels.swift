//
//  AIMSModels.swift
//  GatroQuant
//
//  Created by HYL on 2020/12/18.
//

import Foundation

struct AIMSPosition: Codable, Hashable {
    let id: Int = Int(arc4random())
    let exchange: String
    let coinPair: String
    let updateAt: String
    let cost: Float
    let hold: Float
    let averageCost: Float
    let currentPrice: Float
    let profit: Float
    
    private enum CodingKeys : String, CodingKey {
        case id
        case exchange = "exchange_name"
        case coinPair = "coin_pair"
        case updateAt = "update_date"
        case cost
        case hold
        case averageCost = "average_costing"
        case currentPrice = "current_price"
        case profit
    }
}

struct AIMSSelling: Codable, Hashable {
    let id: Int = Int(arc4random())
    let exchange: String
    let coinPair: String
    let date: String
    let cost: Float
    let hold: Float
    let closePrice: Float
    let profit: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case exchange = "exchange_name"
        case coinPair = "coin_pair"
        case date
        case cost
        case hold
        case closePrice = "close_price"
        case profit = "profit_amount"
    }
    
    var profitPercent: Float {
        profit / cost
    }
}
