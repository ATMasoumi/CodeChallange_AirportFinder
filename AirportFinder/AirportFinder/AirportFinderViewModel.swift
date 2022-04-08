//
//  AirportFinderViewModel.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation

class AirportFinderViewModel:ObservableObject {
    
    let networkManger:AmadeusNetworkManagerProtocol
    
    @Published var airportsData: AirportsData? = nil
    var airports:[Airport] {
        if let airportsData = airportsData {
            return airportsData.data
        }else {
            return []
        }
    }
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
                getAirports(lat: lat, long: long) {
                    completion()
                }
            } 
        }else {
            getAirports(lat: lat, long: long) {
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
    
    func getAirports(lat: Double, long: Double, completion:@escaping() -> ()) {
        guard let token = token else {
            return
        }


        networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance, token: token) { airportsData in
            guard let airportsData = airportsData else {
                return
            }
            self.airportsData = airportsData
            completion()
        }
    }
    
}


