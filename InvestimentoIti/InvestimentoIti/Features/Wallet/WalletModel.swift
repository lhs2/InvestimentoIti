//
//  WalletModel.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit
import CoreData

public struct Segue {
    static let detail = "segueDetail"
    static let form = "segueForm"
}

class WalletModel {
    weak var delegate: NSFetchedResultsControllerDelegate?
    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        }
        return appDelegate.persistentContainer.viewContext
        
    }
    
    var totalInvestiments: Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Investiment> = {
        let fetchRequest: NSFetchRequest<Investiment> = Investiment.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "active", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = delegate
        
        return fetchedResultsController
    }()
    
    func getInvestimentAt(_ indexPath: IndexPath) -> Investiment {
        fetchedResultsController.object(at: indexPath)
    }
    
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
}
