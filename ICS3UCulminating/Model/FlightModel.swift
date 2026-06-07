import Foundation
import SwiftUI

// MARK: - FlightRecord Model
struct FlightRecord: Identifiable {
    var id: UUID = UUID()
    var route: String
    var date: String
    var flightNumber: String
    var terminal: String
    var status: String = "On Time"
    var notes: String = "" // Added to store travel notes
    var frame: String = ""
}

// MARK: - BusInfo Model
struct BusInfo: Identifiable {
    var id: UUID = UUID()
    var destination: String
    var busNumbers: [String]
    var arrivalTimes: [Int]
}

// MARK: - Helper for Array-driven UI
struct FlightDetailItem: Identifiable {
    var id: UUID = UUID()
    var label: String
    var value: String
    var color: Color = .black
}
