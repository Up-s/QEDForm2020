//
//  TextInputFormViewController.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/16.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

class TextInputFormViewController: UIViewController {

  private struct Padding {
    static let xPadding: CGFloat = 32
    static let yPadding: CGFloat = 8
  }

  private var visibleIndex = 0
  private var forms = [UIView]()
  private var topConstraints = [NSLayoutConstraint]()
  
  private let titleLabel = UILabel()
  private let mainScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigation()
    baseUI()
    createForm()
  }
  
  private func navigation() {
    navigationItem.title = "Sign Up"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func formUpdateAnimate() {
    visibleIndex += 1
    
    guard forms.count > visibleIndex else { return }
    
    UIView.animate(withDuration: 0.2) { [weak self] in
      guard let `self` = self else { return }
      for i in 0...(self.visibleIndex - 1) {
        self.topConstraints[i].constant += Padding.yPadding + self.forms[self.visibleIndex].frame.height
      }
      self.view.layoutIfNeeded()
    }
    
    UIView.animate(
      withDuration: 0.2,
      delay: 0.1,
      options: [],
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.forms[self.visibleIndex].alpha = 1
        self.view.layoutIfNeeded()
    })
    
    titleLabel.text = formData[visibleIndex].title
  }
  
  private func baseUI() {
    titleLabel.backgroundColor = .white
    titleLabel.text = formData[visibleIndex].title
    titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    view.addSubview(titleLabel)
    
    mainScrollView.delegate = self
    mainScrollView.backgroundColor = .white
    view.addSubview(mainScrollView)
    
    let guide = view.safeAreaLayoutGuide
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Padding.yPadding).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Padding.xPadding).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Padding.xPadding).isActive = true
    
    mainScrollView.translatesAutoresizingMaskIntoConstraints = false
    mainScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.yPadding).isActive = true
    mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
  private func createForm() {
    formData.enumerated().forEach {
      switch $1.type {
      case .text(let sub, let type):
        let tempForm = TextForm(sub: sub, keyBoardType: type)
        tempForm.guidTextField.delegate = self
        
        forms.append(tempForm)
        mainScrollView.addSubview(tempForm)
        tempForm.translatesAutoresizingMaskIntoConstraints = false
        tempForm.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        let tempTopConstraint = tempForm.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Padding.yPadding)
        tempTopConstraint.isActive = true
        topConstraints.append(tempTopConstraint)
        tempForm.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Padding.xPadding).isActive = true
        tempForm.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Padding.xPadding).isActive = true
        
        if $0 == 0 {
          tempForm.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Padding.yPadding).isActive = true
        } else {
          tempForm.alpha = 0
        }
        
      case .birth(let year, let month, let day):
        let tempForm = BirthForm(year: year, month: month, day: day)
//        tempForm.guidTextField.delegate = self
        
        forms.append(tempForm)
        mainScrollView.addSubview(tempForm)
        tempForm.translatesAutoresizingMaskIntoConstraints = false
        tempForm.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        let tempTopConstraint = tempForm.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Padding.yPadding)
        tempTopConstraint.isActive = true
        topConstraints.append(tempTopConstraint)
        tempForm.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Padding.xPadding).isActive = true
        tempForm.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Padding.xPadding).isActive = true
        
        if $0 == 0 {
          tempForm.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Padding.yPadding).isActive = true
        } else {
          tempForm.alpha = 0
        }
      }
      
    }
  }
  
}

extension TextInputFormViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension TextInputFormViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
//    print("VC", textField.text)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    formUpdateAnimate()
    return false
  }
}
