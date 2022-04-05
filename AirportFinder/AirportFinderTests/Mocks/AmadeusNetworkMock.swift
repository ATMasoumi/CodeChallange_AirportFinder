//
//  AmadeusNetworkMock.swift
//  AirportFinderTests
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation
@testable import AirportFinder

class AmadeusNetworkMock:AmadeusNetworkManagerProtocol {
    
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int) -> [Airport] {
        let data = getData(name: "MockAirportJson")
        if let listOfAirports = try? JSONDecoder().decode(ListOfAirports.self, from: data){
            return listOfAirports.data
        }else{
            return []
        }
    }
    
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
}
