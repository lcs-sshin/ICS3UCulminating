import SwiftUI

struct ContentView: View {
    // MARK: - Stored properties
    
    @State private var appModel = AppModel()
    @State private var showIntro = true
    
    // MARK: - body
    
    var body: some View {
        Group {
            if showIntro {
                IntroView {
                    showIntro = false
                }
            } else {
                NavigationStack {
                    HomeView(appModel: appModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
