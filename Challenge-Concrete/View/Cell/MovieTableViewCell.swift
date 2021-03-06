//
//  MovieTableViewCell.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    let movieImageView = UIImageView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func didMoveToSuperview() {
        
    }
    
    func setupFavoriteMovie(_ favoriteMovie: FavoriteMovie) {
        movieImageView.image = UIImage(data: favoriteMovie.image ?? Data())
        titleLabel.text = favoriteMovie.title
        yearLabel.text = favoriteMovie.year
        descriptionLabel.text = favoriteMovie.descript
        
        setupView()
    }
}

extension MovieTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubviews([movieImageView, titleLabel, yearLabel, descriptionLabel])
    }
    
    func buildConstraints() {
        let imageHeight: CGFloat = 160
        let imageWidth: CGFloat = imageHeight / 1.3
        
        movieImageView.anchor
            .top(safeAreaLayoutGuide.topAnchor)
            .left(safeAreaLayoutGuide.leftAnchor)
            .bottom(safeAreaLayoutGuide.bottomAnchor, priority: .defaultHigh)
            .height(constant: imageHeight)
            .width(constant: imageWidth)
        
        titleLabel.anchor
            .top(safeAreaLayoutGuide.topAnchor, padding: 16)
            .left(movieImageView.rightAnchor, padding: 16)
            .right(yearLabel.leftAnchor, padding: 8)
            .height(constant: 20)
            
        yearLabel.anchor
            .top(safeAreaLayoutGuide.topAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .height(constant: 20)
            .width(constant: 70)
        
        descriptionLabel.anchor
            .top(yearLabel.bottomAnchor, padding: 16)
            .left(movieImageView.rightAnchor, padding: 16)
            .right(safeAreaLayoutGuide.rightAnchor, padding: 16)
            .bottom(safeAreaLayoutGuide.bottomAnchor, padding: 16)
    }
    
    func setupAditionalConfiguration() {
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        yearLabel.textAlignment = .right
        descriptionLabel.numberOfLines = 0
        
    }
    
    
}
