import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode

    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text(episode.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text(episode.episode)
                            .font(.title3)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(20)

          
                    infoRow(title: "Air Date:", value: episode.airDate)

                    infoRow(title: "Created:", value: formattedDate(episode.created))

        


           
                    if let url = URL(string: episode.url) {
                        Link(destination: url) {
                            Text("View Episode API Link")
                                .foregroundColor(.blue)
                                .underline()
                        }
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Episode Details")
    }

    func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .cornerRadius(15)
    }

    func formattedDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: isoDate) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return isoDate
    }
}
