import Foundation
import SwiftUI

// MARK: - Styles

struct Styles {
    

    static func backgroundStyle() -> some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(0.4)
                .ignoresSafeArea()
        }
    }
    

    static func headingFontStyle() -> Font {
        return .system(size: 28, weight: .heavy, design: .rounded)
    }
    

    static func headingFontColor() -> Color {
        return Color.green.opacity(0.9)
    }

    static func headingTextShadow() -> some View {
        return Text("Welcome to the Rick and Morty Fandomverse!")
            .shadow(color: Color.blue.opacity(0.8), radius: 5, x: 2, y: 2)
    }
}
