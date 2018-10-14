//
//  ViewController.swift
//  WTest
//
//  Created by Mário Rodrigues on 10/10/2018.
//  Copyright © 2018 Mário Rodrigues. All rights reserved.
//

import UIKit
import CoreData

class PostalCodeTableViewController: UITableViewController {
    
    let cellID = "cell"
//    var postalCode: PostalCodes? = nil
    var codesArray = [CDPostalCode]()
    var optionalURL: URL? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        setupTableView()
        setupUI()
        fetchPostalCodes()
        loadItems()
        //generateDummyPostalCodes()
    }
    
    // MARK: - Helper Methods
    /*********************************************/
    
    func generateDummyPostalCodes(){
//        codesArray.append(PostalCodes(locationName: "Torre da Marinha", postalNumber: "2840", postalExtension: "403"))
//        codesArray.append(PostalCodes(locationName: "Aldeia de Paio Pires", postalNumber: "2840", postalExtension: "102"))
    }
    
    func fetchPostalCodes(){
        
        optionalURL = URL(string: "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv")
        
        guard let url = optionalURL else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                // Parse CSV and separate values by comma
                let contents = try String(contentsOf: url, encoding: .utf8)
                let rows = contents.components(separatedBy: "\n")
                
                for row in rows {
                    
                    let columns = row.components(separatedBy: ",")
                    
                    guard let location = columns[safe: 3] else {return}
                    guard let postalCode = columns[safe: 14] else {return}
                    guard let postalCodeExt = columns[safe: 15] else {return}
                    
                    // self.postalCode = PostalCodes(locationName: location, postalNumber: postalCode, postalExtension: postalCodeExt)
                    // self.codesArray.append(self.postalCode!)
                    
                    
                    let newPostalCode = CDPostalCode(context: self.context)
                    newPostalCode.location = location
                    newPostalCode.postalNumber = postalCode
                    newPostalCode.postalExtension = postalCodeExt
                    
                    self.codesArray.append(newPostalCode)
                    self.saveItems()
                }
                
                
                
            }catch let CSVError{
                print("Error serializing CSV: \(CSVError)")
            }
            }.resume()
        
    }
    
    func setupTableView(){
        tableView.rowHeight = 50
        tableView.register(ListCell.self, forCellReuseIdentifier: cellID)
    }
    
    func setupUI(){
        navigationItem.title = "Postal Codes"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - TableView Delegate Methods
    /*********************************************/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ListCell
        
        guard let locationName = codesArray[indexPath.row].location else {return cell}
        guard let postalNumber = codesArray[indexPath.row].postalNumber else {return cell}
        guard let postalExtension = codesArray[indexPath.row].postalExtension else {return cell}
        
        cell.postalCodeLabel.text = "\(postalNumber) - \(postalExtension), \(locationName)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(codesArray[indexPath.row]) Row Selected")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Model Manipulation Methods
    /*********************************************/
    
    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadItems(){
        let request: NSFetchRequest<CDPostalCode> = CDPostalCode.fetchRequest()
        do {
            codesArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension Collection {
    
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
