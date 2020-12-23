//
//  DBManager.swift
//  CYBacktestHelper
//
//  Created by HYL on 2020/12/16.
//

import Foundation
import MongoSwift
import NIO

enum DBName: String {
    case backtest
}

enum DBCollectionType {
    case backtestOverview
    
    var dbName: String {
        switch self {
        case .backtestOverview:
            return DBName.backtest.rawValue
        }
    }
    
    var collectionName: String {
        switch self {
        case .backtestOverview:
            return "overview"
        }
    }
}

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
    
    func collection(with type: DBCollectionType) -> MongoCollection<BSONDocument>? {
        client?.db(type.dbName).collection(type.collectionName)
    }
    
    func collection<T: Codable>(with type: DBCollectionType, modelType: T.Type) -> MongoCollection<T>? {
        client?.db(type.dbName).collection(type.collectionName, withType: modelType.self)
    }
}
