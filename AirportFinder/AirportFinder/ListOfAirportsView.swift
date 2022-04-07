//
//  ListOfAirportsView.swift
//  AirportFinder
//
//  Created by Amin on 1/17/1401 AP.
//

import SwiftUI

struct ListOfAirportsView: View {
    @ObservedObject var viewModel:AirportFinderViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.airports) { airport in
                AirportsCellView(for: airport)
            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.getListOfAirportsFor(lat: 1, long: 1, radius: 1) { Airports in
                
            }
        }
    }
}

struct ListOfAirportsView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAirportsView(viewModel: AirportFinderViewModel(networkManger: AmadeusNetworkMock()))
    }
}
