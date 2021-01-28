//
//  ItemBeacon.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/28/21.
//

import Foundation
import CoreLocation
class Item : NSObject{
    let name : String
    let uuid : UUID
    let majorValue : CLBeaconMajorValue
    let minorValue : CLBeaconMinorValue
    var beacon : CLBeacon?
    init(name : String, uuid : UUID, major : Int, minor : Int) {
        self.name = name
        self.uuid = uuid
        self.majorValue = CLBeaconMajorValue(major)
        self.minorValue = CLBeaconMinorValue(minor)
    }
    func locationString() -> String {
        guard let beacon = beacon else { return "Location: Unknown" }
        let proximity = nameForProximity(beacon.proximity)
        let location = "location: \(proximity)"
        return location
    }
    
    func nameForProximity(_ proximity: CLProximity) -> String {
        switch proximity {
        case .far:
            return "Far"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        default:
            return "Unknown"
        }
    }
    
}
