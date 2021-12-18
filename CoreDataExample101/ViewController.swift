//
//  ViewController.swift
//  CoreDataExample101
//
//  Created by Ahmed Qazzaz on 15/12/2021.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var usersList : [User] = []
    
    @IBOutlet weak private var tableView : UITableView!
    var pullToRefresh : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
//        DBOperations().insertUser(username: "ahmedQazzaz", firstName: "Ahmed", lastName: "Qazzaz", email: "abc1@efg.com", mobileNumber: "123456789", active: true, dateOfBirth: Date(), profileImage: UIImage(), facebookAccount: URL(string: "google.com"), rate: 10)
//        do{
//        let u = try User.createUser(username: "M12RF",
//                                 firstName: "Mohammed",
//                                 lastName: "Ali",
//                                 email: "mohammed@ali.com",
//                                 mobileNumber: "987654321",
//                                 active: true,
//                                 dateOfBirth: Date(),
//                                 profileImage: UIImage(),
//                                 facebookAccount: URL(string: "google.com"),
//                                 rate: 9.5,
//                                 usingContext: context)
//        }catch{
//            print((error as? NSError)?.userInfo["conflictList"])
//        }
        
        if let user = DBOperations().getUserByUserName(name: "M12RF") {
            usersList = [user]
        }
    }
    
    @objc func startRefresh(){
        usersList = DBOperations().listAllUsers()
        tableView.reloadData()
        pullToRefresh.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let obj = usersList[indexPath.row]
        let arr = [obj.firstName ?? "", obj.lastName ?? "", "-", obj.email ?? ""]
        cell.textLabel?.text = arr.joined(separator: " ")
        
        return cell
    }


}

