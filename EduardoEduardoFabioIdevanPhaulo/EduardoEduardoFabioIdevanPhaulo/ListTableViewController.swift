//
//  ListTableViewController.swift
//  EduardoEduardoFabioIdevanPhaulo
//
//  Created by Eduardo Fernando Dias on 24/09/22.
//

import UIKit
import Firebase

class ListTableViewController: UITableViewController {
    
    private let collection = "doacaoDeBrinquedo"
    private var toysList: [ToysItem] = []
    private lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    var firestoreListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToysList()

    }
    private func loadToysList(){
        firestoreListener = firestore
            .collection(collection)
            .order(by: "nome_do_brinquedo", descending: false)
            .addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
                if let error = error{
                    print(error)
                }else{
                    guard let snapshot = snapshot else {return}
                    if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0{
                        self.showItemsFrom(snapshot: snapshot)
                    }
                }
            })
    }
    
    private func showItemsFrom(snapshot: QuerySnapshot){
        toysList.removeAll()
        for document in snapshot.documents{
            let id = document.documentID
            let data = document.data()
            let nome_do_brinquedo = data["nome_do_brinquedo"] as? String ?? "---"
            let telefone = data["telefone"] as? String ?? "---"
            let toysItem = ToysItem(id: id, nome_do_brinquedo: nome_do_brinquedo, telefone: telefone)
            toysList.append(toysItem)
        }
        tableView.reloadData()
    }
    
    private func showAlertForItem(_ item: ToysItem?){
        let alert = UIAlertController(title: "Doaçao de brinquedo", message: "Entre com o nome do brinquedo e telefone", preferredStyle: .alert)
        alert.addTextField { (textField ) in
            textField.placeholder = "Nome do Brinquedo"
            textField.text = item?.nome_do_brinquedo
        }
        alert.addTextField{ (textField) in
            textField.placeholder = "Telefone"
            textField.text = item?.telefone
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default){ (_) in
            guard let nome_do_brinquedo = alert.textFields?.first?.text, let telefone = alert.textFields?.last?.text else {return}
            let data: [String: Any] = [
                "nome_do_brinquedo": nome_do_brinquedo,
                "telefone": telefone
            ]
            
            if let item = item {
                self.firestore.collection(self.collection).document(item.id).updateData(data)
            } else {
                self.firestore.collection(self.collection).addDocument(data: data)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toysList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let toysItem = toysList[indexPath.row]
        cell.textLabel?.text = toysItem.nome_do_brinquedo
        cell.detailTextLabel?.text = toysItem.telefone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toysItem = toysList[indexPath.row]
        showAlertForItem(toysItem)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let toysItem = toysList[indexPath.row]
            firestore.collection(collection).document(toysItem.id).delete()
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        showAlertForItem(nil)
    }
    
}
