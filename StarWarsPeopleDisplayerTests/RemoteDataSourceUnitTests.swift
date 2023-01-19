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
    var vm: ContentViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RemoteDataSource()
        vm = ContentViewModel(datasource: sut)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        vm = nil
    }

    func testExample() throws {
        let expectation = XCTestExpectation(description: "API Data downloaded")
        sut.fetchStarWarsPeople()
        vm.$people.sink { completion in
            debugPrint("Completed")
        } receiveValue: { data in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
