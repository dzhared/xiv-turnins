//
//  DeliverableTests.swift
//  DeliverableTests
//
//  Created by Jared on 3/25/23.
//

import XCTest
@testable import xiv_turnins

final class DeliverableTests: XCTestCase {
    
    func testGetDeliverable() throws {
        // Test whether XIVAPI returns expected deliverable
        let expectedName = "Holy Rainbow Shoes"
        let expectedID = 11979
        let expectedIcon = "/i/046000/046540_hr1.png"
        let expectedRecipe = 2747
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        getItemIDFromName(itemName: "Holy Rainbow Shoes") { itemID in
            if let itemID = itemID {
                getItemFromID(itemID: itemID) { item in
                    if let item = item {
                        XCTAssertEqual(item.name, expectedName)
                        XCTAssertEqual(item.id, expectedID)
                        XCTAssertEqual(item.icon, expectedIcon)
                        XCTAssertEqual(item.itemRecipeInfo[0].id, expectedRecipe)
                        expectation.fulfill()
                    } else {
                        XCTFail("Failed to retrieve item.")
                    }
                }
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testGetDeliverablePerformance() {
        // Measure time taken to retrieve item data from XIVAPI
        let sampleItems: [String] = [
            "Lignum Vitae Fishing Rod",
            "Dwarven Mythril Pickaxe",
            "Dwarven Mythril Frypan",
            "Dwarven Mythril Bracelets",
            "Swallowskin Shoes",
            "Dwarven Cotton Jacket",
            "Tincture of Dexterity",
            "Lemonade"
        ]
        
        let expectation = XCTestExpectation(description: "All items retrieved")
        
        let startTime = DispatchTime.now()
        var itemsRetrieved = 0
        
        for sampleItemName in sampleItems {
            getItemIDFromName(itemName: sampleItemName) { itemID in
                if let itemID = itemID {
                    getItemFromID(itemID: itemID) { item in
                        let endTime = DispatchTime.now()
                        let timeDelta = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
                        print("Time to retrieve \(item?.name ?? "item"): \(Double(timeDelta) / 1_000_000) ms")
                        
                        itemsRetrieved += 1
                        if itemsRetrieved == sampleItems.count {
                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
