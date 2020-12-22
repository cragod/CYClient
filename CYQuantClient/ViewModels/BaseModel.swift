//
//  BaseModel.swift
//  GatroQuant (iOS)
//
//  Created by HYL on 2020/12/19.
//

import Combine

class BaseModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Published var loading: Bool = false
    @Published var error: CYError?
}
