//
//  MenuView.swift
//  ColorMatchTabs
//
//  Created by Serhii Butenko on 27/6/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    internal(set) var navigationBar: ExtendedNavigationBar!
    internal(set) var tabs: ColorTabs!
    internal(set) var scrollMenu: ScrollMenu!
    internal(set) var circleMenuButton: UIButton!
    fileprivate var shadowView: VerticalGradientView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        layoutIfNeeded()
    }
    
    func setCircleMenuButtonHidden(_ hidden: Bool) {
        circleMenuButton.isHidden = hidden
        shadowView.isHidden = hidden
    }
    
    // ac
    var isNavigationBarOnTop: Bool = true // should be called before creating
    
    init(frame: CGRect, isNavigationBarOnTop: Bool) {
        super.init(frame: frame)
        
        self.isNavigationBarOnTop = isNavigationBarOnTop
        commonInit()
    }
    
    open func layoutConstraints() {
        layoutNavigationBar()
        layoutTabs()
        layoutScrollMenu()
        layoutShadowView()
        layoutCircleMenu()
    }
}

// Init
private extension MenuView {
    
    func commonInit() {
        backgroundColor = .white
        createSubviews()
        
        layoutConstraints()
    }
    
    func createSubviews() {
        scrollMenu = ScrollMenu()
        scrollMenu.showsHorizontalScrollIndicator = false
        addSubview(scrollMenu)
        
        navigationBar = ExtendedNavigationBar()
        addSubview(navigationBar)
        
        tabs = ColorTabs()
        tabs.isUserInteractionEnabled = true
        navigationBar.addSubview(tabs)
        
        shadowView = VerticalGradientView()
        shadowView.isHidden = true
        if isNavigationBarOnTop {
            shadowView.topColor = UIColor(white: 1, alpha: 0)
            shadowView.bottomColor = UIColor(white: 1, alpha: 1)
        } else {
            shadowView.topColor = UIColor(white: 1, alpha: 1)
            shadowView.bottomColor = UIColor(white: 1, alpha: 0)
        }
        addSubview(shadowView)
        
        circleMenuButton = UIButton()
        circleMenuButton.isHidden = true
        circleMenuButton.setImage(UIImage(namedInCurrentBundle: "circle_menu"), for: UIControlState())
        circleMenuButton.adjustsImageWhenHighlighted = false
        addSubview(circleMenuButton)
    }
    
}

// Layout
private extension MenuView {
    
    func layoutNavigationBar() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        // ac
        if isNavigationBarOnTop {
            navigationBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        } else {
            navigationBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    
    func layoutTabs() {
        tabs.translatesAutoresizingMaskIntoConstraints = false
        tabs.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor).isActive = true
        // tabs.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        tabs.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor).isActive = true // center Y instead align top
        tabs.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor).isActive = true
        tabs.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func layoutScrollMenu() {
        scrollMenu.translatesAutoresizingMaskIntoConstraints = false
        scrollMenu.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollMenu.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // ac
        if isNavigationBarOnTop {
            scrollMenu.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
            scrollMenu.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        } else {
            scrollMenu.topAnchor.constraint(equalTo: topAnchor).isActive = true
            scrollMenu.bottomAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        }
    }
    
    func layoutShadowView() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        if isNavigationBarOnTop {
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        } else {
            shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
    }
    
    func layoutCircleMenu() {
        circleMenuButton.translatesAutoresizingMaskIntoConstraints = false
        circleMenuButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if isNavigationBarOnTop {
            circleMenuButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PlusButtonButtonOffset).isActive = true
        } else {
            circleMenuButton.topAnchor.constraint(equalTo: topAnchor, constant: -PlusButtonButtonOffset).isActive = true
        }
    }
    
}
