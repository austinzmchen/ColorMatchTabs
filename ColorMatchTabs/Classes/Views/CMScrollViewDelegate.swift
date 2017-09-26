//
//  CMScrollViewDelegate.swift
//  Pods
//
//  Created by Austin Chen on 2017-09-12.
//
//

import UIKit

public protocol CMScrollInteractionDelegate: class {
    func interactionStart()
    func interactionProgress(_ percent: CGFloat)
    func interactionEnd(_ cancel: Bool)
}

open class CMScrollViewDelegate: ACScrollViewDelegate {
    
    open weak var delegate: CMScrollInteractionDelegate?
    
    private var _isScrollStarted = false
    private var prevIndex: Int = 0
    
    open func panned(recognizer: UIPanGestureRecognizer) {
        guard let sv = _scrollView
            else { return }
        
        switch recognizer.state {
        case .began:
            break
        case .changed:
            switch horizontalScrollDirection {
            case .leadBounceRight:
                if !_isScrollStarted {
                    delegate?.interactionStart()
                    _isScrollStarted = true
                } else {
                    let percent = fabs(recognizer.translation(in: sv).x) / sv.bounds.width
                    delegate?.interactionProgress(percent)
                }
            case .left, .right:
                if _isScrollStarted {
                    let percent = fabs(recognizer.translation(in: sv).x) / sv.bounds.width
                    delegate?.interactionProgress(percent)
                }
            default:
                break
            }
            
            if _isScrollStarted {
                sv.contentOffset = CGPoint.zero // prevent scrolling during interactive viewController transition
            }
        case .cancelled:
            if _isScrollStarted {
                delegate?.interactionEnd(true)
                _isScrollStarted = false
            }
            break
        case .ended:
            if _isScrollStarted {
                delegate?.interactionEnd(false)
                _isScrollStarted = false
            }
            break
        default:
            break
        }
    }
    
    // ac
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let sv = _scrollView as? ScrollMenu,
            sv.previousIndex < sv.viewControllers.count
            else { return }
        
        prevIndex = sv.previousIndex
        
        // notify current will disappearing
        let currentIndex = sv.indexOfVisibleItem
        let vc = sv.viewControllers[currentIndex]
        vc.viewWillDisappear(true)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let sv = _scrollView as? ScrollMenu,
            prevIndex < sv.viewControllers.count
            else { return }
        
        // notify previous did disappearing
        let vc = sv.viewControllers[prevIndex]
        vc.viewDidDisappear(true)
        
        // notify current appearing
        let toVC = sv.viewControllers[sv.previousIndex]
        toVC.viewWillAppear(true)
        toVC.viewDidDisappear(true)
    }
}
