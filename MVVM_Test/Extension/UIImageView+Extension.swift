//
//  UIImageView+Extension.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/06/09.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String, placeholder: UIImage?, completion: (() -> Void)? = nil) {
        
        // 캐시 무시
        guard let url = URL(string: urlString) else { return }
        KingfisherManager.shared.retrieveImage(with: url, options: [.fromMemoryCacheOrRefresh]) { (result) in
            switch result {
            case.success(let value):
                self.image = value.image
                break
            case .failure(let error):
                print("Error: \(error)")
                completion?()
                break
            }
        }
    }
}
