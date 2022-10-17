//
//  Create.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 17/10/22.
//

import UIKit

struct Create {
    
    static func image(_ image: UIImage? = nil) -> UIImageView {
        
        let image = UIImageView(image: image)
        
        return image
    }
    
    static func button(_ title: String? = nil,
                handler: @escaping UIActionHandler) -> UIButton {
        
        let button = UIButton(frame: .zero, primaryAction: UIAction(handler: handler))
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25,
                                                    weight: .bold)
        
        return button
    }
}
