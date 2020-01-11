//
//  SignUpViewController1.swift
//  SignUpForm
//
//  Created by Lee on 2020/01/11.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class SignUpViewController1: UIViewController {
  
  private var index = 0 { didSet { print(index) } }
  private let signUpForms = ["000", "111", "222", "333", "444", "555", "666", "777", "888", "999"]
  private var visibleForms = [SignUpFormView]()
  private var tempContraints = [NSLayoutConstraint]()
  
  private let mainScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigation()
    mainScrollViewSet()
    firstFormSet()
//    formViewSet()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print(visibleForms[0].frame)
  }
  
  private func navigation() {
    navigationItem.title = "Sign Up"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func mainScrollViewSet() {
    mainScrollView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    view.addSubview(mainScrollView)
    
    let guide = view.safeAreaLayoutGuide
    mainScrollView.translatesAutoresizingMaskIntoConstraints = false
    mainScrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    
  }
  
  private func createformView() {
    let tempSignUpFormView = SignUpFormView(title: signUpForms[index])
    visibleForms.insert(tempSignUpFormView, at: 0)
    mainScrollView.addSubview(tempSignUpFormView)
    tempSignUpFormView.textField.becomeFirstResponder()
    tempSignUpFormView.textField.delegate = self
    tempSignUpFormView.translatesAutoresizingMaskIntoConstraints = false
    tempSignUpFormView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
    tempSignUpFormView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: (-Standard.scrollViewInset * 2)).isActive = true
    
    index += 1
  }
  
  private func firstFormSet() {
    createformView()
    
    tempContraints.append(visibleForms[0].topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Standard.scrollViewInset))
    tempContraints.append(visibleForms[0].bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Standard.scrollViewInset))
    
    tempContraints.forEach { $0.isActive = true }
  }
  
  private func formUpdate() {
    tempContraints.forEach { $0.isActive = false }
    tempContraints.removeAll()
    
    createformView()
    
    for i in 0..<visibleForms.count {
      switch i {
      case 0:
        tempContraints.append(visibleForms[i].topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Standard.scrollViewInset))
        
      case visibleForms.count - 1:
        tempContraints.append(visibleForms[i].bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Standard.scrollViewInset))
        fallthrough
        
      default:
        tempContraints.append(visibleForms[i].topAnchor.constraint(equalTo: visibleForms[i - 1].bottomAnchor, constant: Standard.scrollViewInset))
      }
    }
    
    tempContraints.forEach { $0.isActive = true }
//    view.updateConstraints()
//    view.layoutIfNeeded()
  }
  
  
  
  
  
  private func formViewSet() {
    signUpForms.forEach {
      let tempSignUpFormView = SignUpFormView(title: $0)
      visibleForms.append(tempSignUpFormView)
      mainScrollView.addSubview(tempSignUpFormView)
      tempSignUpFormView.translatesAutoresizingMaskIntoConstraints = false
      tempSignUpFormView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
      tempSignUpFormView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: (-Standard.scrollViewInset * 2)).isActive = true
    }
    
    visibleForms.reverse()
    
    for i in 0..<visibleForms.count {
      switch i {
      case 0:
        visibleForms[i].topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Standard.scrollViewInset).isActive = true
        
      case visibleForms.count - 1:
        visibleForms[i].bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Standard.scrollViewInset).isActive = true
        fallthrough
        
      default:
        visibleForms[i].topAnchor.constraint(equalTo: visibleForms[i - 1].bottomAnchor, constant: Standard.scrollViewInset).isActive = true
      }
    }
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
    static let scrollViewInset: CGFloat = 16
  }
}

extension SignUpViewController1: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    formUpdate()
    return true
  }
}
