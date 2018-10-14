//
//  UIView+Constraints.swift
//  WTest
//
//  Created by Mário Rodrigues on 13/10/2018.
//  Copyright © 2018 Mário Rodrigues. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperview(){
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview?.topAnchor, bottom: superview?.bottomAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor)
    }
    
    func center(to view: UIView?){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let view = view {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingConstant).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: trailingConstant).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
