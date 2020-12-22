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
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .aims:
            return "AIMS 策略"
        case .aip:
            return "定投记录"
        }
    }
    
    var icon: String {
        switch self {
        case .aims:
            return "bus"
        case .aip:
            return "signature"
        }
    }
}
