//
//  ACScrollViewDelegate.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-12.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

public enum ACVerticalScrollDirection {
    case none
    case up
    case down
    case bounceUp
    case bounceDown
}

public enum ACHorizontalScrollDirection {
    case none
    case left
    case right
    case leadBounceLeft
    case leadBounceRight
    case trailBounceLeft
    case trailBounceRight
}


open class ACScrollViewDelegate: NSObject {
    
    open var verticalScrollDirection: ACVerticalScrollDirection {
        return _verticalScrollDirection
    }
    
    open var horizontalScrollDirection: ACHorizontalScrollDirection {
        return _horizontalScrollDirection
    }
    
    var _scrollView: UIScrollView?
    
    fileprivate var _verticalScrollDirection: ACVerticalScrollDirection = .none
    fileprivate var _lastVerticalContentOffset: CGFloat = 0
    
    fileprivate var _horizontalScrollDirection: ACHorizontalScrollDirection = .none
    fileprivate var _lastHorizontalContentOffset: CGFloat = 0
}

extension ACScrollViewDelegate: UIScrollViewDelegate {
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 
        if _scrollView == nil {
            _scrollView = scrollView
        }
        
        if scrollView.contentOffset.y <= 0 {
            // if bounce within top region
            if (_lastVerticalContentOffset < scrollView.contentOffset.y) {
                _verticalScrollDirection = .bounceUp
            } else {
                _verticalScrollDirection = .bounceDown
            }
        } else if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.height {
            // if bounce within bottom region
            
            if (_lastVerticalContentOffset < scrollView.contentOffset.y) {
                _verticalScrollDirection = .bounceUp
            }
            else {
                _verticalScrollDirection = .bounceDown
            }
        } else {
            // set scroll direction
            if (_lastVerticalContentOffset < scrollView.contentOffset.y) {
                // scroll up
                _verticalScrollDirection = .up
            } else if (_lastVerticalContentOffset > scrollView.contentOffset.y) {
                // scroll down
                _verticalScrollDirection = .down
            }
        }
        // update the new position acquired
        _lastVerticalContentOffset = scrollView.contentOffset.y
        
        
        /* horizontal
         */
        if scrollView.contentOffset.x < 0 {
            // if bounce within left region
            if (_lastHorizontalContentOffset < scrollView.contentOffset.x) {
                _horizontalScrollDirection = .leadBounceLeft
            } else {
                _horizontalScrollDirection = .leadBounceRight
            }
        } else if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width {
            // if bounce within right region
            
            if (_lastHorizontalContentOffset < scrollView.contentOffset.x) {
                _horizontalScrollDirection = .trailBounceLeft
            }
            else {
                _horizontalScrollDirection = .trailBounceRight
            }
        } else {
            // set scroll direction
            if (_lastHorizontalContentOffset < scrollView.contentOffset.x) {
                // scroll up
                _horizontalScrollDirection = .left
            } else if (_lastHorizontalContentOffset > scrollView.contentOffset.x) {
                // scroll down
                _horizontalScrollDirection = .right
            }
        }
        
        // update the new position acquired
        _lastHorizontalContentOffset = scrollView.contentOffset.x
    }
}
