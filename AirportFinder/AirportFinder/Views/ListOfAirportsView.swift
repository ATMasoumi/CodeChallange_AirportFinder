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
        .toolbar {
            toolbarContent()
        }
        .onDisappear {
            viewModel.cleanData()
        }
    }
    func  toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Menu(content: {
                Button("Relevance") {
                    viewModel.sort = .relevance
                }
                Button("Distance") {
                    viewModel.sort = .distance
                }
                Button("Flights Score") {
                    viewModel.sort = .flightsScore
                }
                Button("Travelers Score") {
                    viewModel.sort = .travelersScore
                }
                
            }, label: {
                HStack {
                    switch viewModel.sort{
                    case .travelersScore:
                        Text("Travelers Score")
                    case .relevance:
                        Text("Relevance")
                    case .flightsScore:
                        Text("Flights Score")
                    case .distance:
                        Text("Distance")
                    }
                    Image(systemName: "chevron.down")
                        .font(.footnote)
                }
            })
        }
    }
}

struct ListOfAirportsView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAirportsView(viewModel: AirportFinderViewModel(networkManger: AmadeusNetworkMock(), userDefaults: UserDefaults()))
    }
}
