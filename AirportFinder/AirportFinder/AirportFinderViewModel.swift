//
//  AirportFinderViewModel.swift
//  AirportFinder
//
//  Created by Amin on 1/16/1401 AP.
//

import Foundation

class AirportFinderViewModel {
    let networkManger:AmadeusNetworkManagerProtocol
    init(networkManger:AmadeusNetworkManagerProtocol){
        self.networkManger = networkManger
    }
}


