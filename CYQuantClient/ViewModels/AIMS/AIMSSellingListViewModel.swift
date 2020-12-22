//
//  AIMSSellingListViewModel.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/19.
//

import Foundation

class AIMSSellingListViewModel: BaseModel {

    @Published var items: [AIMSSelling] = []
    
    var totalProfit: Float {
        items.reduce(0) { (res, selling) -> Float in
            res + selling.profit
        }
    }
    
    func load() {
        if loading {
            return
        }
        loading = true
        Requester<[AIMSSelling], [AIMSSelling]>.requestPath(.aimsSellings)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (value) in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.error = error
                }
                self.loading = false
            } receiveValue: { [weak self] (items) in
                guard let self = self else { return }
                self.items = items
            }
            .store(in: &subscriptions)

    }
}
