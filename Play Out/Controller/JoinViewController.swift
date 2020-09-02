//
//  JoinViewController.swift
//  Play Out
//
//  Created by Chris Carbajal on 8/27/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

enum EventError: Error{
    case noData
    case canNotProcessData
}
class JoinViewController: UIViewController {
 
    @IBOutlet weak var eventsTable: UITableView!
    
    var events : [Event] = [Event(id: 1, description: "Bring some water and be ready to run!", location: "Phoenix", time: "7pm", sport: "Soccer", peopleNeeded: 3) ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTable.delegate = self
        eventsTable.dataSource = self
        
//        getEvents{[weak self] result in
//            switch result{
//            case .failure(let error):
//                             print(error)
//            case .success(let events):
//                self?.events = events
//            }
//        }
        
        // Do any additional setup after loading the view.
    }
//    
//    func fetchData() {
//      FirestoreReferenceManager.eventsCollection.addSnapshotListener { (querySnapshot, error) in
//        guard let documents = querySnapshot?.documents else {
//          print("No documents")
//          return
//        }
//          
//        self.events = documents.compactMap { queryDocumentSnapshot -> Event? in
//            return try? queryDocumentSnapshot.data(as: Event.self)
//        }
//      }
//    }
//    
//    func getEvents(completion: @escaping(Result <[Event], EventError >)  -> Void){
//        FirestoreReferenceManager.eventsCollection.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                let events = querySnapshot?.documents.com
//
//
//                let riddles = riddleModel.riddles
//                               print(riddleModel)
//                               completion(.success(events))
//
//                for document in querySnapshot!.documents {
//
//
//                    let dict = querySnapshot?.documents.compactMap({$0.data()}) ?? []
//
//
//
//
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//
//
//    }
//
    
//    func getEvents(at path: String, completion: @escaping (([Event]) -> ())) {
//        let data = Firestore.firestore().collection(path)
//        data.getDocuments { (snapshot, error) in
//            let dictionaries = snapshot?.documents.compactMap({$0.data()}) ?? []
//            let addresses = dictionaries.compactMap({Event(from: $0)})
//            completion(addresses)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//used to handle interactions of cells
extension JoinViewController: UITableViewDelegate{
    //handle tapping on row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "RiddleDetailViewController") as! RiddleDetailViewController
//
//        present(vc, animated: true, completion: nil)
    }
    
}
extension JoinViewController: UITableViewDataSource{
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventTableViewCell

        cell.sportLabel.text = events[indexPath.row].sport
        cell.descriptionLabel.text =  events[indexPath.row].description

        return cell
          
      }
}
