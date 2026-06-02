import Foundation

struct Flight: Identifiable {
    var id: UUID = UUID()
    var flightNumber: String
    var airline: String
    var origin: String
    var destination: String
    var departureTime: Date
    var arrivalTime: Date
    var status: String
    var gate: String
    var terminal: String
}
