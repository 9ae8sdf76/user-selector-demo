import SwiftUI

@main
struct UserSelectorDemoApp: App {
    @StateObject private var userViewModel = UserViewModel()

    var body: some Scene {
        WindowGroup {
            UserScreen()
                .environmentObject(userViewModel)
        }
    }
}
