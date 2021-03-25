//
//  CardsViewControllerTests.swift
//  BootcampMagicTests
//
//  Created by rayane.x.nobrega on 25/03/21.
//

import XCTest
@testable import BootcampMagic

class CardsViewControllerTests: XCTestCase {
    var sut: CardsViewController!
    var service: NetworkManageFake!

    override func setUp() {
        service = NetworkManageFake()
        sut = CardsViewController(service: service)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewType() {
        XCTAssertTrue(sut.view is CardsListView)
    }

    func testFetchCards() {
        XCTAssertTrue(service.requestCalled)
    }

    func testEmptyCode() {
        XCTAssertTrue(sut.expensionCode.isEmpty)
    }
    
    func testExpansionCode() {
        sut.didSelectExpansion(expantionCode: "fake expansion code")
        XCTAssertEqual(sut.expensionCode, "fake expansion code")
    }
}
