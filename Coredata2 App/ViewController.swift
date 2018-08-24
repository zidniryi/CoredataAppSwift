//
//  ViewController.swift
//  Coredata2 App
//
//  Created by hint on 24/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var etName: UITextField!
    
    @IBOutlet weak var etAdress: UITextField!
    @IBOutlet weak var tableviewcontroller: UITableView!
    var context : NSManagedObjectContext?
    
    var dataUser = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//Get App Delegate
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        context = appdelegate?.persistentContainer.viewContext
//        Get entity
        
        getDataLocal()
     
    }
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        Fungsi get data local
        
        func getDataLocal(){
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName : "User" )
            
            dataUser.removeAll()
            
            do {
            
                
            let dataResult = try context?.fetch(request)
                for data in (dataResult as! [NSManagedObject]) {
                
                let name = data.value(forKey : "name")
                let address = data.value(forKey : "address")
                
                let user = Users(name: name as! String, address: address as! String)
                    
                    dataUser.append(user)
                    
                   tableviewcontroller.reloadData()
                }
            
             }catch{
                print("nil data")
            }
            
            
            
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataUser[indexPath.row].name
        cell?.detailTextLabel?.text = dataUser[indexPath.row].address
        
        return cell!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonSave(_ sender: Any) {
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context!)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context!)
        
        
        //        Insert inptan user ke entity
        newUser.setValue(etName.text, forKey : "name")
        newUser.setValue(etAdress.text, forKey : "address")
        
        do {
            //            Save Ke DB
            try context?.save()
        }catch{
            print("Gagal Input")
        }
        
    
}

}
