import Foundation

// MARK: - Page

struct Page: Codable {
    let uid, title: String
    let video: Video?
    let darkModeContent: String?
    let lightModeContent: String?

    enum CodingKeys: String, CodingKey {
    case uid, title, video
    case darkModeContent = "dark_mode_content"
    case lightModeContent = "light_mode_content"
    }
}
