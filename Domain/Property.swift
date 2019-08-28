//
//  Property.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

public struct Property {
    
    public var id: String
    public var name: String
    public var propertyType: PropertyType
    public var rating: Float?
    public var address: Address
    public var description: String
    public var directions: String
    public var pictures: [String]
    
    public init(id: String,
                name: String,
                propertyType: PropertyType,
                rating: Float?,
                address: Address,
                description: String,
                directions: String,
                pictures: [String]) {
        
        self.id = id
        self.name = name
        self.propertyType = propertyType
        self.address = address
        self.rating = rating
        self.description = description
        self.directions = directions
        self.pictures = pictures
    }
}
