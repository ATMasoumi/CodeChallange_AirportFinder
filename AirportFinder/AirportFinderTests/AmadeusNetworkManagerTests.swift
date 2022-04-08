//
//  AmadeusNetworkManagerTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/18/1401 AP.
//

import XCTest
@testable import AirportFinder

class AmadeusNetworkManagerTests: XCTestCase {
    var testCase:AmadeusNetworkManagerProtocol!
    override func setUpWithError() throws {
        testCase = AmadeusNetworkManager()
    }

    override func tearDownWithError() throws {
        
    }

//    func testGetAirportsForLatAndLongAndRadius_IsNotNil() throws {
//        let expect = expectation(description: "listOfAirports")
//        testCase.getListOfAirportsFor(lat: 51.57285, long: -0.44161, radius: 1000, pageLimit: 20, pageOffset: 0, sort: .relevance ,token: <#T##String#>){ airports in
//            expect.fulfill()
//            XCTAssertEqual(airports.count, 0)
//        }
//        wait(for: [expect], timeout: 2)
//    }
    
    func testGetToken() {
        let expectation = expectation(description: "GetToken")
        testCase.getToken { tokenContent in
            expectation.fulfill()
            XCTAssertEqual(tokenContent.username, "torabi.dsd@gmail.com")
        }
        wait(for: [expectation], timeout: 30)
        
    }

}
