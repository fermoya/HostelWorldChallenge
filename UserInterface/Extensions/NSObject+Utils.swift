//
//  NSObject+Utils.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
}
