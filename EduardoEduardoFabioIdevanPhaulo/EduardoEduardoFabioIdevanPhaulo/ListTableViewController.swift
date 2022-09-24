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
        print("entrei na loadToysList")
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
        print("entrei na funcao")
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
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    

    
    @IBAction func addItem(_ sender: Any) {
    }
    
}
