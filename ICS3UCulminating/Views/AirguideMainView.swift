import SwiftUI

struct AirguideMainView: View {
    // MARK: - Stored properties
    @State private var vm = AirguideViewModel()
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            ZStack {
                // Application Background
                Color(white: 0.95)
                    .ignoresSafeArea()
                
                // Dynamic View Switching
                VStack {
                    switch vm.currentStep {
                    case .intro:
                        IntroView(vm: vm)
                    case .login:
                        LoginView(vm: vm)
                    case .flightInput:
                        FlightInputView(vm: vm)
                    case .flightInfo:
                        FlightInfoView(vm: vm)
                    case .arrivalInfo:
                        ArrivalInfoView(vm: vm)
                    case .busInfo:
                        BusInfoView(vm: vm)
                    case .taxiInfo:
                        TaxiInfoView(vm: vm)
                    case .congratulations:
                        CongratulationsView(vm: vm)
                    case .logFlight:
                        LogFlightView(vm: vm)
                    case .pastJournies:
                        PastJourniesView(vm: vm)
                    }
                }
                .withHomeButton(vm: vm)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.spring(), value: vm.currentStep)
            }
        }
    }
}

// MARK: - Reusable Card Modifier
struct OnboardingCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(30)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func onboardingCard() -> some View {
        self.modifier(OnboardingCardStyle())
    }
 
    func withHomeButton(vm: AirguideViewModel) -> some View {
        ZStack(alignment: .topTrailing) {
            self
            
            if vm.currentStep != .intro {
                Button(action: {
                    vm.currentStep = .intro
                }) {
                    Image(systemName: "house.fill")
                        .font(.title3)
                        .foregroundColor(Color(white: 0.3)) // Dark Gray
                        .padding(25)
                }
            }
        }
    }
}

#Preview {
    AirguideMainView()
        .frame(width: 350, height: 650)
}
