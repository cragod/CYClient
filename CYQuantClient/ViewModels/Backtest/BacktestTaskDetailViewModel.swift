//
//  BacktestTaskDetailViewModel.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import Foundation
import MongoSwift

class BacktestTaskDetailViewModel: ObservableObject {
    
    @Published var loading = false
    @Published var items = [BacktestDetailModel]()
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func loadItems() {
        if loading {
            return
        }
        loading = true
        DBManager.shared.collection(with: .backtestOverview, modelType: BacktestDetailModel.self)?.find([
            "task_identifier": BSON(stringLiteral: name)
        ]).flatMap({
            $0.toArray()
        }).whenComplete({ result in
            DispatchQueue.main.async {
                self.loading = false
                switch result {
                case .success(let items):
                    print(items)
                    self.items = items
                case .failure(_):
                    break
                }
            }
        })
    }
}
