import SwiftUI
import PopupView

struct RolePopup: CentrePopup {
    @Binding var role: String

    let roles: [String] = ["Father", "Mother", "Son", "Daughter", "Roommate", "Partner"]

    func createContent() -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Select Role")
                    .font(.title.weight(.bold))

                Rectangle()
                    .fill(.white)
                    .frame(maxWidth: .infinity, maxHeight: 2)
            }
            .padding()

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 24) {
                ForEach (roles, id: \.self) { role in
                    Button(action: {
                        self.role = role
                        dismiss()
                    }) {
                        HStack {
                            if self.role == role {
                                Image(systemName: "checkmark.circle")
                                    .background {
                                        Circle()
                                            .fill(.green)
                                    }
                                    .foregroundColor(.black)
                            } else {
                                Image(systemName: "circle")
                            }

                            Text(role)
                                .font(.body.weight(.bold))
                        }
                    }
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 48)
            .padding(.horizontal, 48)
        }
        .foregroundColor(.white)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray)

            RoundedRectangle(cornerRadius: 12)
                .stroke(.white)
        }
    }

    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
            .backgroundColour(.clear)
            .horizontalPadding(28)
            .tapOutsideToDismiss(true)
    }
}
