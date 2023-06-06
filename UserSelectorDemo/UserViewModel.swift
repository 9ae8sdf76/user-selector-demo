import Combine
import Foundation

final class UserViewModel: ObservableObject {
    @Published var model: User = User()
    @Published var members: [User] = []
}
