import Foundation
import Observation

@Observable
class AppModel {
    // MARK: - Stored properties
    
    var activeFlights: [Flight] = []
    var previousFlights: [Flight] = []
    
    // MARK: - Initializer
    
    init() {
        // Add some mock data for development
        let mockFlight1 = Flight(
            flightNumber: "AC123",
            airline: "Air Canada",
            origin: "YYZ",
            destination: "LHR",
            departureTime: Date(),
            arrivalTime: Date().addingTimeInterval(28800),
            status: "On Time",
            gate: "B22",
            terminal: "1"
        )
        
        let mockFlight2 = Flight(
            flightNumber: "WS456",
            airline: "WestJet",
            origin: "YYC",
            destination: "JFK",
            departureTime: Date().addingTimeInterval(-86400),
            arrivalTime: Date().addingTimeInterval(-70000),
            status: "Arrived",
            gate: "C10",
            terminal: "3"
        )
        
        activeFlights.append(mockFlight1)
        previousFlights.append(mockFlight2)
    }
    
    // MARK: - Functions
    
    func addFlight(_ flight: Flight) {
        activeFlights.append(flight)
    }
    
    func moveToMemory(_ flight: Flight) {
        // We need to find the index to remove it from activeFlights
        var foundIndex: Int? = nil
        for index in 0..<activeFlights.count {
            if activeFlights[index].id == flight.id {
                foundIndex = index
                break
            }
        }
        
        if let index = foundIndex {
            let removedFlight = activeFlights.remove(at: index)
            previousFlights.append(removedFlight)
        }
    }
}
