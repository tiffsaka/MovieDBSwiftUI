//
//  ContentView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Tiffany Sakaguchi on 6/27/23.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry?") {
                        Task {
                            await viewModel.loadMovies()
                        }
                    }
                }
            case .loaded(let movies):
                list(of: movies)
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            await viewModel.loadMovies()
        }
    }
    
    func list(of movies: [Movie]) -> some View {
        List(movies) { movie in
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                HStack {
                    AsyncImage(url: movie.posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80)
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .lineLimit(4)
                    }
                }
                .padding()
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesView()
        }
    }
}
