//
// Copyright (c) 2020, Salesforce.com, inc.
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
//

import Foundation
import CoreLocation

public struct UserLocation: Encodable {
    static let unknown = UserLocation(latitude: 0, longitude: 0)
    
    let latitude: Double
    let longitude: Double
}

extension UserLocation {
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.latitude
    }
}
