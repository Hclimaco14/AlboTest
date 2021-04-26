//
//  PruebaAlboTests.swift
//  PruebaAlboTests
//
//  Created by Hector Climaco on 23/04/21.
//

import XCTest
import CoreLocation
@testable import PruebaAlbo

class PruebaAlboTests: XCTestCase {

    private var expectation:XCTestExpectation!
    let services = ServicesManager()
    private let customInterval:TimeInterval =  60
    
    override func setUpWithError() throws {
      expectation = self.expectation(description: "waitingRespons")
      configuereService()
    }
    
    func testLocalized()  {
        XCTAssert("ALERT_ERROR".localized() == "Advertencia")
    }
    
    
    func testGetTransactions() {
      services.airportSearch(distance:100,location:CLLocation(latitude: 51.511142, longitude: -0.103869),loadFromFile:false) { (response, error) in
        if error != nil {
          XCTAssert(false, "airportSearch fue incorrecto")
          self.expectation.fulfill()
        } else {
          print("Response ", String(describing: response))
          XCTAssert(true, "airportSearch fue correcto")
          self.expectation.fulfill()
        }
      }
      waitForExpectations(timeout: customInterval, handler: nil)
    }
    
    func configuereService() {
      services.showLoading = {
        print("Show loading")
      }
      
      services.hideLoading = {
        print("Show hideloading")
      }
      
    }
    
    

}
