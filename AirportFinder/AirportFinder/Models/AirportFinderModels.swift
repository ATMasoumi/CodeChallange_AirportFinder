//
//  AirportFinderModels.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation

// MARK: - ListOfAirports
struct AirportsData: Codable {
    let meta: Meta
    var data: [Airport]
}

// MARK: - Datum
struct Airport: Codable, Equatable, Identifiable {
    var id: String {
        String(geoCode.latitude) + String(geoCode.longitude)
    }
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        lhs.geoCode.latitude == rhs.geoCode.latitude && lhs.geoCode.longitude == rhs.geoCode.longitude
    }
    let type: String
    let subType: String
    let name, detailedName: String
    let timeZoneOffset: String
    let iataCode: String
    let geoCode: GeoCode
    let address: Address
    let distance: Distance
    let analytics: Analytics
    let relevance: Double
}

// MARK: - Address
struct Address: Codable {
    let cityName, cityCode: String
    let countryName: String
    let countryCode: String
    let regionCode: String
}

// MARK: - Analytics
struct Analytics: Codable {
    let flights, travelers: Flights
}

// MARK: - Flights
struct Flights: Codable {
    let score: Int
}

// MARK: - Distance
struct Distance: Codable {
    let value: Int
    let unit: String
}

// MARK: - GeoCode
struct GeoCode: Codable {
    let latitude, longitude: Double
}
// MARK: - Meta
struct Meta: Codable {
    let count: Int
    let links: Links
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String
    let last: String?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next, last
    }
}
