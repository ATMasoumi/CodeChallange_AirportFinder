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
    let radius = 500
    let userDefaults:UserDefaults
    var token:String? {
        set {
            userDefaults.set(newValue, forKey: "token")
        }
        get {
            userDefaults.string(forKey:"token")
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        return numberFormatter
    }()
    
    init(networkManger:AmadeusNetworkManagerProtocol,userDefaults:UserDefaults){
        self.networkManger = networkManger
        self.userDefaults = userDefaults
    }
    
    func getListOfAirportsFor(lat: Double, long: Double, completion: @escaping () -> ()) {
        if token == nil {
            getToken { [unowned self] in
                getAirports {
                    completion()
                }
            } 
        }else {
            getAirports {
                completion()
            }
        } 
    }
    
    func getToken(completion:@escaping() -> ()) {
        networkManger.getToken { [weak self] tokenContent in
            self?.token = tokenContent.accessToken
            completion()
        }
    }
    
    func getAirports(completion:@escaping() -> ()) {
        lat = 12
        long = 12
        
        guard let lat = lat else {
            completion()
            return
        }
        guard let long = long else {
            completion()
            return
        }

        networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance) { airports in
            self.airports = airports
            completion()
        }
    }
    
}


