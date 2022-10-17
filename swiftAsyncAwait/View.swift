//
//  ViewController.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 13/10/22.
//

import UIKit

class View: UIViewController {

    private static let cell = "Cell"
    private var users:[User] = []
    
    private lazy var buttom: UIButton = Create.button("Go") {_ in
        
        self.navigationController?.pushViewController(ProductsView(),
                                                      animated: true)
    }
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        tableView.backgroundColor = .blue
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        view.addSubviews([tableView, buttom])
        
        tableView.constraint(to: view.safeAreaLayoutGuide,
                             by: [.top: 0, .leading: 0, .trailing: 0])
        tableView.constraint(to: buttom,
                             by: [.bottom: NSLayoutConstraint.Attribute.top])
        
        buttom.constraint(to: view.safeAreaLayoutGuide,
                          by: [.bottom: 0, .leading: 0, .trailing: 0])
        
        tableView.dataSource = self
        
        Task.init {[weak self] in
            
            let result = await Network.call([User].self, from: Network.EndPoints.users)
            
            switch result {
                
                case .success(let users):
                    
                    self?.users = users ?? []
                    self?.tableView.reloadData()
                    
                case .failure(let error):
                
                    print("ERROR: \(error)")
            }
            
        }
    }
}

extension View: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: View.cell,
                                                 for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
}
