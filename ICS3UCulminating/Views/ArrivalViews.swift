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

#Preview {
    NavigationStack {
        ZStack {
            Color(white: 0.95).ignoresSafeArea()
            ArrivalInfoView(vm: AirguideViewModel())
                .padding()
        }
    }
    .frame(width: 393, height: 852)
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
    @State private var notes: String = ""
    
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
                    
                    TextEditor(text: $notes)
                        .frame(height: 100)
                        .padding(10)
                        .background(Color(white: 0.95))
                        .cornerRadius(12)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Button(action: {
                // In a real app, we'd save the notes/photos to the FlightRecord
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
                }
                Spacer()
                Text("Past Memories")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    vm.currentStep = .intro
                }) {
                    Image(systemName: "house.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
            }
            
            List {
                ForEach(vm.pastJournies) { journey in
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
                        }
                        
                        Spacer()
                        
                        // Placeholder for memory thumbnail
                        Rectangle()
                            .fill(Color(white: 0.9))
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            )
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            .cornerRadius(20)
        }
        .onboardingCard()
    }
}
