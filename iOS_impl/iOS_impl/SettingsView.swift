import SwiftUI

struct SettingsView: View {
    @State var name: String = "Jane Doe"
    @State var email: String = "jane.doe@example.com"
    @State var gender: Gender = .female
    @State var birthdate: Date = Date(timeIntervalSince1970: 891974302)
    @State var emailUpdates = true
    @State var showsDeleteAlert = false

    var body: some View {
        Form {
            Section {
                LabeledContent("Name") {
                    TextField("Name", text: $name)
                }
                LabeledContent("Email") {
                    TextField("Email", text: $email)
                }
                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue.capitalized)
                    }
                }
                DatePicker(
                    "Birthday",
                    selection: $birthdate,
                    displayedComponents: [.date]
                )
            } header: {
                Text("Personal Information")
            }

            Section {
                Toggle("Email Updates", isOn: $emailUpdates)
            } header: {
                Text("Contact")
            }

            Section {
                Button("Delete Account", role: .destructive) {
                    showsDeleteAlert.toggle()
                }
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                }
            }
        }
        .alert("Delete", isPresented: $showsDeleteAlert, actions: {
            Button(role: .destructive) {

            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {

            } label: {
                Text("Cancel")
            }
        }, message: {
            Text("Are you sure you want to delete your account?")
        })
    }
}

#Preview {
    @Previewable @State var selectedTab: Int? = 0

    TabView(selection: $selectedTab) {
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
