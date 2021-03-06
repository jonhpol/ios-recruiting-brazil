//
//  FavoriteMoviesViewModel.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

class FavoriteMoviesViewModel: MovieViewModel {

    weak var dataSource: MovieDataSource?

    func fetchFavoriteMovies() {
        self.dataSource?.data = CoreDataManager.shared.fetch()
    }
    
    func add(_ favoriteMovie: FavoriteMovie) {
        self.dataSource?.data.append(favoriteMovie)
    }
    
    func toggleFavorite(_ movie: Movie) {
        let favMovie: FavoriteMovie? = CoreDataManager.shared.fetchBy(id: movie.id)
        let releaseDate = movie.releaseDate ?? ""
        let genres = fetchGenresFrom(movie)
        if favMovie == nil, let title = movie.title ?? movie.name {
            let favoriteMovie = FavoriteMovie(id: Int64(movie.id),
                                              title: title,
                                              year: releaseDate.year,
                                              descript: movie.overview,
                                              image: movie.movieImageData!,
                                              genres: genres)
            CoreDataManager.shared.saveContext()
            add(favoriteMovie)
        } else if favMovie != nil {
            remove(movie.id)
        }
    }
    
    func toggleFavorite(_ movie: FavoriteMovie) {
        let isFavorite = dataSource!.data.contains(where: {$0.id == movie.id})
        if !isFavorite {
            CoreDataManager.shared.saveContext()
            add(movie)
        } else {
            remove(Int(movie.id))
        }
    }
    
    func fetchGenresFrom(_ movie: Movie) -> [GenreLocal] {
        var genres: [GenreLocal] = []
        movie.genreIds?.forEach({ id in
            if let genre: GenreLocal = CoreDataManager.shared.fetchBy(id: id) {
                genres.append(genre)
            }
        })
        return genres
    }
    
    
    func removeFavorite(_ movie: Movie) {
        CoreDataManager.shared.deleteBy(id: movie.id, entityType: FavoriteMovie.self)
    }
    
    func remove(_ favoriteMovieId: Int) {
        CoreDataManager.shared.deleteBy(id: favoriteMovieId, entityType: FavoriteMovie.self)
        self.dataSource?.data.removeAll(where: {$0.id == favoriteMovieId})
    }

}
