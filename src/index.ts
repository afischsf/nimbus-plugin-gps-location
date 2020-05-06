/*
 *
 * Copyright (c) 2020, Salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 *
 */

export interface UserLocation {
    latitude: number;
    longitude: number;
}

export interface GPSLocation  {
    isAuthorized(): boolean;

    currentLocation(): UserLocation;

    startLocationUpdates(): void;

    stopLocationUpdates(): void;

    locationUpdates(
        callback: (location: UserLocation) => void
    );
}