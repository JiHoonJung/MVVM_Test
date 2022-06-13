//
//  NewsViewModel.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/07.
//

import Foundation
import RxSwift

class NewsViewModel {
    
    private let articleService: ArticleServiceProcotol
    
    init(articleService: ArticleServiceProcotol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
