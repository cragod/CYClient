//
//  CategoryManager.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/18.
//

import SwiftUI

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
            let view = AnyView(Text("hahaha"))
            mainCategoryViews[category.id] = view
            return view
        }
    }
}
