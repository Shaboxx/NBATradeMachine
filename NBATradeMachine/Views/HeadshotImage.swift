import SwiftUI

struct HeadshotImage: View {
    let slug: String
    var size: CGFloat = 44

    @State private var url: URL?

    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholder
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(.secondary.opacity(0.2), lineWidth: 0.5))
        .task(id: slug) {
            url = await StorageService.shared.headshotURL(for: slug)
        }
    }

    private var placeholder: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .padding(size * 0.2)
            .foregroundStyle(.secondary)
            .background(Color.secondary.opacity(0.1))
    }
}
