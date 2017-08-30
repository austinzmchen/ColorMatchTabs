//
//  ExtendedNavigationBar.swift
//  ColorMatchTabs
//
//  Created by Serhii Butenko on 27/6/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

final class ExtendedNavigationBar: UIView {
    
    var topCt: NSLayoutConstraint?
    var bottomCt: NSLayoutConstraint?
    
    override func willMove(toWindow newWindow: UIWindow?) {
        layer.shadowOffset = CGSize(width: 0, height: 1 / UIScreen.main.scale)
        layer.shadowRadius = 0
        layer.shadowColor = UIColor.black.cgColor
        // layer.shadowOpacity = 0.25 // conflict with blurView's blur
    }
    
    // ac
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    open var isBlurred: Bool = false {
        didSet {
            blurView.isHidden = !isBlurred
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isBlurred = false
        self.addSubview(blurView)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        guard let sv = self.superview
            else { return }
        
        topCt = topAnchor.constraint(equalTo: sv.topAnchor)
        bottomCt = bottomAnchor.constraint(equalTo: sv.bottomAnchor)
    }
}
