//
//  CaptionView.swift
//  NotificationCenter+Scroll+Gestures
//
//  Created by C4Q  on 1/16/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CaptionView: UIView {
    
    
    public func moveFramesToAccomodateKeyboard(with rect: CGRect, and animationDuration: Double) {
        buttonBottomConstraint.constant = -(rect.height + 20)
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
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
        addSubview(imageView)
        addSubview(captionLabel)
        addSubview(textField)
        addSubview(submitButton)
    }
    
    private func configureConstraints() {
        constrainButton()
        constrainTextField()
        constrainCaptionLabel()
        constrainImageView()
    }
    
    private var buttonBottomConstraint = NSLayoutConstraint()
    
    private func constrainButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        buttonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        buttonBottomConstraint.isActive = true
        submitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func constrainTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20).isActive = true
        textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func constrainCaptionLabel() {
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -100).isActive = true
        captionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func constrainImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: captionLabel.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    
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
