//
//  ListOfAirportsCellView.swift
//  AirportFinder
//
//  Created by Amin on 1/18/1401 AP.
//

import SwiftUI

struct AirportsCellView: View {
    let airport: Airport
    init(for airport: Airport) {
        self.airport = airport
    }
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(airport.name)
                    .bold()
                    .lineLimit(1)
                Text(airport.address.cityName)
                    .font(.caption)
                    .bold()
                    .lineLimit(1)
                Spacer()
                Text("\(airport.distance.value) \(airport.distance.unit)")
            }
            HStack {
                Text("IATA Code: \(airport.iataCode)")
                Spacer()
                Text(airport.timeZoneOffset)
            }
        }.foregroundColor(.black)
        .padding()
        .background {
            Color.white
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
        }
    }
}

struct ListOfAirportsCellView_Previews: PreviewProvider {
    static var previews: some View {
        let geoCode = GeoCode(latitude: 12, longitude: 12)
        let address = Address(cityName: "Hamedan",
                              cityCode: "0813",
                              countryName: "Iran",
                              countryCode: "+98",
                              regionCode: "98")
        let distance = Distance(value: 10, unit: "KM")
        let analytics = Analytics(flights: Flights(score: 10), travelers: Flights(score: 12))
        let airport = Airport(
            type: "Military",
            subType: "AirDefence",
            name: "Noje",
            detailedName: "Noje Hamedan",
            timeZoneOffset: "+1:00",
            iataCode: "1234",
            geoCode: geoCode,
            address: address,
            distance: distance,
            analytics: analytics,
            relevance: 10)
        AirportsCellView(for: airport)
    }
}
