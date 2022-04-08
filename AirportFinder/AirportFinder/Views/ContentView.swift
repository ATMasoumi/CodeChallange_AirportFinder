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
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(uiColor: UIColor.systemGroupedBackground).ignoresSafeArea()
                
                NavigationLink("", isActive: $DetailViewIsActive) {
                    ListOfAirportsView(viewModel: viewModel)
                }
                
                VStack {
                    HStack{
                        Text("Lat")
                        TextField("51.57285", text: $viewModel.lat)
                            .keyboardType(.decimalPad)
                    }.padding()
                    
                    HStack{
                        Text("long")
                        TextField("-0.44161", text: $viewModel.long)
                            .keyboardType(.decimalPad)
                    }.padding()
                    
                    Button{
                        viewModel.getListOfAirports(){
                            
                        }
                        DetailViewIsActive = true
                    }label: {
                        Text("Search")
                    }
                    
                }
                .navigationTitle("Airport Finder")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
