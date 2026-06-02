import SwiftUI

struct FlightCard: View {
    // MARK: - Stored properties
    
    var flight: Flight
    
    // MARK: - body
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.airline)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(flight.flightNumber)
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Text(flight.origin)
                    Image(systemName: "arrow.right")
                        .font(.caption)
                    Text(flight.destination)
                }
                .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(flight.status)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.1))
                    .foregroundColor(statusColor)
                    .clipShape(Capsule())
                
                Text(flight.departureTime, style: .time)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    // MARK: - Computed properties
    
    private var statusColor: Color {
        if flight.status == "On Time" {
            return .green
        } else if flight.status == "Delayed" {
            return .orange
        } else if flight.status == "Cancelled" {
            return .red
        } else {
            return .blue
        }
    }
}

#Preview {
    FlightCard(flight: Flight(
        flightNumber: "AC123",
        airline: "Air Canada",
        origin: "YYZ",
        destination: "LHR",
        departureTime: Date(),
        arrivalTime: Date().addingTimeInterval(28800),
        status: "On Time",
        gate: "B22",
        terminal: "1"
    ))
    .padding()
}
