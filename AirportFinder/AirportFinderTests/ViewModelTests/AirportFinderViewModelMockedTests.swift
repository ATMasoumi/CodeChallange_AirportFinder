//
//  AirportFinderTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/16/1401 AP.
//

import XCTest
@testable import AirportFinder

class AirportFinderViewModelMockedTests: XCTestCase {
    var testCase: AirportFinderViewModel!
    var defaults: UserDefaults!
    var mockedNetwork: AmadeusNetworkManagerProtocol!

    override func setUpWithError() throws {
        // injecting temporary userDefault for testing purposes
        defaults = UserDefaults(suiteName: "#file")
        defaults.removePersistentDomain(forName: "#file")
        mockedNetwork = AmadeusNetworkMock()

        testCase = AirportFinderViewModel(networkManger: mockedNetwork, userDefaults: defaults)
    }
    func testGetListOfAirportsWithLatAndLongAndRadius() throws {
        let expect = expectation(description: "listOfAirports")
        testCase.lat = "51.57285"
        testCase.long = "-0.44161"
        testCase.getListOfAirports { [unowned self] in
            expect.fulfill()
            XCTAssertEqual(testCase.airports.count, 10)
        }
        wait(for: [expect], timeout: 2)
    }
    func testCaseTokenIsEmpty() {
        let token = testCase.userDefaults.string(forKey: "token")
        XCTAssertEqual(token, nil)
    }
    func testCaseTokenIsEmpty_getToken() {
        let token = testCase.tokenContent
        XCTAssertEqual(token, nil)
        
        testCase.getToken { [weak self] in
            XCTAssertNotNil(self?.testCase.tokenContent)
        }
    }
    func testGetAirports_tokenIsNil_GetToken() {
        XCTAssertEqual(testCase.tokenContent, nil)
        let expect = expectation(description: "getAirports")
        testCase.lat = "51.57285"
        testCase.long = "-0.44161"
        testCase.getListOfAirports { [unowned self] in
            XCTAssertNotNil(testCase.tokenContent)
            XCTAssertEqual(testCase.airports.count, 10)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
    func testGetAirports_tokenIsNotNil_getAirports() {
        XCTAssertEqual(testCase.tokenContent, nil)
        let tokenContent = TokenContent(type: "amadeusOAuth2Token",
                                        username: "torabi.dsd@gmail.com",
                                        applicationName: "AirportFinder",
                                        clientID: "ijUa006HGfN8b6P2IBdETvQX8oKYkJQT",
                                        tokenType: "Bearer",
                                        accessToken: "ISwPR5ft0tq82aGUgZHK40wcxiQC",
                                        expiresIn: 5,
                                        state: "approved",
                                        scope: "")
        testCase.tokenContent = tokenContent
        XCTAssertNotNil(testCase.tokenContent)
        let expect = expectation(description: "getAirports")
        testCase.lat = "51.57285"
        testCase.long = "-0.44161"
        testCase.getListOfAirports { [unowned self] in
            XCTAssertNotNil(testCase.tokenContent)
            XCTAssertEqual(testCase.airports.count, 10)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 3)
    }
    func testTokenExpires_tokenIsNil_getsAnotherToken() {
        XCTAssertEqual(testCase.tokenContent, nil)
        let tokenContent = TokenContent(type: "amadeusOAuth2Token",
                                        username: "torabi.dsd@gmail.com",
                                        applicationName: "AirportFinder",
                                        clientID: "ijUa006HGfN8b6P2IBdETvQX8oKYkJQT",
                                        tokenType: "Bearer",
                                        accessToken: "ISwPR5ft0tq82aGUgZHK40wcxiQC",
                                        expiresIn: 5,
                                        state: "approved",
                                        scope: "")
        testCase.tokenContent = tokenContent
        testCase.lat = "51.57285"
        testCase.long = "-0.44161"
        let expect = expectation(description: "getAirports")
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [unowned self] in
            XCTAssertNil(testCase.tokenContent)
            testCase.getListOfAirports {
                XCTAssertNotNil(testCase.tokenContent)
                XCTAssertEqual(testCase.airports.count, 10)
                expect.fulfill()
            }
        }
        wait(for: [expect], timeout: 10)
    }
}
