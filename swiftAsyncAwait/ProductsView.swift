//
//  ProductsView.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 17/10/22.
//

import UIKit

class ProductsView: UIViewController {
    
    private lazy var button = Create.button("Back") {_ in
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(button)
        
        button.constraint(by: [.centerY:0,.centerX:0])
    }
}
