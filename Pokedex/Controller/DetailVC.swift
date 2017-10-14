//
//  DetailVC.swift
//  Pokedex
//
//  Created by Jaskeerat Singh Bhatia on 2017-09-20.
//  Copyright © 2017 Jaskeerat Singh Bhatia. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var pokemon :Pokemon!
    @IBOutlet weak var pokeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeName.text = pokemon.name
        // Do any additional setup after loading the view.
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
