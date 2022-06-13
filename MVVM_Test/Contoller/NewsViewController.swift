//
//  NewsViewController.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/08.
//

import UIKit
import RxSwift
import RxRelay

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: NewsViewModel
    let disposbag =  DisposeBag()
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    init?(coder: NSCoder, viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        configureTableView()
        fetchArticles()
        subscribe()
    }
    
    func configureTableView() {
        self.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }
    
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }).disposed(by: disposbag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }).disposed(by: disposbag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! ArticleTableViewCell
                
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }
    
}
