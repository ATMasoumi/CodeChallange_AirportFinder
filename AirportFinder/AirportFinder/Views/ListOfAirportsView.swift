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
                    .onAppear {
                        if airport == viewModel.airports.last {
                            print("perform network call")
                            viewModel.getListOfAirports {
                                print("Got next page")
                            }
                        }
                    }
            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        
    }
}

struct ListOfAirportsView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAirportsView(viewModel: AirportFinderViewModel(networkManger: AmadeusNetworkMock(), userDefaults: UserDefaults()))
    }
}
