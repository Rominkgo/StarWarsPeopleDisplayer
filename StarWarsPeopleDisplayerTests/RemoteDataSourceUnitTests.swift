//
//  StarWarsPeopleDisplayerTests.swift
//  StarWarsPeopleDisplayerTests
//
//  Created by David Castaneda on 1/17/23.
//

import XCTest
@testable import StarWarsPeopleDisplayer

final class RemoteDataSourceTests: XCTestCase {
    
    var sut: RemoteDataSource!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RemoteDataSource()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
//        let expectation = XCTestExpectation(description: "API Data downloaded")
//
//        sut.fetchStarWarsPeople()
//        sut.people.sink { completion in
//            debugPrint("Completed")
//        } receiveValue: { data in
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 5)
//
//
    }
}
