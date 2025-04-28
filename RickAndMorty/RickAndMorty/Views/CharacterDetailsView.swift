import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    }

                    Text(character.name)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    Text(character.status)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(statusColor(for: character.status))
                        .clipShape(Capsule())

                    VStack(alignment: .leading, spacing: 12) {
                        DetailRow(title: "Species", value: character.species)
                        if !character.type.isEmpty {
                            DetailRow(title: "Type", value: character.type)
                        }
                        DetailRow(title: "Gender", value: character.gender)
                        
                        // Locations
                        Divider().background(Color.white)
                        Text("Locations")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        DetailRow(title: "Origin", value: character.origin.name)
                        DetailRow(title: "Last Known Location", value: character.location.name)

                        // Episodes
                        Divider().background(Color.white)
                        Text("Episodes")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Text("Appeared in \(character.episode.count) episode(s)")
                            .foregroundColor(.white)

                        // Created At
                        Divider().background(Color.white)
                        Text("Created")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                        Text(formatDate(character.created))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Helper to choose color based on status
    func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
    
    // Helper to format the created date nicely
    func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: isoDate) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return isoDate
    }
}

// Reusable row
struct DetailRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.white)
        }
        .font(.body)
    }
}
