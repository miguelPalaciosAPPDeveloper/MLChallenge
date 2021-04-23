//
//  CoreStoreManager.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 14/04/21.
//

import Foundation
import CoreStore

// MARK: - PROTOCOL
protocol CoreStoreManager {
    var dataStack: DataStack { get }
    func initialize()
}

// MARK: - IMPLEMENTATION
final class CoreStoreManagerImplementation: CoreStoreManager {
    // MARK: - Properties.
    private let fileModel = "MLChallenge"
    private let fileModel2 = "MLChallenge_v2"
    private let dataBaseName = "MLChallengeDB.sqlite"
    
    lazy var dataStack: DataStack = { return CoreStore.defaultStack }()
    
    func initialize() {
        let dataStack = DataStack(xcodeModelName: fileModel,
                                  bundle: Bundle.main,
                                  migrationChain: [fileModel, fileModel2])
        _ = try? dataStack.addStorageAndWait(InMemoryStore())
        CoreStore.defaultStack = dataStack
    }
}
