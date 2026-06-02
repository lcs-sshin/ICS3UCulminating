import SwiftUI

struct MemoryView: View {
    // MARK: - Stored properties
    
    var appModel: AppModel
    
    // MARK: - body
    
    var body: some View {
        List {
            Section(header: Text("Flight History")) {
                if appModel.previousFlights.isEmpty {
                    Text("No previous flights")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(appModel.previousFlights) { flight in
                        FlightCard(flight: flight)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .listRowSeparator(.hidden)
                    }
                }
            }
        }
        .listStyle(.automatic)
        .navigationTitle("Memory")
    }
}

#Preview {
    NavigationStack {
        MemoryView(appModel: AppModel())
    }
}
