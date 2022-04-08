//
//  AmadeusNetworkMock.swift
//  AirportFinderTests
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation
@testable import AirportFinder

class AmadeusNetworkMock:AmadeusNetworkManagerProtocol {
    
    func getToken(completion: @escaping (TokenContent) -> ()) {
        let tokenContent = TokenContent(type: "amadeusOAuth2Token", username: "torabi.dsd@gmail.com", applicationName: "AirportFinder", clientID: "ijUa006HGfN8b6P2IBdETvQX8oKYkJQT", tokenType: "Bearer", accessToken: "ISwPR5ft0tq82aGUgZHK40wcxiQC", expiresIn: 1799, state: "approved", scope: "")
        completion(tokenContent)
    }
    
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, pageLimit: Int, pageOffset: Int, sort: AmadeusSort, token: String, completion: @escaping ([Airport]) -> ()) {
        let data = getData(name: "MockAirportJson")
        if let listOfAirports = try? JSONDecoder().decode(ListOfAirports.self, from: data){
            completion(listOfAirports.data)
        }else{
            completion([])
        }
    }
    
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
}
