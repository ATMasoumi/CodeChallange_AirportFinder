//
//  AirportFinderTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/16/1401 AP.
//

import XCTest
@testable import AirportFinder

class AirportFinderTests: XCTestCase {
    
    var testCase :AirportFinderViewModel!

    override func setUpWithError() throws {
        testCase = AirportFinderViewModel(networkManger: AmadeusNetworkMock())
    }

    override func tearDownWithError() throws {

    }

    func testGetListOfAirportsWithLatAndLongAndRadius() throws {
        let expect = expectation(description: "listOfAirports")
        testCase.getListOfAirportsFor(lat: 51.57285, long: -0.44161, radius: 1000) { [unowned self] airports in
            expect.fulfill()
            XCTAssertEqual(testCase.airports.count, 10)
        }
        wait(for: [expect], timeout: 2)
    }

}
