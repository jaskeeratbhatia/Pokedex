//
//  ViewController.swift
//  Pokedex
//
//  Created by Jaskeerat Singh Bhatia on 2017-09-09.
//  Copyright © 2017 Jaskeerat Singh Bhatia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemons = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        parsePokemonCSV()
        initAudio()
       
    }
    
    func initAudio()
    {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string : path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon2", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows{
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let new_pokemon = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(new_pokemon)
                
            }
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            
            let poke = pokemons[indexPath.row]
            cell.configureCell(pokemon: poke)
            return cell
        }
        
        else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    @IBAction func musicbtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.4
        }
        else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
}

