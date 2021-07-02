//
//  Movie.swift
//  api-tmdb
//
//  Created by Willian Magnum Albeche & Luiz Eduardo Mello dos Reis  on 02/07/21.
//
import Foundation


struct Movie{
    let id: Int
    let title: String
    let description: String
    let coverImage: String
    let rating: Double
    let genresId: [Int]
}
