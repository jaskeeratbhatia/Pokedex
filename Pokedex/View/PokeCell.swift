//
//  PokeCell.swift
//  Pokedex
//
//  Created by Jaskeerat Singh Bhatia on 2017-09-10.
//  Copyright © 2017 Jaskeerat Singh Bhatia. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nametxt: UILabel!
    
    var pokemon :Pokemon!
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        self.thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        self.nametxt.text = self.pokemon.name.capitalized
    }
    
    
}
