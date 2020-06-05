//
//  ViewController.swift
//  SqliteSample
//
//  Created by SARA Technologies  on 02/04/20.
//  Copyright © 2020 SARA Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellReuseIdentifier = "cell"
    var db:DBHelper = DBHelper()
    var persons:[Person] = []

    @IBOutlet weak var tblData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        setUpTableViews()
        setUpDatabase()
    }
    
    private func setUpDatabase() {

        db.insert(id: 1, name: "Bilal", age: 24)
        db.insert(id: 2, name: "Bosh", age: 25)
        db.insert(id: 3, name: "Thor", age: 23)
        db.insert(id: 4, name: "Edward", age: 44)
        db.insert(id: 5, name: "Ronaldo", age: 34)

        persons = db.read()
    }
    
    private func setUpTableViews() {
        tblData.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tblData.delegate = self
        tblData.dataSource = self
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", " + "Age: " + String(persons[indexPath.row].age)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        db.deleteByID(id: indexPath.row)
        DispatchQueue.main.async {
            self.persons.remove(at: indexPath.row)
            self.tblData.reloadData()
        }
    }
}
