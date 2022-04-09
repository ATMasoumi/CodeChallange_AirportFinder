//
//  NetworkManager.swift
//  AirportFinder
//
//  Created by Amin on 1/17/1401 AP.
//

import Foundation

enum AmadeusSort:String {
    case relevance = "relevance"
    case distance = "distance"
    case flightsScore = "analytics.flights.score"
    case travelersScore = "analytics.travelers.score"
}

protocol AmadeusNetworkManagerProtocol {
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, pageLimit: Int, pageOffset: Int, sort: AmadeusSort, tokenContent: TokenContent, completion:@escaping(_ airportsData:AirportsData?) -> ())
    func getToken(completion:@escaping(_ TokenContent:TokenContent) -> ())
}

class AmadeusNetworkManager:AmadeusNetworkManagerProtocol {
    
    func getListOfAirportsFor(lat: Double, long: Double, radius: Int, pageLimit: Int, pageOffset: Int, sort: AmadeusSort, tokenContent: TokenContent, completion: @escaping (_ airportsData:AirportsData?) -> ()) {
               
        var components = URLComponents()
            components.scheme = "https"
            components.host = "test.api.amadeus.com"
            components.path = "/v1/reference-data/locations/airports"
            components.queryItems = [
                URLQueryItem(name: "latitude", value: "\(lat)"),
                URLQueryItem(name: "longitude", value: "\(long)"),
                URLQueryItem(name: "radius", value: "500"),
                URLQueryItem(name: "page[limit]", value: "20"),
                URLQueryItem(name: "page[offset]", value: "\(pageOffset)"),
                URLQueryItem(name: "sort", value: sort.rawValue)
            ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(tokenContent.accessToken)", forHTTPHeaderField:"authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let airportsData = try JSONDecoder().decode(AirportsData.self, from: data)
                DispatchQueue.main.async {
                    completion(airportsData)
                }
            } catch let error {
                print(error)
            }
        }.resume()
        
        
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
            DispatchQueue.main.async {
                completion(tokenContent!)
            }
        }.resume()
    }
}

