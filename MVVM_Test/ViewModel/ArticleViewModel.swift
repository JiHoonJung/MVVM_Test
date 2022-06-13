//
//  ArticleViewModel.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/08.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    var imageUrl: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
