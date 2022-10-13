//
//  ViewController.swift
//  swiftAsyncAwait
//
//  Created by Josicleison on 13/10/22.
//

import UIKit

struct User: Codable {
    
    let name: String
}

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
        
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        
        Task.init {[weak self] in
            
            let users = await call([User].self, from: url)
            self?.users = users ?? []
            self?.tableView.reloadData()
        }
    }
    
    private func call<T: Codable>(_ what: T.Type, from url: URL?) async -> T? {
        
        guard let url = url else {return nil}
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            print(response)
            let users = try JSONDecoder().decode(what.self, from: data)
            
            return users
        }
        catch {
            
            print(error); return nil
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
