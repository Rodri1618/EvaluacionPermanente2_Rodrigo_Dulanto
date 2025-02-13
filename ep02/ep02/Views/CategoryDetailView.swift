//
//  CategoryDetailView.swift
//  ep02
//
//  Created by Casa on 12/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct CategoryDetailView: View {
    let category: RecipeCategory
    @StateObject private var viewModel = CategoryItemsViewModel()
    
    var body: some View {
        List {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: category.imageUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: 350, maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                
                Text(category.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 5)
            }

            Text(category.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .padding(.horizontal)
            
            if !viewModel.categoryItems.isEmpty {
                ForEach(viewModel.categoryItems) { item in
                    NavigationLink(destination: RecipeDetailView(recipeName: item.name)) {
                        HStack {
                            AsyncImage(url: URL(string: item.imageUrl)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }
                            Text(item.name)
                                .font(.headline)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchCategoryItems(for: category.name)
                    }
            }
        }
        .navigationTitle(category.name)
    }
}
