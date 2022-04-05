//
//  AmadeusNetworkTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/17/1401 AP.
//

import XCTest
@testable import AirportFinder

class AmadeusNetworkTests: XCTestCase {
    var testCase:AmadeusNetworkManagerProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testCase = AmadeusNetworkMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAirportsForLatAndLongAndRadius() throws {
        let airports = testCase.getListOfAirportsFor(lat: 51.57285, long: -0.44161, radius: 1000)
        print(airports.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
