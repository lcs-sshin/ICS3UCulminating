import SwiftUI

struct FlightDetailView: View {
    // MARK: - Stored properties
    
    var flight: Flight
    var appModel: AppModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(flight.airline)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text(flight.flightNumber)
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                }
                .padding(.horizontal)
                
                // Route
                HStack {
                    VStack(alignment: .leading) {
                        Text(flight.origin)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Origin")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "airplane")
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(flight.destination)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Destination")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Details Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    DetailBox(label: "Status", value: flight.status, color: .blue)
                    DetailBox(label: "Gate", value: flight.gate, color: .primary)
                    DetailBox(label: "Terminal", value: flight.terminal, color: .primary)
                    DetailBox(label: "Departure", value: formatTime(flight.departureTime), color: .primary)
                }
                .padding(.horizontal)
                
                // Destination Info Link
                NavigationLink(destination: DestinationView(cityName: flight.destination)) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("View Destination Info")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Move to Memory Button
                Button(action: {
                    appModel.moveToMemory(flight)
                    dismiss()
                }) {
                    Text("Move to History")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 40)
            }
            .padding(.vertical)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Functions
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct DetailBox: View {
    var label: String
    var value: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        FlightDetailView(flight: Flight(
            flightNumber: "AC123",
            airline: "Air Canada",
            origin: "YYZ",
            destination: "LHR",
            departureTime: Date(),
            arrivalTime: Date().addingTimeInterval(28800),
            status: "On Time",
            gate: "B22",
            terminal: "1"
        ), appModel: AppModel())
    }
}
