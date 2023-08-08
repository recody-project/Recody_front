//
//  SampleModel.swift
//  Recody
//
//  Created by 윤지호 on 2023/08/05.
//

import Foundation

struct SampleCategory {
    var name: String // "영화", "드라마"
    var imageStr: String // "all","book","drama","movie","show", "music"/ "plus"
    var genres: [Genre] // ["로맨스 코미디","스릴러", "액션"]
    
    struct Genre {
        var genre: String
        var isSelected: Bool
    }
    
    static var sampleList: [SampleCategory] = [
        SampleCategory(name: "영화", imageStr: "movie", genres: sampleGenres),
        SampleCategory(name: "드라마", imageStr: "drama", genres: sampleGenres),
        SampleCategory(name: "책", imageStr: "book", genres: sampleGenres)
    ]
    
    static var sampleGenres: [Genre] = [
        Genre(genre: "로맨스 코미디", isSelected: true),
        Genre(genre: "스릴러", isSelected: false),
        Genre(genre: "액션", isSelected: false),
        Genre(genre: "범죄", isSelected: true),
        Genre(genre: "SF", isSelected: false),
        Genre(genre: "코미디", isSelected: true),
        Genre(genre: "공포", isSelected: false),
        Genre(genre: "전쟁", isSelected: false),
        Genre(genre: "스포츠", isSelected: false),
        Genre(genre: "판타지", isSelected: false),
        Genre(genre: "음악", isSelected: false),
        Genre(genre: "뮤지컬", isSelected: false)
    ]
}
