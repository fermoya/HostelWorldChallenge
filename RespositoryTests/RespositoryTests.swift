//
//  RespositoryTests.swift
//  RespositoryTests
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import XCTest
import Domain
import Mockingjay
@testable import Repository

class RespositoryTests: XCTestCase {

    let container = RepositoryContainer()
    
    func test_fetchProperties() {
        let dataStore = container.dataStore
        let expectation = XCTestExpectation(description: "Fetching properties of a mock city")
        
        dataStore.fetchProperties { (response) in
            guard let properties = try? response.get() else {
                return XCTFail()
            }
            
            XCTAssertFalse(properties.isEmpty)            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test_fetchProperty() {
        let propertyId = "40903"
        let dataStore = container.dataStore
        let expectation = XCTestExpectation(description: "Fetching property 40903")
        
        dataStore.fetchPropertyDetail(of: propertyId) { (response) in
            guard let property = try? response.get() else {
                return XCTFail()
            }
            
            XCTAssertEqual(property.id, propertyId)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test_fetchProperties_forbidden() {
        
        let dataStore = container.dataStore
        stub(uri(HostelWorldEndpoint.properties(1530).url),
             http(403))
        
        let expectation = XCTestExpectation(description: "Mocking Forbidden response")
        dataStore.fetchProperties { (response) in
            switch response {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .forbidden)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }

    func test_fetchPropertyDetail_unknownError() {
        let propertyId = "40903"
        
        let dataStore = container.dataStore
        let httpResponseCode = 506
        stub(uri(HostelWorldEndpoint.propertyDetail(propertyId).url),
             http(httpResponseCode))
        
        let expectation = XCTestExpectation(description: "Mocking Forbidden response")
        dataStore.fetchPropertyDetail(of: propertyId) { (response) in
            switch response {
            case .success:
                XCTFail()
            case .failure(let error):
                if case .unknown(let message) = error {
                    XCTAssertTrue(message.contains("\(httpResponseCode)"))
                } else {
                    XCTFail()
                }
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
}
