//
//  ContentView.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import SwiftUI
import Lottie

struct ContentView: View {
    @StateObject var viewModel = AirportFinderViewModel(networkManger: AmadeusNetworkManager(), userDefaults: UserDefaults())
    @State var DetailViewIsActive = false
    @State var alertIsActive = false
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink("", isActive: $DetailViewIsActive) {
                    ListOfAirportsView(viewModel: viewModel)
                }
                
                VStack {
                    HStack{
                        Text("Find Airports by Coordinates")
                            .padding()
                        Spacer()
                    }
                    Spacer()
                    LottieView(name: "drop-off-pin", loopMode: .loop)
                        .frame(width: 100, height: 100)
                    HStack {
                        VStack(alignment:.center){
                            Text("Lat")
                            TextField("51.57285", text: $viewModel.lat)
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                                .padding(.vertical,5)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .opacity(0.1)
                                }
                        }.padding()
                        
                        VStack(alignment:.center){
                            Text("long")
                            TextField("-0.44161", text: $viewModel.long)
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                                .padding(.vertical,5)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .opacity(0.1)
                                }
                        }.padding()
                    }.padding()
                    
                    Spacer()
                    
                    Button{
                        guard viewModel.isEligibleForPresent else {
                            alertIsActive = true
                            return
                        }
                        DetailViewIsActive = true
                    }label: {
                        HStack{
                            Spacer()
                            Text("Search")
                            Spacer()
                        }
                    }
                    .padding()
                    .padding(.bottom)
                    .buttonStyle(.borderedProminent)
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
