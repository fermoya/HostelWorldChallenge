//
//  Address.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public struct Address {
    
    public var firstStreet: String
    public var secondStreet: String
    public var city: String
    public var country: String
    
    public init(firstStreet: String,
                secondStreet: String,
                city: String,
                country: String) {
        
        self.firstStreet = firstStreet
        self.secondStreet = secondStreet
        self.city = city
        self.country = country
    }
    
}
