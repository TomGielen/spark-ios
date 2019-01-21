//
//  SparkTests.swift
//  SparkTests
//
//  Created by Tom Gielen on 14/01/2019.
//  Copyright © 2019 Spark Inc. All rights reserved.
//

import XCTest
@testable import Spark


class SparkTests: XCTestCase {

    func testColor() {
        let ConvertedColor = UIColor.rgb(red: 100, green: 0, blue: 0, alpha: 1)
        
        XCTAssertNil(ConvertedColor)
    }
    
}
