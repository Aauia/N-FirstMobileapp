import SwiftUI

struct LocationListView: View {
    @State private var locations: [Location] = []
    @State private var searchQuery: String = ""
    @State private var selectedType: String?
    @State private var selectedDimension: String?
    @State private var message: String?

    let typeOptions = ["Planet", "Fantasy town", "Resort", "TV", "Space station", "Cluster", "Microverse", "Dream"]
    let dimensionOptions = ["Dimension 5-126", "unknown", "Dimension C-137", "Post-Apocalyptic Dimension", "Cronenberg Dimension", "Replacement Dimension", "Fantasy Dimension"]

    var body: some View {
        NavigationView {
            ZStack {
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
     
    

                VStack(spacing: 16) {
                    HStack {
                        TextField("Search by Name", text: $searchQuery)
                            .padding()
                            .background(Color(.systemGray6).opacity(0.8))
                            .cornerRadius(10)
                        
                        Button(action: searchLocations) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterButton(label: "Type", selectedValue: $selectedType, options: typeOptions)
                            FilterButton(label: "Dimension", selectedValue: $selectedDimension, options: dimensionOptions)
                        }
                        .padding(.horizontal)
                    }

              
                    if let message = message {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
        
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(locations) { location in
                                NavigationLink(destination: LocationDetailsView(location: location)) {
                                    LocationCard(location: location)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.top)
            }
      
            .onAppear(perform: loadInitialData)
        }
    }

    func loadInitialData() {
        searchLocations()
    }

    func searchLocations() {
        var params = [String: String]()

        if !searchQuery.isEmpty {
            params["name"] = searchQuery
        }
        if let type = selectedType, type != "All" {
            params["type"] = type
        }
        if let dimension = selectedDimension, dimension != "All" {
            params["dimension"] = dimension
        }

        APIClient.fetchLocationsWithParams(params: params) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self.locations = locations
                    self.message = locations.isEmpty ? "No locations found." : nil
                case .failure(let error):
                    self.message = "Error: \(error.localizedDescription)"
                    self.locations = []
                }
            }
        }
    }
}



struct LocationCard: View {
    let location: Location

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backgroundForType(location.type)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .clipped()
                .cornerRadius(20)
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                           startPoint: .bottom,
                           endPoint: .top)
                .cornerRadius(20)

            VStack(alignment: .leading, spacing: 6) {
                Text(location.name)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 4)

                Text(location.type)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(location.dimension)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))

                Text("\(location.residents.count) resident(s)")
                    .font(.caption)
                    .foregroundColor(.green)
            }
            .padding()
        }
        .padding(.horizontal)
    }

    func backgroundForType(_ type: String) -> Image {
        switch type.lowercased() {
        case "planet":
            return Image("planetBackground")
        case "tv":
            return Image("tvBackground")
        case "resort":
            return Image("resortBackground")
        case "space station":
            return Image("spaceStationBackground")
        case "dream":
            return Image("dreamBackground")
        default:
            return Image("dreamBackground")
        }
    }
}

// MARK: - FilterButton (reusable)

