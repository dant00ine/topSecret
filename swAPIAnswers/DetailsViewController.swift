//
//  DetailsViewController.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/21/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    var person: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(person)
        nameLabel.text = person["name"] as? String
//        speciesLabel.text = person["species"] as? String
        genderLabel.text = person["gender"] as? String
        birthLabel.text = person["birth_year"] as? String
        massLabel.text = person["mass"] as? String
        // Do any additional setup after loading the view.
        
        let species = person["species"] as! NSArray
        
        print(type(of: species))
        
        StarWarsModel.getSpecies(url: species[0] as! String, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    DispatchQueue.main.async{
                        self.speciesLabel.text = jsonResult["name"] as? String
                    }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
