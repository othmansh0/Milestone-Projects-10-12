//
//  ViewController.swift
//  Milestone-Projects 10-12
//
//  Created by othman shahrouri on 9/4/21.
//

import UIKit

class ViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addImage))
        
        let decoder = JSONDecoder()
        let defualts = UserDefaults.standard
        if let savedData = defualts.object(forKey: "items") as? Data {
            if let decodedData = try? decoder.decode([Item].self, from: savedData){
                items = decodedData
            }
        }
        title = "TA DA"
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as? Cell else { fatalError("Unable to typecast cell")}
        
        let item = items[indexPath.row]
        cell.caption.text = item.caption
        let imagePath = getDocumentsDirectory().appendingPathComponent(item.name)
        
        cell.userImage.image = UIImage(contentsOfFile: imagePath.path)
        return cell
        
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            let item = items[indexPath.row]
            let imagePath = getDocumentsDirectory().appendingPathComponent(item.name)
            
            
            vc.imageName = imagePath.path
            vc.imageCaption = item.caption
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    
    @objc func addImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let path = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegImage = image.jpegData(compressionQuality: 0.8){
            try? jpegImage.write(to: path)
        }
    
    
        dismiss(animated: true)

        
       
        let ac = UIAlertController(title: "Rename", message: "Type a caption", preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            guard let newCaption = ac.textFields?[0].text else {
                fatalError("fuckkkkkk")
            }
            let item = Item(name: imageName, caption: "lndblfdn")
            item.caption = newCaption
            self?.items.append(item)
          
          
            self?.tableView.reloadData()
            self?.save()
            
        }
        ac.addAction(action)
        present(ac, animated: true)
        
       
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func save(){
        let jsonEncoder = JSONEncoder()
        //converting items to data
        if let savedData = try? jsonEncoder.encode(items){
            let defaults = UserDefaults.standard
            //saving
            defaults.set(savedData, forKey: "items")
        }
        else {
            print("Failed encoding data")
        }
        
    }
    
}

