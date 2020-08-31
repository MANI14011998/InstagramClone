//
//  UserProfileVC.swift
//  InstaGramClone
//
//  Created by MANINDER SINGH on 12/08/20.
//  Copyright © 2020 MANINDER SINGH. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user:User?
    
    var userToLoadFromSearchVC: User?
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchCurrentUserData()
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // background color
        self.collectionView?.backgroundColor = .white
        if let userToLoadFromSearchVC = self.userToLoadFromSearchVC{
            print(userToLoadFromSearchVC.username!)
        }
        
        if userToLoadFromSearchVC == nil {
            print("nil")
            fetchCurrentUserData()
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader

        if let user = self.user{
            header.user = user
        
        }else if let userToLoadFromSearchVC = self.userToLoadFromSearchVC{
            header.user = userToLoadFromSearchVC
        }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func fetchCurrentUserData(){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let dataRef=Database.database().reference()
        dataRef.child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            self.user=user
            self.navigationItem.title = user.username
            self.collectionView.reloadData()
            
        }
    }
    
    
}
