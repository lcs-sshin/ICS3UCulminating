import SwiftUI

struct HomeView: View {
    // MARK: - Stored properties
    
    var appModel: AppModel
    @State private var showingAddFlight = false
    
    // MARK: - body
    
    var body: some View {
        List {
            Section(header: Text("Active Flights")) {
                if appModel.activeFlights.isEmpty {
                    Text("No active flights")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(appModel.activeFlights) { flight in
                        NavigationLink(destination: FlightDetailView(flight: flight, appModel: appModel)) {
                            FlightCard(flight: flight)
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }
        .listStyle(.automatic)
        .navigationTitle("My Flights")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showingAddFlight = true
                }) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigation) {
                NavigationLink(destination: MemoryView(appModel: appModel)) {
                    Image(systemName: "clock.arrow.circlepath")
                }
            }
        }
        .sheet(isPresented: $showingAddFlight) {
            AddFlightView(appModel: appModel)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(appModel: AppModel())
    }
}
