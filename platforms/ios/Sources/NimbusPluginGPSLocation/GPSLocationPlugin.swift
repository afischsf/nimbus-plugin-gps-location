//
// Copyright (c) 2020, Salesforce.com, inc.
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
//

import Foundation
import CoreLocation
import Combine
import Nimbus

// :( NSObject required for CLLocationManagerDelegate
public class GPSLoationPlugin: NSObject {
    
    let locationSubject = CurrentValueSubject<UserLocation?, Never>(.none)
    var disposable: Cancellable? = .none
    
    var authorizationStatus = CLAuthorizationStatus.notDetermined
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.setupManager()
    }

    deinit {
        locationSubject.send(completion: .finished)
        disposable?.cancel()
    }
    
    func isAuthorized() -> Bool {
        return self.authorizationStatus == .authorizedAlways
    }
    
    func startLocationUpdate() {
        if self.isAuthorized() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocationUpdates() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func currentLocation() -> UserLocation {
        if let location = locationSubject.value {
            return location
        } else if let location = self.locationManager.location {
            return .init(location: location)
        }
        return .unknown
    }
    
    func locationUpdate(callback: @escaping (UserLocation) -> Void) {
        disposable = locationSubject.compactMap { $0 }
            .sink(receiveValue: callback)
    }
    
    func setupManager() {
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 30
        //must include the UIBackgroundModes key (with the location value) in their app’s Info.plist
        //file and set the value of this property to true to allow background GPS updates
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
    }
}

extension GPSLoationPlugin: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //the last location is always the most current
        let location = locations.map(UserLocation.init).last
        locationSubject.send(location)
    }
}

extension GPSLoationPlugin: Plugin {
    public func bind<C>(to connection: C) where C : Connection {
        connection.bind(self.isAuthorized, as: "isAuthorized")
        connection.bind(self.startLocationUpdate, as: "startLocationUpdate")
        connection.bind(self.stopLocationUpdates, as: "stopLocationUpdates")
        connection.bind(self.currentLocation, as: "currentLocation")
        connection.bind(self.locationUpdate, as: "locationUpdate")
    }
}
