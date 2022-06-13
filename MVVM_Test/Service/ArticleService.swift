//
//  ArticleService.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/07.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProcotol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProcotol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews { (error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping ((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=bb30a7750e974e798ab2d5d07d71ad27"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "", code: 404, userInfo: nil), nil)}
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: ArticleResponse.self) { response in
            if let error = response.error {
                completion(error, nil)
            }
            
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
        }
        
    }
    
}
