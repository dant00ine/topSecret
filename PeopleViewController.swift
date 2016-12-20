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
        let url = NSURL(string: "http://swapi.co/api/people/")
        let session = URLSession.shared
        
        // call each page of 'people' URL recursively
        self.makePeopleRequests(url: url, session: session)
    }
    
    func makePeopleRequests(url: NSURL?, session: URLSession){
        // retrieve data from url and handle with 'completionHandler' function enclosure
        let task = session.dataTask(with: url! as URL, completionHandler: {
            data, response, error in
            do {
                // Continue if we can cast response to dictionary type
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    // helper function defined below -- takes response and
                    // appends people names to the people array
                    self.parsePeople(response: jsonResult)
                    
                    // this print statement shows each page url before request
                    print("What's next? \(jsonResult["next"])")
                    
                    // if there is a url string at the 'next' key of our results page
                    // set url for next page and recurse with new url
                    if let nextPage = jsonResult["next"] as? String {
                        let url = NSURL(string: nextPage)
                        self.makePeopleRequests(url: url, session: session)
                    }
                    
                }
                // Reload data inside asynchronous function to prevent loading blank data
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            } catch {
                print("Something went wrong")
            }
        })
        // execute request task at each stage of recursion
        task.resume()
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
