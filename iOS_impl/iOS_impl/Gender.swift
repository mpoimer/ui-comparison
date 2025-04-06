enum Gender: String, Identifiable, CaseIterable, Codable {
    case male
    case female
    case other

    var id: Self { self }
}
