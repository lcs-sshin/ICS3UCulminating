import SwiftUI

struct IntroView: View {
    // MARK: - Stored properties
    
    var onStart: () -> Void
    
    // MARK: - body
    
    var body: some View {
        ZStack {
            // Background color for the whole screen
            Color.white
                .ignoresSafeArea()
            
            // Decorative elements to make it look less "floating"
            VStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 400, height: 400)
                    .offset(x: -150, y: -200)
                Spacer()
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 200, height: 300)
                    .offset(x: 100, y: 150)
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "airplane.departure")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text("Flight Assistant")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Your personal sky guide")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                Button(action: {
                    onStart()
                }) {
                    Text("Flight Guide")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 60)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                        .shadow(radius: 10)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

#Preview {
    IntroView(onStart: {})
}
