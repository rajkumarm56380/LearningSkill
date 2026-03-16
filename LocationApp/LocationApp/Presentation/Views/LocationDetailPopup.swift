//
//  LocationDetailPopup.swift
//  LocationApp
//
//

import SwiftUI

struct LocationDetailPopup: View {

    let location: LocationModel

    var body: some View {

        VStack {
            Spacer()
            VStack(spacing: 10) {

                Text(location.name)
                    .font(.headline)
                Text(location.address)
                    .font(.subheadline)
                HStack{
                    Text("Lat: \(location.coordinate.latitude)")
                    Text("Lon: \(location.coordinate.longitude)")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)

        }
        .padding()
    }
}
