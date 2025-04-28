import Foundation

class EpisodeViewModel: ObservableObject {
    @Published var episodes = [Episode]()
    
    func loadEpisodes() {
        APIClient.fetchEpisodes { result in
            switch result {
            case .success(let episodes):
                self.episodes = episodes
            case .failure(let error):
                print("Error loading episodes: \(error)")
            }
        }
    }
}
