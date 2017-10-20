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
    
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvolutiontxt: UILabel!
    @IBOutlet weak var baseAttacktxt: UILabel!
    @IBOutlet weak var pokedexIDtxt: UILabel!
    @IBOutlet weak var defensetxt: UILabel!
    @IBOutlet weak var weighttxt: UILabel!
    @IBOutlet weak var heighttxt: UILabel!
    @IBOutlet weak var typetxt: UILabel!
    @IBOutlet weak var biotxt: UILabel!
    @IBOutlet weak var bioImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeName.text = pokemon.name.capitalized
        
        
        
        pokemon.downloadPokemonDetail {
            //MARK: Code which runs after the network call
            self.updateUI()
        }
    }

    
    func updateUI()
    {
        let img  = UIImage(named : "\(pokemon.pokedexId)")
        pokedexIDtxt.text = "\(pokemon.pokedexId)"
        weighttxt.text = pokemon.weight
        heighttxt.text = pokemon.height
        defensetxt.text = pokemon.defense
        baseAttacktxt.text = pokemon.baseAttack
        bioImage.image = img
        currentEvoImg.image = img
        typetxt.text = pokemon.type
        biotxt.text = pokemon.description
        if pokemon.nextPokemonID == "" {
            nextEvolutiontxt.text = "No Evolution"
            nextEvoImg.isHidden = true
        }
        else{
            nextEvolutiontxt.text = "Next Evolution : \(pokemon.nextEvolution)"
            nextEvoImg.image = UIImage(named : "\(pokemon.nextPokemonID)")
        }
        
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

    @IBAction func backPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
