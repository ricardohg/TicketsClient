//
//  EventsTableViewController.swift
//  TicketsAPP
//
//  Created by ricardo hernandez  on 8/13/18.
//  Copyright © 2018 Ricardo. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {

    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    private func loadData() {
        
        guard let url = URL(string: "http://localhost:8080/events") else {
            assertionFailure("wrong url")
            return
        }
        
        //let session = URLSession(configuration: URLSessionConfiguration.default)
        let client = HTTPClient(session: URLSession.shared)
        client.get(url: url, parameters: nil) { [weak self] (data, error) in
            
            guard let data = data, let s = self else { return }
            
            do {
                let decoder = JSONDecoder()
                let eventsJson = try decoder.decode(EventResponse.self, from: data)
                s.events = eventsJson.events
                DispatchQueue.main.async {
                    s.tableView.reloadData()
                }
                
            }
            catch {
                print(error)
            }
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = events[indexPath.row]
        cell.setup(with: event)
        return cell
    }

}
