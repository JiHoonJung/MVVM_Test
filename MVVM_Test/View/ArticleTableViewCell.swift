//
//  ArticleTableViewCell.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/08.
//

import UIKit
import RxSwift
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel = PublishSubject<ArticleViewModel>()
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subscribe()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func subscribe() {
        self.viewModel.subscribe(onNext: { articleViewModel in
            
            DispatchQueue.main.async {
                if let urlString = articleViewModel.imageUrl {
                    self.photoView.setImage(with: urlString, placeholder: nil)
                }
                self.titleLabel.text = articleViewModel.title
                self.descriptionLabel.text = articleViewModel.description
            }
            
        }).disposed(by: disposeBag)
    }

}
