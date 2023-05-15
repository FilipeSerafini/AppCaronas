//
//  TimeSelectionView.swift
//  AppCaronas
//
//  Created by Gustavo Zahorcsak Matias Silvano on 13/05/23.
//

import SwiftUI

struct TimeSelectionView: View {
    @State var selectedDateOne = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!
    @State var selectedDateTwo = Calendar.current.date(bySettingHour: 17, minute: 30, second: 0, of: Date())!
    
    var body: some View {
        HStack {
            DatePicker("Select Time", selection: $selectedDateOne, displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .labelsHidden()
            Text("-")
            DatePicker("Select Time", selection: $selectedDateTwo, displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .labelsHidden()
        }
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView()
    }
}
