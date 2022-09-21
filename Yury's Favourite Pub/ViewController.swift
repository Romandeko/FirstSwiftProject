//
//  ViewController.swift
//  Yury's Favourite Pub
//
//  Created by Роман Денисенко on 9.09.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var beerRemains: [UILabel]!
    @IBOutlet var beerCountries: [UILabel]!
    @IBOutlet var beerNames: [UILabel]!
    @IBOutlet weak var totalSold: UILabel!
    @IBOutlet weak var margin: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in  0..<PubManager.shared.beers.count{
            beerNames[index].text=PubManager.shared.beers[index].name
            beerCountries[index].text=PubManager.shared.beers[index].country
            updateRemains( for: index)
            updateMargin()
            updateSold()
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    func updateRemains( for index:Int){
        let volume = PubManager.shared.beers[index].remain
        beerRemains[index].text = "Осталось: \n\(volume) л"
    }
    func updateMargin(){
        let newMargin = PubManager.shared.margin
        margin.text = "Выручка за день: \(newMargin)$"
    }
    func updateSold(){
        let beerSold = PubManager.shared.totalSold
        totalSold.text = "Продано пива: \(beerSold) л"
        
    }
    
    @IBAction func buyBeer(_ sender: UIButton) {
        let tag = sender.tag
        var beerIndex : Int
        var volume : Double
        switch tag % 10 {
        case 0:
            volume = 0.33
        case 1:
            volume = 0.5
        case 2:
            volume = 1.0
        default:
            volume = 0
        }
        switch tag / 10 {
        case 0:
            beerIndex = 0
        case 1:
            beerIndex = 1
        case 2:
            beerIndex = 2
        default:
            beerIndex = -1
        }
        
        let price = PubManager.shared.buyBeer(index: beerIndex, volume: volume)
        print (price)
        showAlert(withPrice: price,index: beerIndex)
        print ("Beer \(beerIndex) volume \(volume)")
        updateRemains(for: beerIndex)
        updateSold()
        updateMargin()
    }
    
    @IBAction func startNewDay(_ sender: UIButton) {
        showAlert(withTitle: "Начался новый день", withMessage: "За сутки продано: \(PubManager.shared.totalSold) л пива на сумму \(PubManager.shared.margin)$.")
        PubManager.shared.newDayMargin()
        margin.text = "Выручка за день: \(PubManager.shared.margin)$"
        PubManager.shared.newDayTotalSold()
        totalSold.text = "Продано пива: \(PubManager.shared.totalSold) л"
        PubManager.shared.newDayRemains()
        for index in 0..<PubManager.shared.beers.count{
            let counter = PubManager.shared.beers[index].remain
            beerRemains[index].text = "Осталось: \n\(counter) л"
        }
        
    }
    func showAlert(withPrice price:Double,index:Int){
        if price < 0.01{showAlert(withTitle: "Неудачная покупка.Осталось: \(PubManager.shared.beers[index].remain) л", withMessage: "Юра скупил всё пиво")
            
        } else{ showAlert(withTitle: "Удачная покупка", withMessage: "Сумма покупки: \(price)$")
            
        }
        
    }
    func showAlert(withTitle title:String, withMessage message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}




