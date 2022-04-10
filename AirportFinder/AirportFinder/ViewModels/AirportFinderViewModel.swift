//
//  AirportFinderViewModel.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation
import Combine

class AirportFinderViewModel:ObservableObject {
    
    let networkManger:AmadeusNetworkManagerProtocol
    let radius = 500
    let userDefaults:UserDefaults
    
    
    @Published var airportsData: AirportsData? = nil
    @Published var lat:String = "51.57285"
    @Published var long:String = "-0.44161"
    @Published var pageOffset = 0
    @Published var airports:[Airport] = []
    @Published var sort:AmadeusSort = .relevance
    @Published var indicatorPresented:Bool = false

    @Published var showErrorAlert = false
    @Published var errorMessage = "Cannot process numbers greater than 5."
    
    private var subscriptions = [AnyCancellable]()
    
    
    var isEligibleForPresent:Bool {
        guard !lat.isEmpty else { return false }
        guard !long.isEmpty else { return false }
        return true
    }
    var tokenContent:TokenContent? {
        set {
            saveToken(newValue)
        }
        get {
            retrieveToken()
        }
    }
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        return numberFormatter
    }()
    
    init(networkManger:AmadeusNetworkManagerProtocol, userDefaults:UserDefaults) {
        self.networkManger = networkManger
        self.userDefaults = userDefaults
        $sort.dropFirst().sink { [unowned self] newSort in
            cleanData()
            
            indicatorPresented = true
            getListOfAirports {
                print("Got next page")
                indicatorPresented = false
            }
        }.store(in: &subscriptions)
    }
   
    func saveToken(_ tokenContent:TokenContent?) {
        guard let tokenContent = tokenContent else { return }
        let tokenData = try? JSONEncoder().encode(tokenContent)
        userDefaults.set(tokenData, forKey: "token")
        userDefaults.set(Date().timeIntervalSince1970+Double(tokenContent.expiresIn),forKey: "tokenDate")
    }
   
    func retrieveToken() -> TokenContent? {
        if let data = userDefaults.value(forKey:"token") as? Data {
            let tokenContent = try? JSONDecoder().decode(TokenContent.self, from: data)
            let date = Date(timeIntervalSince1970: userDefaults.double(forKey: "tokenDate"))
            if date > Date() {
                return tokenContent
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    func getListOfAirports(completion:@escaping() -> ()) {
        
        guard let lat = Double(lat) else {
            return
        }
        guard let long = Double(long) else {
            return
        }

        if let tokenContent = tokenContent {
            networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: pageOffset, sort: sort, tokenContent: tokenContent) { [unowned self] airportsData in
                guard let airportsData = airportsData else {
                    return
                }
                self.airportsData = airportsData
                airports.append(contentsOf: airportsData.data)
                pageOffset += 1
                completion()
                
            }
        } else {
            getToken { [unowned self] in
                networkManger.getListOfAirportsFor(lat: lat, long: long, radius: radius,pageLimit: 20, pageOffset: pageOffset, sort: sort, tokenContent: tokenContent!) { airportsData in
                    guard let airportsData = airportsData else {
                        return
                    }
                    self.airportsData = airportsData
                    self.airports.append(contentsOf: airportsData.data)
                    pageOffset += 1
                    completion()
                }
            }
        } 
    }
    
    func getToken(completion:@escaping() -> ()) {
        
        networkManger.getToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showErrorAlert = true
                self.indicatorPresented = false 
            case .success(let tokenContent):
                self.tokenContent = tokenContent
            }
        }
    }
    func cleanData(){
        airportsData = nil
        airports = []
        pageOffset = 0
    }
    
}


