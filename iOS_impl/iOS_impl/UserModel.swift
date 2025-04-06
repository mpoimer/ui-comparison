import Foundation

struct UserModel: Codable {
    let id: Int
    let name: String
    let email: String
    let gender: Gender
    let birthdate: Date
    let emailUpdates: Bool
}
