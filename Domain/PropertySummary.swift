//
//  PropertySummary.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public enum PropertyType: String {
    case hostel = "HOSTEL"
    case apartment = "APARTMENT"
    case hotel = "HOTEL"
    case guestHouse = "GUESTHOUSE"
    case unknown
}

public struct PropertySummary {
    
    public var id: String
    public var name: String
    public var propertyType: PropertyType
    public var thumbnailUrl: String
    public var rating: Float?
    
    public init(id: String,
                name: String,
                propertyType: PropertyType,
                thumbnailUrl: String,
                rating: Float?) {
        
        self.id = id
        self.name = name
        self.propertyType = propertyType
        self.thumbnailUrl = thumbnailUrl
        self.rating = rating
    }
    
}
