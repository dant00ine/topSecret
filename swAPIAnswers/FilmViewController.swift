//
//  FilmViewController.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/19/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import UIKit

class FilmViewController: UITableViewController {
    
    // data array for storing tableView data -- see cellForRowAt function
    var films: [NSDictionary] = []
    
    var filmSelected: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarWarsModel.getAllFilms(completionHandler: {
            data, response, error in
            do {
                // is there a result? Continue if we can cast response to dictionary type
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    // cast results key to array for iteration
                    if let results = jsonResult["results"] as? NSArray {
                        for film in results {
                            // cast to dictionary for data extraction
                            let filmDict = film as! NSMutableDictionary
                            self.films.append(filmDict)
                        }
                    }
                }
                // async -- if we loaded the data outside of the do-catch statement
                // it would attempt to load before we had populated the 'people' array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }

        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filmSelected = films[indexPath.row]
        performSegue(withIdentifier: "filmDetails", sender: UITableViewCell.self)
        // how do I grab a controller from this controller
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsController = segue.destination as? FilmDetailsViewController
        detailsController?.film = self.filmSelected
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)

        cell.textLabel?.text = films[indexPath.row]["title"] as? String

        return cell
    }

}
