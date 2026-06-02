import SwiftUI

// MARK: - IntroView
struct IntroView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "airplane")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Welcome Aboard Airguide")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                vm.currentStep = .login
            }) {
                Text("Start Journey")
                    .fontWeight(.semibold)
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

// MARK: - LoginView
struct LoginView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Spacer()
                Button(action: {
                    vm.currentStep = .intro
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            
            Text("Your Credentials")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Email Address")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter email", text: Binding(get: { vm.email }, set: { vm.email = $0 }))
                    .padding(.bottom, 5)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.blue), alignment: .bottom)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Phone Number")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter phone", text: Binding(get: { vm.phone }, set: { vm.phone = $0 }))
                    .padding(.bottom, 5)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.blue), alignment: .bottom)
            }
            
            Button(action: {
                vm.currentStep = .flightInput
            }) {
                Text("Login")
                    .fontWeight(.semibold)
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

// MARK: - FlightInputView
struct FlightInputView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Flight Selection")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Flight Number")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("ex. OZ4847", text: Binding(get: { vm.flightNumber }, set: { vm.flightNumber = $0 }))
                    .padding(.bottom, 5)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.blue), alignment: .bottom)
            }
            
            HStack(spacing: 15) {
                Button(action: {
                    if vm.flightNumber.isEmpty {
                        vm.flightNumber = "OZ4847"
                    }
                    vm.currentStep = .flightInfo
                }) {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(15)
                }
                
                Button(action: {
                    vm.currentStep = .flightInfo
                }) {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .disabled(vm.flightNumber.isEmpty)
            }
        }
        .onboardingCard()
    }
}

// MARK: - FlightInfoView
struct FlightInfoView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Flight Details")
                .font(.title2)
                .fontWeight(.bold)
            
            Group {
                InfoDetailRow(label: "Flight Number", value: vm.flightNumber.isEmpty ? "OZ4847" : vm.flightNumber)
                InfoDetailRow(label: "Date", value: "June 2, 2026")
                InfoDetailRow(label: "Route", value: "Incheon (ICN) -> Toronto (YYZ)")
                InfoDetailRow(label: "Departure", value: "10:30 AM")
                InfoDetailRow(label: "Terminal", value: "1")
                InfoDetailRow(label: "Gate", value: "22")
                InfoDetailRow(label: "Seat", value: "14A")
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    vm.currentStep = .arrivalInfo
                }) {
                    Text("Arrival >")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .onboardingCard()
    }
}

struct InfoDetailRow: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
        }
    }
}
