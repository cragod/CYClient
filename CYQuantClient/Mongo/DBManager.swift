//
//  DBManager.swift
//  CYBacktestHelper
//
//  Created by HYL on 2020/12/16.
//

import Foundation
import MongoSwift
import NIO

class DBManager {
    static let shared = DBManager()
    
    private let elg = MultiThreadedEventLoopGroup(numberOfThreads: 4)
    private var _client: MongoClient?
    var client: MongoClient? {
        get {
            if _client != nil {
                return _client
            }
            _client = try? MongoClient("mongodb://admin:admin123456@localhost:27017/?authSource=admin", using: elg)
            return _client
        }
    }
    
    private init() {
    }
    
    deinit {
        try? client?.syncClose()
        cleanupMongoSwift()
        
        try? elg.syncShutdownGracefully()
    }
}
