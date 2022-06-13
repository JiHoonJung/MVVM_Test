//
//  ViewController.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/05/23.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    let emailInput: BehaviorSubject<String> = BehaviorSubject(value: "")
    let emailValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let passwordInput: BehaviorSubject<String> = BehaviorSubject(value: "")
    let passwordValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBindings()
    }
    
    func setBindings() {
        emailTextField.rx.text.orEmpty
            .bind(to: emailInput)
            .disposed(by: disposeBag)
        
        emailInput.map(validateEmail(_:))
            .bind(to: emailValid)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: passwordInput)
            .disposed(by: disposeBag)
        
        passwordInput.map(validatePassword(_:))
            .bind(to: passwordValid)
            .disposed(by: disposeBag)
        
        emailValid.subscribe().disposed(by: disposeBag)
        passwordValid.subscribe().disposed(by: disposeBag)
        
        Observable.combineLatest(emailValid, passwordValid) { element1, element2 in
            element1 && element2
        }.subscribe { isState in
            self.loginButton.isEnabled = isState
        }.disposed(by: disposeBag)

    }
    
    @IBAction func onLoginButton(_ sender: Any) {        
        self.performSegue(withIdentifier: "newsViewControllerSegue", sender: nil)
    }

    
    @IBSegueAction func segueInjection(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> NewsViewController? {
        return NewsViewController(coder: coder, viewModel: NewsViewModel(articleService: ArticleService()))
    }
    
    
}

