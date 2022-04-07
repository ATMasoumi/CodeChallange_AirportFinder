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
    @Published var lat:Double? = nil
    @Published var long:Double? = nil
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        return numberFormatter
    }()
    
    init(networkManger:AmadeusNetworkManagerProtocol){
        self.networkManger = networkManger
        getListOfAirportsFor(lat: 1, long: 1, radius: 1) { _ in }
    }
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, completion: @escaping ([Airport]) -> ()) {
        networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance) { airports in
            self.airports = airports
            completion(airports)
        }
    }
    func getTokenIfNeeded() {
        networkManger.getToken { TokenContent in
            print(TokenContent)
        }
    }
    
}


