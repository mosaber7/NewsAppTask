//
//  NSManagedObjectContextSpy.swift
//  NewsApp_GizaSysTests
//
//  Created by Saber on 18/09/2021.
//

import XCTest
import CoreData

class NSManagedObjectContextSpy: NSManagedObjectContext {
    var expectation: XCTestExpectation?

        var saveWasCalled = false

        // MARK: - Perform
        override func performAndWait(_ block: () -> Void) {
            super.performAndWait(block)

            expectation?.fulfill()
        }

        // MARK: - Save
        override func save() throws {
            try super.save()

            saveWasCalled = true
        }
}


