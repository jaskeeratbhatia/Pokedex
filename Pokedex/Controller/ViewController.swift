//
//  ViewController.swift
//  Pokedex
//
//  Created by Jaskeerat Singh Bhatia on 2017-09-09.
//  Copyright © 2017 Jaskeerat Singh Bhatia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    var isSearchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        parsePokemonCSV()
        searchBar.delegate = self
        searchBar.returnKeyType = .done
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "")
        {
            isSearchActive = false
            view.endEditing(true)
        }
        else
        {
            isSearchActive = true
            let searchItem = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.lowercased().range(of: searchItem) != nil})
        }
    
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon : Pokemon
        if isSearchActive{
            pokemon = filteredPokemons[indexPath.row]
        }
        else{
            pokemon = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "DetailVC", sender: pokemon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC"
        {
            if let detailVC = segue.destination as? DetailVC{
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            if isSearchActive{
                let poke = filteredPokemons[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            else{
                let poke = pokemons[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
        }
        
        else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearchActive{
            return filteredPokemons.count
        }
        
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

