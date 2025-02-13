//
//  RecipeSimpleItemView.swift
//  RecipesUI
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import DesignSystem
import ImageLoader
import SwiftUI

struct RecipeSimpleItemView: View {
    
    @EnvironmentObject private var imageDownloader: RemoteImageDownloader
    
    let recipe: RecipeItem
    
    @State private var image: UIImage?
    
    var body: some View {
        HStack {
            RecipeImage()
            Details()
        }
        .frame(height: 96)
        .frame(maxWidth: .infinity)
        .onAppear {
            
            guard let imageUrlString = recipe.photoUrlSmall ?? recipe.photoUrlLarge,
                  let imageUrl = URL(string: imageUrlString) else { return }
            
            Task { @MainActor in
                self.image = try? await imageDownloader.downloadImage(from: imageUrl).image
            }
        }
        .padding(.horizontal, 16)
        .background(.fetchPrimaryBackground)
        
    }
    
    @ViewBuilder
    private func RecipeImage() -> some View {
        
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Rectangle()
                    .fill(.fetchDarkPurple)
            }
        }
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
    
    @ViewBuilder
    private func Details() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(recipe.name)
                .textStyle(.primaryBody)
            
            HStack {
                Group {
                    if recipe.sourceUrl != nil {
                        Image(systemName: "globe")
                    }
                    
                    if recipe.youtubeUrl != nil {
                        Image(systemName: "play.desktopcomputer")
                    }
                }
                .foregroundStyle(.fetchLightPurple)

            }
            
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RecipeSimpleItemView(
        recipe: .mock
    )
    .environmentObject(RemoteImageDownloader.mock)
}
