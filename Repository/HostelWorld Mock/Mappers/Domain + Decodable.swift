//
//  Domain + Decodable.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import Domain

struct PropertiesWrapper: Decodable {
    var properties: [PropertySummary]
}

fileprivate struct OverallRating: Decodable {
    var overall: Int
    var numberOfRatings: Int
    var overallPercentage: Float { return Float(overall) / Float(numberOfRatings) }
}

fileprivate struct Image: Decodable, Comparable {
    private var suffix: String
    private var prefix: String
    var smallSize: String { return "\(prefix)_s\(suffix)" }
    var largeSize: String { return "\(prefix)_l\(suffix)" }
    
    static func < (lhs: Image, rhs: Image) -> Bool {
        return lhs.smallSize < rhs.smallSize
    }
}

fileprivate struct City: Decodable {
    var name: String
    var country: String
}

extension PropertySummary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, overallRating, images, type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        
        let id = try! container.decode(String.self, forKey: .id)
        let name = try! container.decode(String.self, forKey: .name)
        let type = try! container.decode(String.self, forKey: .type)
        let rating = try? container.decode(OverallRating.self, forKey: .overallRating)
        let images = try! container.decode([Image].self, forKey: .images).sorted()
        
        self.init(id: id,
                  name: name,
                  propertyType: PropertyType(rawValue: type) ?? .unknown,
                  thumbnailUrl: images.first?.smallSize ?? "",
                  rating: rating?.overallPercentage)
    }
    
}

extension Property: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, overallRating, images, type
        case description, directions, address1
        case address2, city
    }
    
    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        
        let id = try! container.decode(String.self, forKey: .id)
        let name = try! container.decode(String.self, forKey: .name)
        let type = try! container.decode(String.self, forKey: .type)
        let address1 = try! container.decode(String.self, forKey: .address1)
        let address2 = try! container.decode(String.self, forKey: .address2)
        let description = try! container.decode(String.self, forKey: .description)
        let directions = try! container.decode(String.self, forKey: .directions)
        
        let rating = try? container.decode(OverallRating.self, forKey: .overallRating)
        let images = try! container.decode([Image].self, forKey: .images).sorted()
        let city = try! container.decode(City.self, forKey: .city)
        
        let address = Address(street: address1,
                              checkIn: address2,
                              city: city.name,
                              country: city.country)
        
        self.init(id: id,
                  name: name,
                  propertyType: PropertyType(rawValue: type) ?? .unknown,
                  rating: rating?.overallPercentage,
                  address: address,
                  description: description,
                  directions: directions,
                  pictures: images.map { $0.largeSize })
    }
    
}
