import Foundation

// MARK: - FlightRecord Model
struct FlightRecord: Identifiable {
    var id: UUID = UUID()
    var route: String
    var date: String
    var flightNumber: String
    var terminal: String
    var status: String = "On Time" // Added status property
    var frame: String = ""
}

// MARK: - BusInfo Model
struct BusInfo: Identifiable {
    var id: UUID = UUID()
    var destination: String
    var busNumbers: [String]
    var arrivalTimes: [Int]
}
