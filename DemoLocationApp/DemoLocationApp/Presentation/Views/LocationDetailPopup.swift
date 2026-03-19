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

                VStack {
                    Text("Location Details")
                        .fontWeight(.bold)
                        .accessibilityIdentifier("popup_title")

                    Text(location.name)
                        .accessibilityIdentifier("popup_name")

                    Text(location.address ?? "NA")
                        .accessibilityIdentifier("popup_address")
                }

            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
            .accessibilityIdentifier("location_popup")
        }
        .padding()
    }
}
