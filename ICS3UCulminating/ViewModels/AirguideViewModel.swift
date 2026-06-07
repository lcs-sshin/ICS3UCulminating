import SwiftUI
import Observation

@Observable
class AirguideViewModel {
    // MARK: - AppStep Navigation
    enum AppStep {
        case intro
        case login
        case flightInput
        case flightInfo
        case arrivalInfo
        case busInfo
        case taxiInfo
        case congratulations
        case logFlight
        case pastJournies
        case memoryDetail // New step for viewing specific journey details
    }
    
    // MARK: - Stored properties
    var currentStep: AppStep = .intro
    
    // User Input
    var email: String = ""
    var phone: String = ""
    var flightNumber: String = ""
    var currentFlightStatus: String = "On Time"
    var currentFlightNotes: String = "" // For logging memories
    
    // MARK: - Computed properties
    var flightDetails: [FlightDetailItem] {
        var items: [FlightDetailItem] = []
        
        items.append(FlightDetailItem(label: "Flight Number", value: flightNumber.isEmpty ? "OZ4847" : flightNumber))
        items.append(FlightDetailItem(label: "Date", value: "June 11, 2026"))
        items.append(FlightDetailItem(label: "Route", value: "Incheon (ICN) -> Toronto (YYZ)"))
        items.append(FlightDetailItem(label: "Departure", value: "10:30 AM"))
        items.append(FlightDetailItem(label: "Terminal", value: "1"))
        items.append(FlightDetailItem(label: "Gate", value: "22"))
        items.append(FlightDetailItem(label: "Seat", value: "14A"))
        items.append(FlightDetailItem(label: "Delayed Status", value: currentFlightStatus, color: currentFlightStatus == "On Time" ? .green : .red))
        
        return items
    }
    
    // Dynamic Data
    var pastJournies: [FlightRecord] = []
    var busList: [BusInfo] = []
    var selectedJourney: FlightRecord? // To track which memory is being viewed
    
    // MARK: - Initializer
    init() {
        setupInitialData()
    }
    
    // MARK: - Functions
    private func setupInitialData() {
        // Populate Bus List using explicit data
        let hongdaeBus = BusInfo(
            destination: "Hongdae",
            busNumbers: ["2020", "2222"],
            arrivalTimes: [20, 10]
        )
        let myeongdongBus = BusInfo(
            destination: "Myung-dong",
            busNumbers: ["6001", "6015"],
            arrivalTimes: [15, 25]
        )
        let gangnamBus = BusInfo(
            destination: "Gangnam",
            busNumbers: ["6009", "6020"],
            arrivalTimes: [12, 18]
        )
        
        busList.append(hongdaeBus)
        busList.append(myeongdongBus)
        busList.append(gangnamBus)
        
        // Populate Past Journeys
        let journey1 = FlightRecord(
            route: "Incheon -> Toronto",
            date: "Jan 4th 2026",
            flightNumber: "OZ4384",
            terminal: "3",
            status: "On Time",
            notes: "Smooth flight, great service!"
        )
        let journey2 = FlightRecord(
            route: "Incheon -> Shanghai",
            date: "Dec 15th 2025",
            flightNumber: "MU5052",
            terminal: "1",
            status: "On Time",
            notes: "Quick trip for business."
        )
        
        pastJournies.append(journey1)
        pastJournies.append(journey2)
    }
    
    func addNewJourney() {
        let actualFlightNumber: String
        if flightNumber.isEmpty {
            actualFlightNumber = "OZ4847"
        } else {
            actualFlightNumber = flightNumber
        }
        
        let newRecord = FlightRecord(
            route: "Toronto -> Incheon",
            date: "Current Date",
            flightNumber: actualFlightNumber,
            terminal: "2",
            status: currentFlightStatus,
            notes: currentFlightNotes // Save the captured notes
        )
        
        // Insert at the beginning of the array as requested
        pastJournies.insert(newRecord, at: 0)
        
        // Reset notes for the next trip
        currentFlightNotes = ""
    }
    
    func manuallyAddMemory(route: String, date: String, flightNumber: String, terminal: String, notes: String) {
        let newRecord = FlightRecord(
            route: route,
            date: date,
            flightNumber: flightNumber,
            terminal: terminal,
            status: "On Time",
            notes: notes
        )
        pastJournies.insert(newRecord, at: 0)
    }
    
    func resetFlightEntry() {
        flightNumber = ""
        currentFlightNotes = ""
        currentStep = .flightInput
    }
    
    func viewMemory(_ journey: FlightRecord) {
        selectedJourney = journey
        currentStep = .memoryDetail
    }
    
    func updateMemoryNotes(id: UUID, newNotes: String) {
        for index in 0..<pastJournies.count {
            if pastJournies[index].id == id {
                pastJournies[index].notes = newNotes
                // Also update the selected journey if it's currently being viewed
                if selectedJourney?.id == id {
                    selectedJourney?.notes = newNotes
                }
                break
            }
        }
    }
}
