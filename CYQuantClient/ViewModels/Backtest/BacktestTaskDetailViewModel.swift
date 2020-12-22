//
//  BacktestTaskDetailViewModel.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import Foundation

class BacktestTaskDetailViewModel: ObservableObject {
    
    @Published var loading = false
    @Published var items = [Int]()
    
    var name: String
    init(name: String) {
        self.name = name
    }
}
