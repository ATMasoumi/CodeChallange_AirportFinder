//
//  AirportFinderViewModel.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation

class AirportFinderViewModel:ObservableObject {
    let networkManger:AmadeusNetworkManagerProtocol
    @Published var airports:[Airport] = []
    init(networkManger:AmadeusNetworkManagerProtocol){
        self.networkManger = networkManger
    }
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, completion: @escaping ([Airport]) -> ()) {
        networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius) { airports in
            self.airports = airports
            completion(airports)
        }
    }
    
}


