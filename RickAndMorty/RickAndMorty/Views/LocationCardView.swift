//
//  LocationCardView.swift
//  RickAndMorty
//
//  Created by Aiaulym Abduohapova on 28.04.2025.
//
import SwiftUI
struct LocationCardView: View {
    let location: Location

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backgroundForType(location.type)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .clipped()
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
            return Image("defaultBackground")
        }
    }
}

