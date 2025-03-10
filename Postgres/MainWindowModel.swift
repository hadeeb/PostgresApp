//
//  MainWindowModel.swift
//  Postgres
//
//  Created by Chris on 17/08/2016.
//  Copyright © 2016 postgresapp. All rights reserved.
//

import Cocoa

class MainWindowModel: NSObject {
	@objc dynamic var serverManager = ServerManager.shared
	@objc dynamic var selectedServerIndices = IndexSet() {
		didSet {
			if selectedServerIndices != oldValue {
				firstSelectedServer?.updateServerStatus()
				firstSelectedServer?.checkReindexWarning()
			}
		}
	}
	
	var firstSelectedServer: Server? {
		guard let selIdx = selectedServerIndices.first else { return nil }
		return serverManager.servers[selIdx]
	}
	
	func removeSelectedServer() {
		guard let selIdx = selectedServerIndices.first else { return }
		serverManager.servers.remove(at: selIdx)
		
		if selIdx > 0 {
			selectedServerIndices = IndexSet(integer: selIdx-1)
		} else if !serverManager.servers.isEmpty {
			selectedServerIndices = IndexSet(integer: 0)
		} else {
			selectedServerIndices = IndexSet()
		}
	}
}



protocol MainWindowModelConsumer {
	var mainWindowModel: MainWindowModel! { get set }
}
