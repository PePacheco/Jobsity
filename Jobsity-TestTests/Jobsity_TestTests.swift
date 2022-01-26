//
//  Jobsity_TestTests.swift
//  Jobsity-TestTests
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import XCTest
@testable import Jobsity_Test

class Jobsity_TestTests: XCTestCase {
    
    private var show: Show?
    
    override func setUp() {
        print(self.show)
    }
    
    func testAPICallFetchShows() {
        let apiCall = expectation(description: "Testing the fetch of the first page of the shows")
        WebService.get(path: "https://api.tvmaze.com/shows?page=0", type: [Show].self) { result in
            switch result {
            case .success(let shows):
                if shows.count > 0 {
                    self.show = shows[0]
                    apiCall.fulfill()
                }
            case .failure(_):
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAPICallFetchEpisodes() {
        //
    }
    
}
