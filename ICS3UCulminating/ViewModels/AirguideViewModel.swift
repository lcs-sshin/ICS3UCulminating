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
    
    func resetFlightEntry() {
        flightNumber = ""
        currentFlightNotes = ""
        currentStep = .flightInput
    }
    
    func viewMemory(_ journey: FlightRecord) {
        selectedJourney = journey
        currentStep = .memoryDetail
    }
}
