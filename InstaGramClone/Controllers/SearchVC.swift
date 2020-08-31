//
//  SearchVC.swift
//  InstaGramClone
//
//  Created by MANINDER SINGH on 12/08/20.
//  Copyright © 2020 MANINDER SINGH. All rights reserved.
//

import UIKit
import Firebase
private let reuseIdentifier = "SearchUserCell"
class SearchVC: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        configureNavController()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        fetchUsers()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.user = users[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
       let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.userToLoadFromSearchVC = user
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    func configureNavController(){
        navigationItem.title = "Explore"
    }
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
          //  print(snapshot)
            let uid = snapshot.key
           guard let dictionary = snapshot.value  as? Dictionary<String,AnyObject> else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            self.users.append(user)
            self.tableView.reloadData()

        }
    }
}
