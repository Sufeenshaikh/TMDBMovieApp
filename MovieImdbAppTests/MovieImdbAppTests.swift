//
//  MovieImdbAppTests.swift
//  MovieImdbAppTests
//
//  Created by Dr. Mac on 02/06/24.
//

import XCTest
@testable import MovieImdbApp

final class MovieImdbAppTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    
    }

    func testFetchLatestMovies() throws {
            let expectation = self.expectation(description: "Fetching latest movies")
            
            TMDBServices.shared.fetchLatestMovies { result in
                switch result {
                case .success(let movies):
                    XCTAssertNotNil(movies, "Movies should not be nil")
                    XCTAssertFalse(movies.isEmpty, "Movies array should not be empty")
                case .failure(let error):
                    XCTFail("Error fetching latest movies: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }

        func testFetchPopularMovies() throws {
            let expectation = self.expectation(description: "Fetching popular movies")
            
            TMDBServices.shared.fetchPopularMovies { result in
                switch result {
                case .success(let movies):
                    XCTAssertNotNil(movies, "Movies should not be nil")
                    XCTAssertFalse(movies.isEmpty, "Movies array should not be empty")
                case .failure(let error):
                    XCTFail("Error fetching popular movies: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
}
