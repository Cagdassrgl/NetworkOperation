//
//  ViewController.swift
//  NetworkOperation
//
//  Created by Çağdaş Sarıgil on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // kisiEkle()
        // kisiSil()
        // kisiGuncelle()
        // tumKisileriAl()
        //kisiAl()
        tumKisileriAlCodable()
    }
    
   
    func tumKisileriAlCodable() {
        
        guard let url = URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php") else { return }
                                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do {
                
                guard let res = data else {return}
                print("DEGUB PRINT ==>> \(res)")
                let response = try JSONDecoder().decode(KisiCevap.self, from: res)
                
                guard let list = response.kisiler else { return }
                
                for res in list {
                    print("DEGUB PRINT ==>> \(res.kisi_ad!)")
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func tumKisileriAl() {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php")!)
        
        request.httpMethod = "GET"
                        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                
                print(json)
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func kisiAl() {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kisi_ad=TEST"
        
        request.httpBody = postString.data(using: .utf8)
                        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                
                guard let kisiler = json["kisiler"] as? [[String: Any]] else { return }
                        
                        for kisi in kisiler {
                            print("kisi_id: \(kisi["kisi_id"]!) kisi_ad: \(kisi["kisi_ad"]!) kisi_tel: \(kisi["kisi_tel"]!) ")
                        }
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    
    func kisiEkle() {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kisi_ad=TEST&kisi_tel=5555"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("HATA")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                
                print(json)
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func kisiSil() {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kisi_id=1"
        
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("ERRORR")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                
                print(json)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
         
        
    }
    
    func kisiGuncelle() {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "kisi_id=118&kisi_ad=cagdas&kisi_tel=123"
        
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("ERRORR")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                
                print(json)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
         
        
    }
    
}

