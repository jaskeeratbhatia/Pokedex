//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jaskeerat Singh Bhatia on 2017-09-10.
//  Copyright © 2017 Jaskeerat Singh Bhatia. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name : String!
    private var _pokedexId :Int!
    private var _weight : String!
    private var _height : String!
    private var _description : String!
    private var _nextEvolution : String!
    private var _nextPokemonID : String!
    private var _defense : String!
    private var _baseAttack : String!
    private var _pokemonURL : String!
    private var _type : String!
    
    
    var nextPokemonID : String{
        if _nextPokemonID == nil{
            _nextPokemonID = ""
        }
        return _nextPokemonID
    }
    
//    var nextEvolutionLevel : String{
//        if _nextEvolutionLevel == nil{
//            _nextEvolutionLevel = ""
//        }
//        return _nextEvolutionLevel
//    }
    
    var name : String{
        
        return _name
    }
    
    var pokedexId : Int{
        
        return _pokedexId
    }
    
    var weight : String{
        if _weight == nil{
            _weight = ""
        }
     return _weight
    }
    
    var height : String{
        if _height == nil{
            _height =  ""
        }
        return _height
    }
    
    var description : String{
        if _description == nil {
            _description =  ""
        }
        return _description
    }
    
    var nextEvolution : String{
        if _nextEvolution == nil{
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    
    var defense : String{
        if _defense == nil{
            _defense =  ""
        }
        return _defense
    }
    
    var baseAttack : String{
        if _baseAttack == nil{
            _baseAttack =  ""
        }
        return _baseAttack
    }
    
    var type : String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    init(name : String , pokedexId : Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(BASE_URL)\(POKE_URL)\(self._pokedexId!)/"
        print(self._pokemonURL)
    }
    
    
    func downloadPokemonDetail(completed : @escaping DownloadComplete){
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            
            print(response)
            if  let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._baseAttack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>], types.count>0{
                    self._type = types[0]["name"]?.capitalized
                    
                    if types.count > 1 {
                        for index in 1..<types.count{
                            self._type! += "/\(types[index]["name"]!.capitalized)"
                        }
                    }
                }
                else{
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String,String>]{
                   if let url = descriptions[0]["resource_uri"] as? String{
                        let desc_url = BASE_URL + "\(url)"
                    Alamofire.request(desc_url).responseJSON(completionHandler: { (response) in
                        if let desc = response.result.value as? Dictionary<String,AnyObject>{
                            if let description = desc["description"] as? String{
                                self._description = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                print(description)
                                }
                            }
                        completed()
                        })
                    }
                }
                else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>]{
                    
                    if let nextEvo = evolutions[0]["to"] as? String{
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolution = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextPokemonID = nextEvoId
                            }
                        }
                    }
                    
                }
            completed()
        }
    }
}
}
