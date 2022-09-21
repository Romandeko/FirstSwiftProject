//
//  PubManager.swift
//  Yury's Favourite Pub
//
//  Created by Роман Денисенко on 9.09.22.
//

import Foundation
class PubManager {
    private init (){}
    static let shared = PubManager()
    
    var beers = [
        Beer(name: "Балтика", country: "🇷🇺", price: 1.5, remain: 150),
        Beer(name: "Аливария", country: "🇧🇾", price: 2.0, remain: 120),
        Beer(name: "Heineken", country: "🇳🇱", price: 4.25, remain: 4),
    ]
    var margin = 0.0
    var totalSold = 0.0
    func buyBeer(index:Int, volume:Double)->Double{
        if (beers[index].remain < volume){ return 0}
        beers[index].remain -= volume
        beers[index].remain = round(beers[index].remain)
        let price = volume * beers[index].price
        
        totalSold += volume
        totalSold = round(totalSold)
        
        margin += price
        margin = round(margin)
        return round(price)
        
    }
    func round(_ num :Double) -> Double {
        var result =  num * 100
        result += 0.5
        result = Double(Int(result)) / 100
        return result
    }
    func newDayMargin (){
        return margin = 0
    }
    func newDayTotalSold (){
        return  totalSold = 0
    }
    func newDayRemains(){
        for index  in 0..<beers.count{
            switch index {
            case 0:
                beers[index].remain = 150
            case 1:
                beers[index].remain = 120
            case 2:
                beers[index].remain = 4
            default: 0
                
                
            }
        }
    }
}
