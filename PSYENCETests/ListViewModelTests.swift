//
//  PSYENCETests.swift
//  PSYENCETests
//
//  Created by Wei-Lun Su on 2021/10/19.
//

import XCTest
@testable import PSYENCE

class ListViewModelTests: XCTestCase {
    
    var viewModel: ListViewModelType!
    
    override func setUp() {
        super.setUp()
        viewModel = ListViewModel(title: "Title", service: MockService())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_title() {
        // when
        let title = viewModel.title
        let expectation = "Title"
        
        // then
        XCTAssertEqual(title, expectation)
    }
    
    func test_lists() {
        // given
        let mockItems = MockList.generateMockItems(44)
        let mockList = MockList(page: 4, last: nil, items: mockItems)
        var itemsRetrieved = false
        
        // when
        viewModel.didRetrieveItems = {
            itemsRetrieved = true
        }
        
        viewModel.list = mockList
        let lastItem = viewModel.list?.items.last
        
        // then
        XCTAssertTrue(itemsRetrieved)
        XCTAssertEqual(viewModel.list?.items.count, 44)
        XCTAssertEqual(lastItem?.description, "Description 43")
    }
    
    func test_getList() {
        // given
        let mockItems = MockList.generateMockItems(100)
        let mockList = MockList(page: 4, last: "10", items: mockItems)
        var failedRetrieveItems = false
        
        // when
        viewModel.didFailRetrieveItems = {
            failedRetrieveItems = true
        }
        viewModel.list = mockList
        viewModel.getList()
        
        // then
        XCTAssertTrue(failedRetrieveItems)
    }
    
    func test_numberOfItems() {
        // given
        let mockItems = MockList.generateMockItems(100)
        let mockList = MockList(page: 4, last: nil, items: mockItems)
        
        // when
        viewModel.list = mockList
        
        // then
        XCTAssertEqual(viewModel.numberOfItems(), 100)
    }
    
    func test_itemAtIndex() {
        // given
        let mockItems = MockList.generateMockItems(10)
        let mockList = MockList(page: 4, last: nil, items: mockItems)
        
        // when
        viewModel.list = mockList
        let item = viewModel.item(at: 11)
        let mockItem = viewModel.item(at: 2)
        
        // then
        XCTAssertNil(item)
        XCTAssertNotNil(mockItem)
    }
    
    func test_isLastItemReached() {
        // given
        let mockItems = MockList.generateMockItems(450)
        let mockList = MockList(page: 4, last: nil, items: mockItems)
        
        // when
        viewModel.list = mockList
        var isLastItemReached = viewModel.isLastItemReached(at: .init(row: 10, section: 0))
        
        // then
        XCTAssertFalse(isLastItemReached)
        
        // when
        isLastItemReached = viewModel.isLastItemReached(at: .init(row: 449, section: 0))
        
        // then
        XCTAssertTrue(isLastItemReached)
    }
}
