import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations = [Location]()
    
    func loadLocations() {
        APIClient.fetchLocations { result in
            switch result {
            case .success(let locations):
                self.locations = locations
            case .failure(let error):
                print("Error loading locations: \(error)")
            }
        }
    }
}
