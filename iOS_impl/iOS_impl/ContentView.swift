import SwiftUI

struct ContentView: View {
    @State var selection: Int? = 1

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: 0) {
                Text("Home")
            }
            Tab("Settings", systemImage: "gear", value: 1) {
                NavigationStack {
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
