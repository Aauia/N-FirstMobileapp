import SwiftUI

struct CharacterListView: View {
    @State private var characters = [Character]()
    @State private var searchQuery: String = ""
    @State private var selectedStatus: String? = nil
    @State private var selectedSpecies: String? = nil
    @State private var selectedType: String? = nil
    @State private var selectedGender: String? = nil
    @State private var message: String? = nil

    let speciesOptions = ["All", "Human", "Alien", "Robot", "Other"]
    let statusOptions = ["All", "Alive", "Dead", "Unknown"]
    let genderOptions = ["All", "Male", "Female", "Unknown"]
    let typeOptions = ["Parasite", "Human with ants in his eyes", "Superhuman (Ghost trains summoner)", "Human with antennae", "Genetic experiment"]
    @State private var availableTypes = [String]()

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
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        
                        Button(action: searchCharacters) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterButton(label: "Status", selectedValue: $selectedStatus, options: statusOptions)
                            FilterButton(label: "Species", selectedValue: $selectedSpecies, options: speciesOptions)
                            FilterButton(label: "Type", selectedValue: $selectedType, options: typeOptions)
                            FilterButton(label: "Gender", selectedValue: $selectedGender, options: genderOptions)
                        }
                        .padding(.horizontal)
                    }
                    

                    if selectedStatus != nil || selectedSpecies != nil || selectedType != nil || selectedGender != nil {
                        Text("Filters: \(selectedStatus ?? "All"), \(selectedSpecies ?? "All"), \(selectedType ?? "All"), \(selectedGender ?? "All")")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
            
                    if let message = message {
                        Text(message)
                            .font(.title3)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List(characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: character.image)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(character.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text("\(character.status) • \(character.species)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                            .listRowBackground(Color.clear) // Let background image show
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
                .padding(.top)
            }
   
            .onAppear(perform: loadInitialData)
        }
    }
    
    func loadInitialData() {
        APIClient.fetchAvailableTypes { result in
            switch result {
            case .success(let types):
                self.availableTypes = types
            case .failure(let error):
                print("Error fetching types: \(error)")
            }
        }
        
        searchCharacters()
    }
    
    func searchCharacters() {
        var params = [String: String]()
        
        if !searchQuery.isEmpty { params["name"] = searchQuery }
        if let status = selectedStatus, status != "All" { params["status"] = status }
        if let species = selectedSpecies, species != "All" { params["species"] = species }
        if let type = selectedType, type != "All" { params["type"] = type }
        if let gender = selectedGender, gender != "All" { params["gender"] = gender }
        
        APIClient.fetchCharactersWithParams(params: params) { result in
            switch result {
            case .success(let characters):
                if characters.isEmpty {
                    self.message = "No characters found."
                } else {
                    self.message = nil
                    self.characters = characters
                }
            case .failure(let error):
                self.message = "Error fetching characters: \(error.localizedDescription)"
            }
        }
    }
}



struct FilterButton: View {
    var label: String
    @Binding var selectedValue: String?
    var options: [String]

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selectedValue = option
                }
            }
        } label: {
            HStack {
                Text(label)
                    .font(.footnote)
                Image(systemName: "chevron.down")
                    .font(.footnote)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(selectedValue == nil ? Color.gray.opacity(0.4) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
