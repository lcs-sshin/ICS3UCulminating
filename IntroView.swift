import SwiftUI

struct IntroView: View {
    // MARK: - Stored properties
    
    var onStart: () -> Void
    
    // MARK: - body
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                onStart()
            }) {
                Text("Flight Guide")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.blue)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    IntroView(onStart: {})
}
