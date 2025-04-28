import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
          
                Styles.backgroundStyle()
                
                VStack(spacing: 30) {
                    Spacer()
                    
        
                    Image("header2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.green.opacity(0.8), lineWidth: 6)
                                .shadow(color: .green, radius: 10)
                        )
                        .shadow(radius: 20)
                    
                  
                    Text("Welcome to the Rick and Morty\nFandomverse!")
                        .font(Styles.headingFontStyle())
                        .foregroundColor(Styles.headingFontColor())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .shadow(color: .green.opacity(0.7), radius: 5)
                    
              
                    VStack(spacing: 20) {
                        NavigationLink(destination: CharacterListView()) {
                            Text("Characters")
                        }
                        .buttonStyle(RMButtonStyle(color: .green))
                        
                        NavigationLink(destination: EpisodesListView()) {
                            Text("Episodes")
                        }
                        .buttonStyle(RMButtonStyle(color: .purple))
                        
                        NavigationLink(destination: LocationListView()) {
                            Text("Locations")
                        }
                        .buttonStyle(RMButtonStyle(color: .blue))
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}
