//
//  AirportFinderViewModelTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/19/1401 AP.
//

import XCTest
@testable import AirportFinder

class AirportFinderViewModelTests: XCTestCase {
    
    var testCase : AirportFinderViewModel!
    var defaults : UserDefaults!
    var mockedNetwork : AmadeusNetworkManagerProtocol!

    override func setUpWithError() throws {
        // injecting temporary userDefault for testing purposes
        defaults = UserDefaults(suiteName: "#file")
        defaults.removePersistentDomain(forName: "#file")
        mockedNetwork = AmadeusNetworkManager()

        testCase = AirportFinderViewModel(networkManger: mockedNetwork,userDefaults: defaults)
    }

    override func tearDownWithError() throws {

    }
    
    func testCaseTokenIsEmpty() {
        let token = testCase.userDefaults.string(forKey: "token")
        XCTAssertEqual(token, nil)
    }
    
    func testCaseTokenIsEmpty_getToken() {
        let token = testCase.token
        XCTAssertEqual(token, nil)
        
        testCase.getToken() { [weak self] in
            XCTAssertNotNil(self?.testCase.token)
        }
        
    }
    
    func testGetAirports_tokenIsNil_GetToken() {
        
        XCTAssertEqual(testCase.token, nil)
        let expect = expectation(description: "getAirports")
        testCase.getListOfAirportsFor(lat: 12, long: 12) { [unowned self] in
            XCTAssertNotNil(testCase.token)
            XCTAssertEqual(testCase.airports.count, 10)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
    
    func testGetAirports_tokenIsNotNil_getAirports() {
        
        XCTAssertEqual(testCase.token, nil)
        testCase.token = "234qwkjehk124b"
        XCTAssertNotNil(testCase.token)
        
        let expect = expectation(description: "getAirports")
        testCase.getListOfAirportsFor(lat: 12, long: 12) { [unowned self] in
            XCTAssertNotNil(testCase.token)
            XCTAssertEqual(testCase.airports.count, 10)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
    

}
