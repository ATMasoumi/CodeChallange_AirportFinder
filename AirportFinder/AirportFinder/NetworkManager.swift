//
//  NetworkManager.swift
//  AirportFinder
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation
import Amadeus

enum AmadeusSort:String {
    case relevance = "relevance"
    case distance = "distance"
    case flightsScore = "analytics.flights.score"
    case travelersScore = "analytics.travelers.score"
}

protocol AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, pageLimit: Int, pageOffset: Int, sort: AmadeusSort, completion:@escaping(_ airports:[Airport]) -> ())
    func getToken(completion:@escaping(_ TokenContent:TokenContent) -> ())
}

class AmadeusNetworkManager:AmadeusNetworkManagerProtocol {
    
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, pageLimit: Int, pageOffset: Int, sort: AmadeusSort, completion: @escaping ([Airport]) -> ()) {
        completion([])
    }
    
    func getToken(completion:@escaping(_ TokenContent:TokenContent) -> ()) {
        
        let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
        
        let parameters = [
            "grant_type":"client_credentials",
            "client_id":"ijUa006HGfN8b6P2IBdETvQX8oKYkJQT",
            "client_secret":"8ANTHxyXINXhMFUC"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        request.httpBody = parameters.percentEncoded()
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            let tokenContent = try? JSONDecoder().decode(TokenContent.self, from: data)
            completion(tokenContent!)
        }.resume()
    }
}

