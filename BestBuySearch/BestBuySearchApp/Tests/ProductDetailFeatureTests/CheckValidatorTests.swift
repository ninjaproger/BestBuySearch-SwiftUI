//
//  CheckValidatorTests.swift
//  ProductDetailFeatureTests
//

import XCTest
@testable import ProductDetailFeature

final class CheckValidatorTests: XCTestCase {
    func testEmptyCodeInput() {
        XCTAssertFalse(CheckValidator.isValid(code: ""))
    }

    func testCodeLength() {
        XCTAssertFalse(CheckValidator.isValid(code: "12121212121212"))
        XCTAssertFalse(CheckValidator.isValid(code: "12"))
        XCTAssertTrue(CheckValidator.isValid(code: "123456789012"))
    }

    func testCorrectCode() {
        XCTAssertTrue(CheckValidator.isValid(code: "842776108302"))
        XCTAssertTrue(CheckValidator.isValid(code: "883929101160"))
    }

    func testInCorrectCode() {
        XCTAssertFalse(CheckValidator.isValid(code: "842776108305"))
        XCTAssertFalse(CheckValidator.isValid(code: "883929101169"))
        XCTAssertFalse(CheckValidator.isValid(code: "111111111111"))
    }
}
