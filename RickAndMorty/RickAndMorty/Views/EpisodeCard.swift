//
//  EpisodeCard.swift
//  RickAndMorty
//
//  Created by Aiaulym Abduohapova on 28.04.2025.
//

import SwiftUI
struct EpisodeCardView: View {
    let episode: Episode

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode.name)
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                Text(episode.episode)
                    .font(.subheadline)
                    .foregroundColor(.green)
                Spacer()
                Text(episode.airDate)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(15)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

