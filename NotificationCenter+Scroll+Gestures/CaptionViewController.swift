//
//  ViewController.swift
//  NotificationCenter+Scroll+Gestures
//
//  Created by C4Q  on 1/16/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
        addObservers()
        addSubviews()
        configureConstraints()
    }
    
    func addGestureRecognizers() {
        view.addGestureRecognizer(tapRecognizer)
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardShowing(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardHiding(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func addSubviews() {
        view.addSubview(captionView)
    }
    
    func configureConstraints() {
        let safeGuide = view.safeAreaLayoutGuide
        captionView.translatesAutoresizingMaskIntoConstraints = false
        captionView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        captionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        captionView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        captionView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    lazy var swipeRecognizer: UISwipeGestureRecognizer = {
        let sr = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        sr.direction = .down
        sr.numberOfTouchesRequired = 1
        return sr
    }()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let tr = UITapGestureRecognizer(target: self, action: #selector(respondToTap))
        tr.numberOfTapsRequired = 2
        tr.numberOfTouchesRequired = 2
        return tr
    }()
    
    lazy var captionView: ScrollingCaptionView = {
        let cv = ScrollingCaptionView()
        return cv
    }()
    
    @objc func handleKeyboardShowing(sender notification: Notification) {
        guard let infoDict = notification.userInfo else { return }
        guard let rectFrame = infoDict[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let duration = infoDict[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        captionView.moveFramesToAccomodateKeyboard(with: rectFrame, and: duration)
    }
    
    @objc func handleKeyboardHiding(sender notification: Notification) {
        guard let infoDict = notification.userInfo else { return }
        guard let duration = infoDict[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        captionView.moveFramesToAccomodateKeyboard(with: CGRect.zero, and: duration)
    }
    

    
    @objc func respondToTap(sender: UITapGestureRecognizer) {
        print("Did a tap")
    }
    @objc func respondToSwipe(sender: UISwipeGestureRecognizer) {
        print("Did a swipe")
    }
}

