//
//  RecipeGridItemView.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DesignSystem
import ImageLoader
import SwiftUI

struct RecipeGridItemView: View {
    
    @EnvironmentObject private var imageDownloader: RemoteImageDownloader
    
    let recipe: RecipeItem
    
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            RecipeImage()
            Details()
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .onAppear {
            
            guard let imageUrlString = recipe.photoUrlLarge ?? recipe.photoUrlSmall,
                  let imageUrl = URL(string: imageUrlString) else { return }
            
            Task { @MainActor in
                self.image = try? await imageDownloader.downloadImage(from: imageUrl).image
            }
        }
        
    }
    
    @ViewBuilder
    private func RecipeImage() -> some View {
        
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0), .fetchDarkPurple.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        } else {
            Rectangle()
                .fill(.fetchDarkPurple)
        }
        
    }
    
    @ViewBuilder
    private func Details() -> some View {
        VStack(alignment: .center, spacing: 8) {
            
            Spacer()
            Text(recipe.name)
                .textStyle(.whiteTitle)
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(1), radius: 2, x: 0, y: 0)
            
            HStack {
                Group {
                    if recipe.sourceUrl != nil {
                        Image(systemName: "globe")
                    }
                    
                    if recipe.youtubeUrl != nil {
                        Image(systemName: "play.desktopcomputer")
                    }
                }
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(1), radius: 2, x: 0, y: 0)

            }
            
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    RecipeGridItemView(
        recipe: .mock
    )
    .padding(.horizontal, 16)
    .environmentObject(RemoteImageDownloader.mock)
}
