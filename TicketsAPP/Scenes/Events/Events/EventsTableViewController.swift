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
                
        Event.getEvents(limit: 2, offset: 0) {  [weak self] (events) in
            guard let events = events, let s = self else { return }
            s.events = events
            DispatchQueue.main.async {
                s.tableView.reloadData()
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
