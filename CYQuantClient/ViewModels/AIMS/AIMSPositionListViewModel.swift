//
//  AIMSPositionListViewModel.swift
//  GatroQuant
//
//  Created by HYL on 2020/12/18.
//

import Combine
import Foundation

typealias BalanceInfo = Dictionary<String, Float>

class AIMSPositionListViewModel: BaseModel {
    @Published var items: [AIMSPosition] = []
    @Published var balanceInfo: BalanceInfo = [:]
    
    var totalCost: Float {
        items.isEmpty ? 0 : items.reduce(0.0, { (res, pos) -> Float in
            res + pos.cost
        })
    }
    
    func load() {
        if loading {
            return
        }
        loading = true
        Requester<[AIMSPosition], [AIMSPosition]>.requestPath(.aimsPosition)
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
        Requester<BalanceInfo, BalanceInfo>.requestPath(.aimsBalance)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (value) in
                guard let self = self else { return }
                self.loading = false
            } receiveValue: { [weak self] (info) in
                guard let self = self else { return }
                self.balanceInfo = info
            }
            .store(in: &subscriptions)

    }
}
