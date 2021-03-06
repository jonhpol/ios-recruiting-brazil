//
//  MovieViewModel.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

protocol MovieViewModel {
    associatedtype T: Any
    var dataSource: T? {get set}
}
