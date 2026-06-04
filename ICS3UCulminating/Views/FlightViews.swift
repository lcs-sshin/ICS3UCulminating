import SwiftUI

// MARK: - IntroView
struct IntroView: View {
    var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "airplane")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            VStack(spacing: 5) {
                Text("Welcome to")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text("Airguide")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            .multilineTextAlignment(.center)
            
            Button(action: {
                vm.currentStep = .login
            }) {
                Text("Start Journey")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(white: 0.95))
                    .cornerRadius(15)
            }
        }
        .onboardingCard()
    }
}

#Preview {
    NavigationStack {
        ZStack {
            Color(white: 0.95).ignoresSafeArea()
            IntroView(vm: AirguideViewModel())
                .padding()
        }
    }
    .frame(width: 393, height: 852)
}

// MARK: - LoginView
struct LoginView: View {
    @Bindable var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Button(action: {
                    vm.currentStep = .intro
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            Text("Login information")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Email Address")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter email", text: $vm.email)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.blue), alignment: .bottom)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Phone Number")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter phone", text: $vm.phone)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
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
    @Bindable var vm: AirguideViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Flight Selection")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Flight Number")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("ex. OZ4847", text: $vm.flightNumber)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.blue), alignment: .bottom)
            }
            
            HStack(spacing: 15) {
                Button(action: {
                    if vm.flightNumber.isEmpty {
                        vm.flightNumber = "OZ4847"
                    }
                    vm.currentStep = .congratulations
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
                    if vm.flightNumber.isEmpty {
                        vm.flightNumber = "OZ4847"
                    }
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
                .foregroundColor(.black)
            
            Group {
                InfoDetailRow(label: "Flight Number", value: vm.flightNumber.isEmpty ? "OZ4847" : vm.flightNumber)
                InfoDetailRow(label: "Date", value: "June 11, 2026")
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
                .foregroundColor(.black)
        }
    }
}
