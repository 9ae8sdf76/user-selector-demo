import SwiftUI
import PopupView

struct UserScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedMember: User

    @State private var members: [User] = []
    @State private var selectedRole: String = ""

    @FocusState private var roleFocused: Bool

    init() {
        self.selectedMember = userViewModel.model
    }

    var body: some View {
        VStack {
            let items = Array(repeating: GridItem(), count: 4)

            LazyVGrid(columns: items, alignment: .center, spacing: 10) {
                Button(action: {
                    members.append(User())
                    if let member = members.last {
                        selectedMember = member
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .frame(minHeight: 75, alignment: .center)

                Circle()
                    .fill(.blue)
                    .foregroundColor(.black)
                    .opacity(selectedMember == userViewModel.model ? 1 : 0.65)
                    .onTapGesture { selectedMember = userViewModel.model }

                ForEach (members, id: \.self) { member in
                    Circle()
                        .fill(.blue)
                        .foregroundColor(.gray)
                        .opacity(selectedMember == member ? 1 : 0.65)
                        .onTapGesture { selectedMember = member }
                }
            }

            Button(action: {
                if let idx = members.firstIndex(of: selectedMember) {
                    members.remove(at: idx)
                    selectedMember = idx > 0 ? members[idx - 1] : userViewModel.model
                }
            }) {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.red)
                    .padding([.top, .bottom, .leading])

                Text("Delete")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .padding([.top, .bottom, .trailing])
            }
            .opacity(selectedMember != userViewModel.model ? 1 : 0)
            .disabled(selectedMember == userViewModel.model)

            Text("Role")
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("", text: $selectedMember.role)
                .padding()
                .background(.gray.opacity(0.25))
                .foregroundColor(.black)
                .focused($roleFocused)
        }
        .padding(.horizontal, 64)
        .onChange(of: roleFocused) { _ in
            if roleFocused {
                RolePopup(role: $selectedMember.role)
                    .showAndReplace()
            }
        }
    }
}

extension UserScreen {
    func makeCircle(for user: User) -> some View {
        Circle()
            .foregroundColor(.accentColor)
            .opacity(selectedMember == user ? 1 : 0.65)
            .onTapGesture { selectedMember = user }
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    struct Preview: View {
        @StateObject private var userViewModel = UserViewModel()

        var body: some View {
            UserScreen()
                .implementPopupView()
                .environmentObject(userViewModel)
        }
    }
}
