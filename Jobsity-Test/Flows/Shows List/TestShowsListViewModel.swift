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
    
    func testFetchWithoutError() {
        viewModel!.fetchShows()
        XCTAssert(viewModel!.shows.value.count == 1)
    }
    
    func testFetchWithError() {
        mockWebService!.fetchShowsError = .parsingJsonError
        viewModel!.fetchShows()
        XCTAssert(viewModel!.shows.value.count == 0)
    }
    
    func testCellViewModel() {
        let cellViewModel = ShowsListCellViewModel(with: Show(id: 1, url: "", name: "", type: "", language: "", genres: ["Horror", "Action", "Comedy"], schedule: Schedule(time: "", days: []), image: Image(medium: "", original: ""), summary: ""))
        XCTAssert(cellViewModel.genres == "Horror, Action, Comedy")
    }

}
