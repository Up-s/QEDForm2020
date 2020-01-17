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
    static let inset: CGFloat = 16
  }

  private var visibleIndex = 0
  private var forms = [BaseForm]()
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
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✚", style: .done, target: self, action: #selector(formUpdateAnimate))
  }
  
  @objc private func formUpdateAnimate() {
    visibleIndex += 1
    
    guard forms.count > visibleIndex else { return }
    
    UIView.animate(withDuration: 0.2) { [weak self] in
      guard let `self` = self else { return }
      for i in 0...(self.visibleIndex - 1) {
        self.topConstraints[i].constant += Padding.inset + self.forms[self.visibleIndex].frame.height
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
    forms[visibleIndex - 1].subLabelAnimated(status: true)
  }
  
  private func baseUI() {
    titleLabel.backgroundColor = .white
    titleLabel.text = formData[visibleIndex].title
    titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
    view.addSubview(titleLabel)
    
    mainScrollView.backgroundColor = .white
    view.addSubview(mainScrollView)
    
    let guide = view.safeAreaLayoutGuide
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Padding.inset).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Padding.inset).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Padding.inset).isActive = true
    
    mainScrollView.translatesAutoresizingMaskIntoConstraints = false
    mainScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.inset).isActive = true
    mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
  private func createForm() {
    formData.enumerated().forEach {
      let tempForm = BaseForm(form: $1)
      forms.append(tempForm)
      mainScrollView.addSubview(tempForm)
      tempForm.translatesAutoresizingMaskIntoConstraints = false
      tempForm.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
      let tempTopConstraint = tempForm.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: Padding.inset)
      tempTopConstraint.isActive = true
      topConstraints.append(tempTopConstraint)
      tempForm.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: Padding.inset).isActive = true
      tempForm.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -Padding.inset).isActive = true
      
      if $0 == 0 {
        tempForm.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -Padding.inset).isActive = true
      } else {
        tempForm.alpha = 0
      }
    }
  }
  
}


