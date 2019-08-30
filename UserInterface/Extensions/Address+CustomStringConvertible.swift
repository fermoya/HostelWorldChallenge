//
//  Address+Description.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 30/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

extension Address: CustomStringConvertible {
    
    public var description: String {
        var result = "\(street), \(city). \(country.uppercased())"
        if !checkIn.isEmpty {
            result += "\n\(checkIn)"
        }
        
        return result
    }
    
}
