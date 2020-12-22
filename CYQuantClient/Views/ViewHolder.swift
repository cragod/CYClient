//
//  ViewHolder.swift
//  GatroQuant
//
//  Created by HYL on 2020/12/19.
//

import SwiftUI

class ViewHolder {
    static let shared = ViewHolder()
    private var views = [String: AnyView]()
    
    func view(for key: String) -> AnyView? {
        return views[key]
    }
    
    func view(for key: String, defaultView: AnyView) -> AnyView {
        if let v = views[key] {
            return v
        } else {
            views[key] = defaultView
            return defaultView
        }
    }
}
