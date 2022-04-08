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
    
    func testCaseTokenIsEmpty_getToken_isNotEmpty() {
        let token = testCase.tokenContent
        XCTAssertEqual(token, nil)
        
        let expect = expectation(description: "GetToken")
        testCase.getToken() { [weak self] in
            expect.fulfill()
            XCTAssertNotNil(self?.testCase.tokenContent)
        }
        wait(for: [expect], timeout: 30)
    }

    
    func testGetAirports_tokenIsNil_GetToken() {
        
        XCTAssertEqual(testCase.tokenContent, nil)
        let expect = expectation(description: "getAirports")
        testCase.lat = "51.57285"
        testCase.long = "-0.44161"
        testCase.getListOfAirports() { [unowned self] in
            XCTAssertNotNil(testCase.tokenContent)
            XCTAssertEqual(testCase.airports.count, 20)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 30)
    }
    
    

}
