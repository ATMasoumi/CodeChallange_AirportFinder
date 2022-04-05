//
//  NetworkManager.swift
//  AirportFinder
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation

protocol AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius:Int) -> [Airport]
}
class AmadeusNetworkManager:AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int) -> [Airport] {
        return []
    }
    
}
