//
//  SignUpViewController.swift
//  SignUpForm
//
//  Created by Lee on 2020/01/11.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

private struct Standard {
  static let space: CGFloat = 8
  
  static let scrollViewInset: CGFloat = 16
}

class SignUpViewController: UIViewController {
  
  private var visibleIndex = 0
  private var formViewSpace: CGFloat = 0
  private var formViewSpaceStatus = true
  private var signUpForms = ["000", "111", "222", "333", "444", "555", "666", "777", "888", "999"]
  private var visibleForms = [SignUpFormView]()
  private var topConstraints = [NSLayoutConstraint]()
  
  private let mainScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigation()
    mainScrollViewSet()
    setFormView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if formViewSpaceStatus {
      formViewSpaceStatus = false
      formViewSpace = visibleForms[0].frame.maxY
      print("viewDidAppear", formViewSpace)
    }
  }
  
  private func navigation() {
    navigationItem.title = "Sign Up"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✚", style: .done, target: self, action: #selector(formViewUpdateAnimate))
  }
  
  @objc private func formViewUpdateAnimate() {
    visibleIndex += 1
    
    guard signUpForms.count > visibleIndex else { return }
    
    UIView.animate(withDuration: 0.2) { [weak self] in
      guard let `self` = self else { return }
      for i in 0...(self.visibleIndex - 1) {
        self.topConstraints[i].constant += self.formViewSpace
      }
      self.view.layoutIfNeeded()
    }
    
    UIView.animate(
      withDuration: 0.2,
      delay: 0.1,
      options: [],
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.visibleForms[self.visibleIndex].alpha = 1
        self.view.layoutIfNeeded()
    })
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
  
  private func setFormView() {
    signUpForms.enumerated().forEach {
      let tempSignUpFormView = SignUpFormView(title: $1)
      visibleForms.append(tempSignUpFormView)
      mainScrollView.addSubview(tempSignUpFormView)
      tempSignUpFormView.translatesAutoresizingMaskIntoConstraints = false
      tempSignUpFormView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
      let tempTopConstraint = tempSignUpFormView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Standard.scrollViewInset)
      tempTopConstraint.isActive = true
      topConstraints.append(tempTopConstraint)
      
      tempSignUpFormView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, constant: (-Standard.scrollViewInset * 2)).isActive = true
      
      if $0 == 0 {
        tempSignUpFormView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Standard.scrollViewInset).isActive = true
      } else {
        tempSignUpFormView.alpha = 0
        tempSignUpFormView.heightAnchor.constraint(equalTo: visibleForms[0].heightAnchor).isActive = true
      }
    }
  }
}

extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return true
  }
}
