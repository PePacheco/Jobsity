//
//  TestShowsListViewModel.swift
//  Jobsity-TestTests
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/02/22.
//

import XCTest
@testable import Jobsity_Test

class TestShowsListViewModel: XCTestCase {
    
    var mockWebService: WebServiceMock?
    var viewModel: ShowsListViewModel?

    override func setUp() {
        super.setUp()
        let webServiceMock = WebServiceMock()
        self.mockWebService = webServiceMock
        self.viewModel = ShowsListViewModel(webService: webServiceMock)
    }
    
    override func tearDown() {
        self.mockWebService = nil
        self.viewModel = nil
    }
    
    func testInitViewModel() {
        XCTAssert(!viewModel!.isLoading.value)
        XCTAssert(viewModel!.shows.value.count == 0)
    }

}
