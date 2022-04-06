//
//  ContentView.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AirportFinderViewModel(networkManger: AmadeusNetworkMock())
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 10
        return numberFormatter
    }()
    
    var body: some View {
       
        NavigationView {
            VStack {
                HStack{
                    Text("Lat")
                    TextField("50.01", value: $viewModel.lat,formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                }.padding()
                
                HStack{
                    Text("Lat")
                    TextField("12.3456", value: $viewModel.long,formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                }.padding()
                
                NavigationLink("Search") {
                    ListOfAirportsView(viewModel: viewModel)
                }
            }
            .navigationTitle("Airport Finder")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
