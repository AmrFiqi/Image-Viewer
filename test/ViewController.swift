//
//  ViewController.swift
//  test
//
//  Created by Amr El-Fiqi on 31/12/2022.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Controller"
        navigationController?.navigationBar.prefersLargeTitles=true
        // Do any additional setup after loading the view.
        
        let fm = FileManager.default
        let path =  Bundle.main.resourcePath!
        
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix("nssl"){
                    self?.pictures.append(item)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures.sorted()[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.numOfImages = pictures.count
            vc.currentImage = indexPath.row+1
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}


