//
//  CategoriesView.swift
//  ep02 Rodrigo Dulanto
//
//  Created by Casa on 12/02/25.
//

import Foundation
import SwiftUICore
import SwiftUI


// Vista principal 
struct CategoriesView: View {
    @StateObject var viewModel = CategoriesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        ZStack {
                            HStack {
                                Spacer()
                                AsyncImage(url: URL(string: category.imageUrl)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(.bottom, 10)
                                } placeholder: {
                                    ProgressView()
                                }
                                Spacer()
                            }

                            VStack {
                                Spacer()
                                Text(category.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 2)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.bottom, 5)
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Categorias")
            .onAppear {
                viewModel.fetchCategories()
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
        .padding(.horizontal, -15)
    }
}
