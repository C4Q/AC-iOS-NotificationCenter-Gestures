//
//  ScrollingCaptionView.swift
//  NotificationCenter+Scroll+Gestures
//
//  Created by C4Q  on 1/16/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ScrollingCaptionView: UIView {
    
    public func moveFramesToAccomodateKeyboard(with rect: CGRect, and animationDuration: Double) {
        guard rect != CGRect.zero else {
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
            return
        }
        let hiddenAreaRect = rect.intersection(scrollView.bounds)
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: hiddenAreaRect.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        var buttonRect = submitButton.frame
        buttonRect = scrollView.convert(buttonRect, from: submitButton.superview)
        buttonRect = buttonRect.insetBy(dx: 0.0, dy: -20)
        scrollView.scrollRectToVisible(buttonRect, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(captionLabel)
        contentView.addSubview(textField)
        contentView.addSubview(submitButton)
    }
    
    private func configureConstraints() {
        constrainScrollView()
        constrainContentView()
        constrainButton()
        constrainTextField()
        constrainCaptionLabel()
        constrainImageView()
    }
    
    private func constrainScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func constrainContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        //Centering because the contents don't define its size
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
    }
    
    private func constrainButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func constrainTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func constrainCaptionLabel() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -100).isActive = true
        captionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func constrainImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: captionLabel.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    
    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        return sv
    }()
    
    lazy var contentView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .red
        return cv
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "park") //iv.image = UIImage(named: "park")
        iv.contentMode = UIViewContentMode.scaleAspectFill
        return iv
    }()
    
    lazy var captionLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Caption"
        return lab
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a caption here"
        return tf
    }()
    
    lazy var submitButton: UIButton = {
        let but = UIButton()
        but.setTitle("Submit", for: .normal)
        return but
    }()

}
