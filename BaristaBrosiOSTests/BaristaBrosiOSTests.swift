//
//  BaristaBrosiOSTests.swift
//  BaristaBrosiOSTests
//
//  Created by Tyler Duic on 3/22/21.
//

import XCTest
import CoreData
import CoreBluetooth
import SwiftUI
@testable import BaristaBrosiOS

class BaristaBrosiOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


    // MARK: - Drink menu

    func testDrinkMenuIsPopulated() {
        let drinks = Drink.AllDrinks
        XCTAssertEqual(drinks.count, 12)
        XCTAssertTrue(drinks.contains { $0.name == "Gin & Tonic" })
    }

    // MARK: - Ordering

    func testOrderCommandFormatsIndexAndName() {
        XCTAssertEqual(OrderView.orderCommand(drink: 2, name: "Screwdriver"), "2: Screwdriver\n")
        XCTAssertEqual(OrderView.orderCommand(drink: 1, name: "Gin & Tonic"), "1: Gin & Tonic\n")
        XCTAssertEqual(Array(OrderView.orderCommand(drink: 0, name: "Tequila Sunrise").utf8),
                       Array("0: Tequila Sunrise\n".utf8))
    }

    func testOrderCommandsForTheOrderScreen() {
        // OrderView offers menu slots 0-3 and sends the slot index as the
        // dispenser's command code, so these positions must not move.
        let drinks = Drink.AllDrinks
        let commands = (0..<4).map { OrderView.orderCommand(drink: $0, name: drinks[$0].name) }
        XCTAssertEqual(commands, ["0: Tequila Sunrise\n", "1: Tequila Coke\n", "2: Screwdriver\n", "3: Vodka Coke\n"])
    }

    func testDrinkNamesAreUnique() {
        let names = Drink.AllDrinks.map(\.name)
        let duplicates = Dictionary(grouping: names, by: { $0 }).filter { $1.count > 1 }.keys
        XCTAssertTrue(duplicates.isEmpty, "duplicate drinks: \(duplicates.sorted())")
    }

    func testEveryDrinkHasSanePours() {
        for drink in Drink.AllDrinks {
            XCTAssertFalse(drink.name.isEmpty)
            XCTAssertFalse(drink.alcohols.isEmpty, "\(drink.name) has no alcohol")
            XCTAssertFalse(drink.mixers.isEmpty, "\(drink.name) has no mixer")
            XCTAssertTrue(drink.alcohols.values.allSatisfy { $0 > 0 }, "\(drink.name) has a non-positive pour")
            XCTAssertTrue(drink.mixers.values.allSatisfy { $0 > 0 }, "\(drink.name) has a non-positive pour")
            XCTAssertGreaterThan(drink.calories, 0)
            XCTAssertTrue((0...5).contains(drink.rating), "\(drink.name) rating out of range")
        }
    }

    func testDrinkCodableRoundTrip() throws {
        let original = Drink.AllDrinks[0]
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Drink.self, from: data)
        XCTAssertEqual(decoded, original)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
        XCTAssertEqual(json["imageName"] as? String, "TS")
    }

    // MARK: - Liquids

    func testLiquidsCoverTheDispenserBottles() {
        let names = Liquid.AllLiquids.map(\.name)
        XCTAssertEqual(names, ["Vodka", "Tequila", "Coca Cola", "Orange Juice"])
        XCTAssertEqual(Set(names).count, names.count, "duplicate liquid")
    }

    func testDispenserLiquidsAppearInTheMenu() {
        let used = Set(Drink.AllDrinks.flatMap { Array($0.alcohols.keys) + Array($0.mixers.keys) })
        for liquid in Liquid.AllLiquids {
            XCTAssertTrue(used.contains(liquid.name), "\(liquid.name) is never poured")
        }
    }

    // MARK: - Profiles

    func testProfileDataMirrorsProfile() {
        let user = UserProfile(firstName: "a", lastName: "b", age: 30, password: "pw", email: "a@b.c")
        let data = user.data
        XCTAssertEqual(data.firstName, "a")
        XCTAssertEqual(data.lastName, "b")
        XCTAssertEqual(data.age, 30)
        XCTAssertEqual(data.password, "pw")
        XCTAssertEqual(data.email, "a@b.c")
    }

    func testProfileDataDefaults() {
        let blank = UserProfile.Data()
        XCTAssertEqual(blank.age, 21)
        XCTAssertTrue(blank.email.isEmpty && blank.password.isEmpty)
    }

    func testProfileCodableRoundTrip() throws {
        let user = UserProfile.users[0]
        let decoded = try JSONDecoder().decode(UserProfile.self, from: JSONEncoder().encode(user))
        XCTAssertEqual(decoded.email, user.email)
        XCTAssertEqual(decoded.age, user.age)
    }

    // MARK: - Navigation logic

    func testLoginWithKnownUserGoesHome() {
        let view = LoginView(page: .constant(.Login))
        XCTAssertEqual(view.authenticate(email: "aryanchordia@gmail.com", password: "123"), .Home)
    }

    func testLoginEmailIsCaseInsensitive() {
        let view = LoginView(page: .constant(.Login))
        XCTAssertEqual(view.authenticate(email: "AryanChordia@Gmail.com", password: "123"), .Home)
    }

    func testLoginRejectsBadCredentials() {
        let view = LoginView(page: .constant(.Login))
        XCTAssertEqual(view.authenticate(email: "aryanchordia@gmail.com", password: "wrong"), .Login)
        XCTAssertEqual(view.authenticate(email: "nobody@example.com", password: "123"), .Login)
        XCTAssertEqual(view.authenticate(email: "", password: ""), .Login)
    }

    func testSignupGoesHome() {
        XCTAssertEqual(SignupView(page: .constant(.Signup)).signup(), .Home)
    }

    func testPageRawValues() {
        XCTAssertEqual(Pages(rawValue: 0), .Login)
        XCTAssertEqual(Pages(rawValue: 4), .CheckLiquid)
        XCTAssertNil(Pages(rawValue: 5))
    }

    // MARK: - Bluetooth helpers (no radio access)

    func testBLEConnectionStartsIdle() {
        let ble = BLEConnection()
        XCTAssertEqual(ble.lifecycleState, .bluetoothNotReady)
        XCTAssertNil(ble.connectedPeripheral)
        XCTAssertEqual(ble.readValue, "")
        XCTAssertEqual(ble.uuidHM10Service.uuidString, "0000FFE0-0000-1000-8000-00805F9B34FB")
        XCTAssertEqual(ble.uuidHM10Char.uuidString, "0000FFE1-0000-1000-8000-00805F9B34FB")
    }

    func testCharacteristicLookupWithoutPeripheralIsNil() {
        let ble = BLEConnection()
        XCTAssertNil(ble.getCharacteristic(uuid: ble.uuidHM10Char))
        // Writing with nothing connected must be a no-op, not a crash.
        ble.bleWriteCharacteristic(uuid: ble.uuidHM10Char, data: Data("L: check liquids".utf8))
        ble.bleReadCharacteristic(uuid: ble.uuidHM10Char)
    }

    func testManagerStateStrings() {
        XCTAssertEqual(CBManagerState.poweredOn.stringValue, "poweredOn")
        XCTAssertEqual(CBManagerState.poweredOff.stringValue, "poweredOff")
        XCTAssertEqual(CBManagerState.unauthorized.stringValue, "unauthorized")
        XCTAssertEqual(CBManagerState.unsupported.stringValue, "unsupported")
        XCTAssertEqual(CBManagerState.resetting.stringValue, "resetting")
        XCTAssertEqual(CBManagerState.unknown.stringValue, "unknown")
    }

}
