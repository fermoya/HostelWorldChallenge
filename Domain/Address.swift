//
//  Address.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public struct Address {
    
    public var street: String
    public var checkIn: String
    public var city: String
    public var country: String
    
    public init(street: String,
                checkIn: String,
                city: String,
                country: String) {
        
        self.street = street
        self.checkIn = checkIn
        self.city = city
        self.country = country
    }
    
}
