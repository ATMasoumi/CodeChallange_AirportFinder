//
//  ContentView.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AirportFinderViewModel(networkManger: AmadeusNetworkManager(), userDefaults: UserDefaults())
    @State var DetailViewIsActive = false
    @State var alertIsActive = false
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(uiColor: UIColor.systemGroupedBackground).ignoresSafeArea()
                
                NavigationLink("", isActive: $DetailViewIsActive) {
                    ListOfAirportsView(viewModel: viewModel)
                }
                
                VStack {
                    HStack {
                        VStack(alignment:.leading){
                            Text("Lat")
                            TextField("51.57285", text: $viewModel.lat)
                                .keyboardType(.decimalPad)
                        }.padding()
                        
                        VStack(alignment:.leading){
                            Text("long")
                            TextField("-0.44161", text: $viewModel.long)
                                .keyboardType(.decimalPad)
                        }.padding()
                    }.padding()
                    Button{
                        guard viewModel.isEligibleForPresent else {
                            alertIsActive = true
                            return
                        }
                        DetailViewIsActive = true
                    }label: {
                        Text("Search")
                    }
                }.navigationTitle("Airport Finder")
            }
            .alert("Empty Fileds", isPresented: $alertIsActive) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
