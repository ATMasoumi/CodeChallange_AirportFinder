//
//  ContentView.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AirportFinderViewModel(networkManger: AmadeusNetworkManager())
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
                        TextField("50.01", value: $viewModel.lat,formatter: viewModel.numberFormatter)
                            .keyboardType(.decimalPad)
                    }.padding()
                    
                    HStack{
                        Text("long")
                        TextField("12.3456", value: $viewModel.long,formatter: viewModel.numberFormatter)
                            .keyboardType(.decimalPad)
                    }.padding()
                    
                    Button{
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
