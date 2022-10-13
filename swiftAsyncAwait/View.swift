//
//  ViewController.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 13/10/22.
//

import UIKit

class View: UIViewController {

    private static let cell = "Cell"
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    private var users:[User] = []
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell)
        tableView.backgroundColor = .blue
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        view.addSubview(tableView)
        
        tableView.constraint(by: [.centerX:0,.centerY:0])
        tableView.constraint(by: [.height:nil,.width:nil], multiplier: 0.5)
        
        tableView.dataSource = self
        
        Task.init {[weak self] in
            
            let result = await Network.call([User].self, from: url)
            
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
