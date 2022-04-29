//
//  AmadeusNetworkManagerTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/18/1401 AP.
//

import XCTest
@testable import AirportFinder

class AmadeusNetworkManagerTests: XCTestCase {
    var testCase: AmadeusNetworkManagerProtocol!
    override func setUpWithError() throws {
        testCase = AmadeusNetworkManager()
    }
    func testGetToken() {
        let expectation = expectation(description: "GetToken")
        testCase.getToken { result in
            expectation.fulfill()
            switch result {
            case .success(let tokenContent):
                XCTAssertEqual(tokenContent.username, "torabi.dsd@gmail.com")
            case .failure(let error):
               print(error)
            }
        }
        wait(for: [expectation], timeout: 30)
    }

}
