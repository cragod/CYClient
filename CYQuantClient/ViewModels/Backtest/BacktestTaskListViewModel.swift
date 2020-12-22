//
//  BacktestTaskListViewModel.swift
//  CYQuantClient
//
//  Created by HYL on 2020/12/22.
//

import Foundation
import MongoSwift

class BacktestTaskListViewModel: ObservableObject {
    @Published var loadingTasks = false
    @Published var tasks = [BacktestTaskModel]()
    
    func loadTasks() {
        if loadingTasks {
            return
        }
        loadingTasks = true
        DBManager.shared.collection(with: .backtestOverview)?.aggregate([
            [
                "$group": [
                    "_id": "$task_identifier",
                    "count": [
                        "$sum": 1
                    ]
                ]
            ],
            [
                "$project": [
                    "_id": 0,
                    "name": "$_id",
                    "count": 1
                ]
            ]
        ]).flatMap({
            $0.toArray()
        }).whenComplete({ result in
            DispatchQueue.main.async {
                self.loadingTasks = false
                switch result {
                case .success(let items):
                    self.tasks = items.map { (item) -> BacktestTaskModel in
                        BacktestTaskModel(name: item["name"]?.stringValue ?? "", count: item["count"]?.toInt() ?? 0)
                    }
                case .failure(_):
                    break
                }
            }
        })
    }
}
