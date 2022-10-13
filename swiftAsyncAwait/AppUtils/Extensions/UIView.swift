//
//  UIView.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 13/10/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            addSubview(view)
        }
    }
    
    func constraint<V>(to item: Any? = nil,
                       by attributes: [NSLayoutConstraint.Attribute:V],
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for attribute in attributes {
            
            superview?.addConstraint(NSLayoutConstraint(item: self,
                                                       attribute: attribute.key,
                                                       relatedBy: relation,
                                                       toItem: item ?? superview,
                                                       attribute: attribute.value as? NSLayoutConstraint.Attribute ?? attribute.key,
                                                       multiplier: multiplier,
                                                       constant: attribute.value as? CGFloat ?? constant))
        }
    }
}
