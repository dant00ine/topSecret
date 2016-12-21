//
//  PeopleViewController.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/19/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    // our tableView data -- see cellForRowAt function
    var people = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pepare request information
        var url = URL(string: "http://swapi.co/api/people/")
        let session = URLSession.shared
        
        let myGroup = DispatchGroup()
        
        for i in 0...8{
            let task = session.dataTask(with:url!, completionHandler: {
                data, response, error in
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.parsePeople(response: jsonResult)
                        
                        let pageNumber = String(i)
                        url = URL(string: "http://swapi.co/api/people/?page="+pageNumber)
                        print(url ?? "no url")
                        
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }
                } catch {
                    print(error)
                }
            })
            myGroup.enter()
            task.resume()
            myGroup.leave()
        }
        myGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests")
        })
    }
    
    // parse people casts results to array for iteration
    func parsePeople(response: NSDictionary){
        if let results = response["results"] as? NSArray {
            for person in results {
                let personDict = person as! NSDictionary
                self.people.append(personDict["name"]! as! String)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source: people

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }

}
