import SwiftUI

struct LocationDetailsView: View {
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
         
                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
        
                VStack(alignment: .leading, spacing: 8) {
                    Text("Type: \(location.type)")
                        .font(.headline)
                    Text("Dimension: \(location.dimension)")
                        .font(.headline)
                    Text("Residents: \(location.residents.count)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
      
                Text("Residents")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                    ForEach(location.residents, id: \.self) { residentURL in
                        if let id = extractID(from: residentURL) {
                            VStack {
                                AsyncImage(url: URL(string: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 70, height: 70)
                                }
                                
                                Text("#\(id)")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(Styles.backgroundStyle())
        .navigationTitle(location.name)
    }
    

    func extractID(from url: String) -> String? {
        guard let lastComponent = url.split(separator: "/").last else { return nil }
        return String(lastComponent)
    }
}
