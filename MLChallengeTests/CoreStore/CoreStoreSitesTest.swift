//
//  CoreStoreSitesTest.swift
//  MLChallengeTests
//
//  Created by Miguel Angel De Leon Palacios on 15/04/21.
//

import XCTest
import MLChallengeAPI
@testable import MLChallenge

class CoreStoreSitesTest: XCTestCase {
    var helper: CoreStoreSitesHelper?
    let manager = CoreStoreManagerImplementation()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager.initialize()
        helper = CoreStoreSitesHelper(manager: manager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        helper = nil
    }
    
    // MARK: - SAVE.
    func testSaveSite() {
        let expectation = self.expectation(description: "SaveSite")
        let model = [MLSite(defaultCurrencyID: "MXN", id: "MLM", name: "Mexico")]
        
        helper?.saveSites(model, completion: { expectation.fulfill() })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let site = helper?.fetchSites()?.first, let currentSite = model.first {
            XCTAssert(site.id == currentSite.id)
        }
    }
    
    // MARK: - UPDATE.
    func testUpdateSite() {
        let expectation = self.expectation(description: "UpdateSite")
        let mexico = MLSite(defaultCurrencyID: "MXN", id: "MLM", name: "Mexico")
        let argentina = MLSite(defaultCurrencyID: "ARS", id: "MLA", name: "Argentina")
        helper?.saveSites([mexico, argentina], completion: { [weak self] in
            self?.helper?.updateSelectedSite(id: "MLM")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let siteSelected = helper?.fetchSiteSelected() {
            XCTAssert(siteSelected.name == mexico.name)
        }
    }
    
    func testUpdateSite_sameID() {
        let expectation = self.expectation(description: "UpdateSite")
        let mexico = MLSite(defaultCurrencyID: "MXN", id: "MLM", name: "Mexico")
        let argentina = MLSite(defaultCurrencyID: "ARS", id: "MLA", name: "Argentina")
        helper?.saveSites([mexico, argentina], completion: { [weak self] in
            self?.helper?.updateSelectedSite(id: "MLM")
            self?.helper?.updateSelectedSite(id: "MLM")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let siteSelected = helper?.fetchSiteSelected() {
            XCTAssert(siteSelected.name == mexico.name)
        }
    }
    
    func testUpdateSite_diferentID() {
        let expectation = self.expectation(description: "UpdateSite")
        let mexico = MLSite(defaultCurrencyID: "MXN", id: "MLM", name: "México")
        let argentina = MLSite(defaultCurrencyID: "ARS", id: "MLA", name: "Argentina")
        helper?.saveSites([mexico, argentina], completion: { [weak self] in
            self?.helper?.updateSelectedSite(id: "MLM")
            self?.helper?.updateSelectedSite(id: "MLA")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        if let siteSelected = helper?.fetchSiteSelected() {
            XCTAssert(siteSelected.name == argentina.name)
        }
    }
}
