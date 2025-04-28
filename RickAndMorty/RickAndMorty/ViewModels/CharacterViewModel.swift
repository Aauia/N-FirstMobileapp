import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters = [Character]()
    
    func loadCharacters() {
        APIClient.fetchCharacters { result in
            switch result {
            case .success(let characters):
                self.characters = characters
            case .failure(let error):
                print("Error loading characters: \(error)")
            }
        }
    }
}
