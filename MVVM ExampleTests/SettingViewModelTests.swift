//
//  SettingViewModelTests.swift
//  MVVM ExampleTests
//
//  Created by Fomagran on 2021/06/02.
//

import XCTest
@testable import MVVM_Example

class SettingViewModelTests: XCTestCase {

    private var settingVM:SettingViewModel = SettingViewModel()
    
    override func setUp() {
        super.setUp()
        
    }
    
    func test_isDefaultCelcius() {
        XCTAssertEqual(settingVM.selectedUnit,.celsius)
    }
    
    func test_isDefaultDisplayNameCelcius() {
        XCTAssertEqual(settingVM.selectedUnit.displayName,"Celcius")
    }
    
    
    func test_canSaveUserUnitSelection() {
        self.settingVM.selectedUnit = .celsius
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey:"unit"))
    }
    
    override class func tearDown() {
        super.tearDown()
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
   

}
