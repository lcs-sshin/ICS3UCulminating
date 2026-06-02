import SwiftUI

struct AddFlightView: View {
    // MARK: - Stored properties
    
    var appModel: AppModel
    @Environment(\.dismiss) var dismiss
    
    @State private var flightNumber = ""
    @State private var airline = ""
    @State private var origin = ""
    @State private var destination = ""
    @State private var departureTime = Date()
    @State private var arrivalTime = Date().addingTimeInterval(3600)
    
    // MARK: - body
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Flight Information")) {
                    TextField("Flight Number (ex. AC123)", text: $flightNumber)
                    TextField("Airline", text: $airline)
                }
                
                Section(header: Text("Route")) {
                    TextField("Origin (Airport Code)", text: $origin)
                    TextField("Destination (Airport Code)", text: $destination)
                }
                
                Section(header: Text("Schedule")) {
                    DatePicker("Departure", selection: $departureTime)
                    DatePicker("Arrival", selection: $arrivalTime)
                }
            }
            .navigationTitle("Add Flight")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveFlight()
                    }
                    .disabled(flightNumber.isEmpty || airline.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    private func saveFlight() {
        let newFlight = Flight(
            flightNumber: flightNumber,
            airline: airline,
            origin: origin,
            destination: destination,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            status: "On Time",
            gate: "TBD",
            terminal: "TBD"
        )
        appModel.addFlight(newFlight)
        dismiss()
    }
}

#Preview {
    AddFlightView(appModel: AppModel())
}
