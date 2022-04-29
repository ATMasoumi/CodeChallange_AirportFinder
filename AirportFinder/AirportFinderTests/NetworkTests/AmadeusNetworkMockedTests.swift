//
//  AmadeusNetworkTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/17/1401 AP.
//

import XCTest
@testable import AirportFinder

class AmadeusNetworkMockedTests: XCTestCase {
    var testCase: AmadeusNetworkManagerProtocol!
    override func setUpWithError() throws {
        testCase = AmadeusNetworkMock()
    }
    func testGetAirportsForLatAndLongAndRadius_IsNotNil() throws {
        let expect = expectation(description: "listOfAirports")
        let tokenContent = TokenContent(type: "amadeusOAuth2Token",
                                        username: "torabi.dsd@gmail.com",
                                        applicationName: "AirportFinder",
                                        clientID: "ijUa006HGfN8b6P2IBdETvQX8oKYkJQT",
                                        tokenType: "Bearer",
                                        accessToken: "ISwPR5ft0tq82aGUgZHK40wcxiQC",
                                        expiresIn: 1799,
                                        state: "approved",
                                        scope: "")
        testCase.getListOfAirportsFor(lat: 51.57285,
                                      long: -0.44161,
                                      radius: 1000,
                                      pageLimit: 20,
                                      pageOffset: 0,
                                      sort: .relevance,
                                      tokenContent: tokenContent ) { airports in
            expect.fulfill()
            XCTAssertEqual(airports?.meta.count, 32)
            XCTAssertEqual(airports?.data.first?.name, "HEATHROW")
        }
        wait(for: [expect], timeout: 2)
    }

}
