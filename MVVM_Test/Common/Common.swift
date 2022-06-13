//
//  Common.swift
//  MVVM_Test
//
//  Created by 정지훈 on 2022/05/23.
//

import Foundation

// 이메일 정규성 체크
func validateEmail(_ input: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = emailPredicate.evaluate(with: input)

    return isValid
}


// 패스워드 정규성 체크
func validatePassword(_ input: String) -> Bool {
//        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}" // 8자리 ~ 16자리 영어+숫자+특수문자
    let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,16}" // 8자리 ~ 16자리 영어+숫자

    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: input)

    return isValid
}
