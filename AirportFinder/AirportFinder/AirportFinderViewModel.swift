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
    @Published var lat:String = ""
    @Published var long:String = ""
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
    
    
    func getListOfAirports() {
        guard let lat = Double(lat) else {
            return
        }
        guard let long = Double(long) else {
            return
        }

        if token == nil {
            getToken { [unowned self] in
                networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance, token: token!) { airportsData in
                    guard let airportsData = airportsData else {
                        return
                    }
                    self.airportsData = airportsData
                }
            } 
        }else {
            networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: 0, sort: .relevance, token: token!) { airportsData in
                guard let airportsData = airportsData else {
                    return
                }
                self.airportsData = airportsData
            }
        } 
    }
    
    func getToken(completion:@escaping() -> ()) {
        networkManger.getToken { [weak self] tokenContent in
            self?.token = tokenContent.accessToken
            completion()
        }
    }
    
}


