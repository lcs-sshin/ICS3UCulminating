import SwiftUI

// MARK: - ArrivalInfoView
struct ArrivalInfoView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Button(action: {
                    vm.currentStep = .flightInfo
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
                // Empty to balance the left button
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding(.bottom, -20)
            
            Text("Welcome to Toronto")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "clock.fill")
                    Text("Local Time: 14:30")
                }
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Terminal: 3")
                }
            }
            .font(.headline)
            .foregroundColor(.black)
            
            Button(action: {
                vm.currentStep = .busInfo
            }) {
                HStack {
                    Image(systemName: "bus")
                    Text("Take public transport")
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(15)
            }
            
            Button(action: {
                vm.currentStep = .taxiInfo
            }) {
                HStack {
                    Image(systemName: "car.fill")
                    Text("Take a taxi / Uber")
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(15)
            }
            
            Spacer()
            
            Button(action: {
                vm.addNewJourney()
                vm.currentStep = .congratulations
            }) {
                Text("Finish Your Journey")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
            }
        }
        .frame(maxHeight: .infinity)
        .onboardingCard()
    }
}

// MARK: - BusInfoView
struct BusInfoView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    vm.currentStep = .arrivalInfo
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Bus Schedule")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                // Empty view to balance the back button
                Image(systemName: "chevron.left").opacity(0)
            }
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(vm.busList) { bus in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(bus.destination)
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            HStack {
                                ForEach(bus.busNumbers, id: \.self) { number in
                                    Text(number)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(5)
                                }
                            }
                            
                            HStack {
                                Text("Next arrivals:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                ForEach(bus.arrivalTimes, id: \.self) { time in
                                    Text("\(time)m")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(white: 0.95))
                        .cornerRadius(15)
                    }
                }
            }
        }
        .onboardingCard()
    }
}

// MARK: - TaxiInfoView
struct TaxiInfoView: View {
    var vm: AirguideViewModel
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Button(action: {
                    vm.currentStep = .arrivalInfo
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Taxi & Rideshare")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Need a ride?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Download a rideshare app or head to the taxi stand outside Terminal 3.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 15) {
                // Uber Button
                Button(action: {
                    if let url = URL(string: "https://apps.apple.com/app/uber/id364892933") {
                        openURL(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.down.circle.fill")
                        Text("Download Uber")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(15)
                }
                
                // Lyft Button
                Button(action: {
                    if let url = URL(string: "https://apps.apple.com/app/lyft/id529392153") {
                        openURL(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.down.circle.fill")
                        Text("Download Lyft")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(15)
                }
            }
            
            Spacer()
            
            Button(action: {
                vm.addNewJourney()
                vm.currentStep = .congratulations
            }) {
                Text("I've found my ride")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
            }
        }
        .onboardingCard()
    }
}

// MARK: - CongratulationsView
struct CongratulationsView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Journey Complete")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("Your flight data has been saved to your memories.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                Button(action: {
                    vm.currentStep = .arrivalInfo
                }) {
                    Text("Go Back")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(white: 0.92))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        )
                }
                
                Button(action: {
                    vm.currentStep = .logFlight
                }) {
                    Text("Log Flight >")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    vm.resetFlightEntry()
                }) {
                    Text("Enter New Flight")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    vm.currentStep = .pastJournies
                }) {
                    Text("View previous flights >")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .onboardingCard()
    }
}

// MARK: - LogFlightView
struct LogFlightView: View {
    @Bindable var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button(action: {
                    vm.currentStep = .congratulations
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Log Memories")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Capture Your Trip")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Add photos and notes about your flight \(vm.flightNumber.isEmpty ? "OZ4847" : vm.flightNumber).")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Photo Placeholder Area
                Button(action: {
                    // Action for adding pictures
                }) {
                    VStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                        Text("Add Pictures")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(20)
                }
                
                // Notes Area
                VStack(alignment: .leading, spacing: 8) {
                    Text("How was the travel?")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    
                    TextEditor(text: $vm.currentFlightNotes)
                        .frame(height: 100)
                        .padding(10)
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Button(action: {
                vm.addNewJourney()
                vm.currentStep = .pastJournies
            }) {
                Text("Save to Memories")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
        }
        .onboardingCard()
    }
}

// MARK: - PastJourniesView
struct PastJourniesView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    vm.currentStep = .congratulations
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Past Memories")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                // Balanced spacer for the layout, home button is handled by wrapper
                Image(systemName: "house.fill").opacity(0)
            }
            
            List {
                ForEach(vm.pastJournies) { journey in
                    Button(action: {
                        vm.viewMemory(journey)
                    }) {
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(journey.route)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("\(journey.date) • \(journey.flightNumber)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("Terminal \(journey.terminal)")
                                    .font(.caption2)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(4)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            // Placeholder for memory thumbnail
                            Rectangle()
                                .fill(Color(white: 0.98))
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                    .listRowBackground(Color.white)
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onboardingCard()
    }
}

// MARK: - MemoryDetailView
struct MemoryDetailView: View {
    @Bindable var vm: AirguideViewModel
    @State private var isEditing: Bool = false
    @State private var editableNotes: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            if let journey = vm.selectedJourney {
                HStack {
                    Button(action: {
                        if isEditing {
                            isEditing = false
                        } else {
                            vm.currentStep = .pastJournies
                        }
                    }) {
                        Image(systemName: isEditing ? "xmark" : "chevron.left")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text(isEditing ? "Edit Journal" : "Journey Details")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    
                    Button(action: {
                        if isEditing {
                            vm.updateMemoryNotes(id: journey.id, newNotes: editableNotes)
                            isEditing = false
                        } else {
                            editableNotes = journey.notes
                            isEditing = true
                        }
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 5) {
                            Text(journey.route)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Text("\(journey.date) • Flight \(journey.flightNumber)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        if !isEditing {
                            // Image Placeholder
                            Rectangle()
                                .fill(Color.blue.opacity(0.05))
                                .frame(height: 200)
                                .cornerRadius(20)
                                .overlay(
                                    VStack(spacing: 10) {
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .font(.system(size: 40))
                                        Text("Your Trip Photos")
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundColor(.blue.opacity(0.3))
                                )
                            
                            // Quick Stats
                            HStack {
                                DetailMiniBox(label: "Terminal", value: journey.terminal)
                                DetailMiniBox(label: "Status", value: journey.status, valueColor: journey.status == "On Time" ? .green : .red)
                            }
                        }
                        
                        // Travel Notes
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Travel Journal")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            if isEditing {
                                TextEditor(text: $editableNotes)
                                    .frame(height: 200)
                                    .padding(10)
                                    .background(Color(white: 0.98))
                                    .cornerRadius(15)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                                    )
                            } else {
                                Text(journey.notes.isEmpty ? "No notes recorded for this journey." : journey.notes)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(white: 0.98))
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            } else {
                Text("Select a journey to view details")
                    .foregroundColor(.gray)
            }
        }
        .onboardingCard()
    }
}

struct DetailMiniBox: View {
    var label: String
    var value: String
    var valueColor: Color = .black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(white: 0.98))
        .cornerRadius(15)
    }
}

#Preview {
    NavigationStack {
        ZStack {
            Color.white.ignoresSafeArea()
            ArrivalInfoView(vm: AirguideViewModel())
                .padding()
        }
    }
    .frame(width: 393, height: 852)
}
