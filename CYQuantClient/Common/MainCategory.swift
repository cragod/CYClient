//
//  MainCategory.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/17.
//

import Foundation
import SwiftUI

enum MainCategory: String, CaseIterable, Identifiable {
    
    case aims
    case aip
    case backtest
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .aims:
            return "AIMS 策略"
        case .aip:
            return "定投记录"
        case .backtest:
            return "回测"
        }
    }
    
    var icon: String {
        switch self {
        case .aims:
            return "bus"
        case .aip:
            return "signature"
        case .backtest:
            return "clock.arrow.circlepath"
        }
    }
}

class MainCategoryManager {
    static let shared = MainCategoryManager()
    private var mainCategoryViews = [String: AnyView]()
    
    func destination(with category: MainCategory) -> AnyView {
        if let view = mainCategoryViews[category.id] {
            return view
        }
        switch category {
        case .aims:
            let view = AnyView(AIMSContainerView())
            mainCategoryViews[category.id] = view
            return view
        case .aip:
            let view = AnyView(Text("hahaha").setupRefresh {
                
            })
            mainCategoryViews[category.id] = view
            return view
        case .backtest:
            let view = AnyView(BacktestContainerView())
            mainCategoryViews[category.id] = view
            return view
        }
    }
}
