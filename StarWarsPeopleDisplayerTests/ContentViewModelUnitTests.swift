//
//  StarWarsPeopleDisplayerTests.swift
//  StarWarsPeopleDisplayerTests
//
//  Created by David Castaneda on 1/17/23.
//

import XCTest
import Combine
@testable import StarWarsPeopleDisplayer

final class ContentViewModelTests: XCTestCase {
    
    var sut: ContentViewModel!
    var dataSource: RemoteDataSourceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSource = RemoteDataSourceMock()
        sut = ContentViewModel(datasource: dataSource)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        dataSource = nil
    }

    func test_IsDataReceived() {
        //Given
        let expectation = XCTestExpectation(description: "DataReceived")
        dataSource.peopleResponse = [People(name: "hello", gender: "male")]
        dataSource.shouldTestFail = false
        
        var subscription: Set<AnyCancellable> = []
        
        sut.getPeopleData()
        sut.$people.sink { _ in
            expectation.fulfill()

        } receiveValue: { data in
            XCTAssert(data.count == 1)
            XCTAssertFalse(data[0].isLiked)
            expectation.fulfill()
        }
        .store(in: &subscription)

        wait(for: [expectation], timeout: 1)
    }
}
