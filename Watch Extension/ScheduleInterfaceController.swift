//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by MacKentoch on 04/09/2016.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

  @IBOutlet var flightsTable: WKInterfaceTable!
  
  var flights = Flight.allFlights()
  var selectedIndex = 0
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // set table row number:
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    // bind rows:
    for index in 0..<flightsTable.numberOfRows {
      if let controller = flightsTable.rowControllerAtIndex(index) as? FlightRowController {
        controller.flight = flights[index]
      }
    }
  }
  
  override func didAppear() {
    super.didAppear()
    // 1
    if flights[self.selectedIndex].checkedIn, let controller = flightsTable.rowControllerAtIndex(self.selectedIndex) as? FlightRowController {
      // 2
      animateWithDuration(
        0.35,
        animations: {
          () -> Void in
            // 3
            controller.updateForCheckIn()
        }
      )
    }
  }
  
  override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
    let flight = flights[rowIndex]
    self.selectedIndex = rowIndex

    let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
    presentControllerWithNames(controllers, contexts:[flight, flight])
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
