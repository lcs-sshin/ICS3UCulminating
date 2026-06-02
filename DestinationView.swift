import SwiftUI

struct DestinationView: View {
    // MARK: - Stored properties
    
    var cityName: String
    
    // MARK: - body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(cityName)
                    .font(.system(size: 64, weight: .bold))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(icon: "cloud.sun.fill", label: "Weather", value: "24°C, Sunny")
                    InfoRow(icon: "clock.fill", label: "Local Time", value: "14:30")
                    InfoRow(icon: "info.bubble.fill", label: "Currency", value: "Local Currency")
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("About")
                        .font(.headline)
                    Text("This destination is known for its beautiful architecture and vibrant culture. Safe travels!")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle("Destination")
    }
}

struct InfoRow: View {
    var icon: String
    var label: String
    var value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DestinationView(cityName: "LHR")
    }
}
