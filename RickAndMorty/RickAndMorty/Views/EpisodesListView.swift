import SwiftUI

struct EpisodesListView: View {
    @State private var episodes: [Episode] = []
    @State private var searchQuery: String = ""
    @State private var selectedSeason: String?
    @State private var selectedEpisodeNumber: String?
    @State private var message: String?

    let seasonOptions = ["S01", "S02", "S03", "S04", "S05"]
    let episodeNumberOptions = (1...11).map { String(format: "%02d", $0) }

    var body: some View {
        NavigationView {
            ZStack {
                Image("back") // <- your background image asset
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)


                VStack(spacing: 16) {
                    searchSection

                    if selectedSeason != nil || selectedEpisodeNumber != nil {
                        filtersSummary
                    }

                    if let message = message {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                    }

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(episodes) { episode in
                                NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                                    EpisodeCardView(episode: episode)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding()
            }

            .onAppear(perform: loadInitialData)
        }
    }

    var searchSection: some View {
        VStack(spacing: 10) {
            HStack {
                TextField("Search by Name", text: $searchQuery)
                    .padding()
                    .background(Color(.systemGray5).opacity(0.8))
                    .cornerRadius(10)

                Button(action: searchEpisodes) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterButton(label: "Season", selectedValue: $selectedSeason, options: seasonOptions)
                    FilterButton(label: "Episode", selectedValue: $selectedEpisodeNumber, options: episodeNumberOptions)
                }
                .padding(.horizontal)
            }
        }
    }

    var filtersSummary: some View {
        HStack {
            Text("Filters: ")
                .foregroundColor(.white.opacity(0.8))
            Text("\(selectedSeason ?? "All") \(selectedEpisodeNumber ?? "")")
                .bold()
                .foregroundColor(.white)
        }
    }

    func loadInitialData() {
        searchEpisodes()
    }

    func searchEpisodes() {
        var params = [String: String]()

        if !searchQuery.isEmpty {
            params["name"] = searchQuery
        }

        if let season = selectedSeason, let episodeNumber = selectedEpisodeNumber {
            params["episode"] = "\(season)E\(episodeNumber)"
        } else if let season = selectedSeason {
            params["episode"] = "\(season)"
        } else if let episodeNumber = selectedEpisodeNumber {
            params["episode"] = "S01E\(episodeNumber)"
        }

        APIClient.fetchEpisodesWithParams(params: params) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodes):
                    self.episodes = episodes
                    self.message = episodes.isEmpty ? "No episodes found." : nil
                case .failure(let error):
                    self.message = "Error: \(error.localizedDescription)"
                    self.episodes = []
                }
            }
        }
    }
}
