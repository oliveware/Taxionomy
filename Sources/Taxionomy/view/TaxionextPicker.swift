//
//  SwiftUIView.swift
//
//
//  Created by Herve Crespel on 24/04/2024.
//

import SwiftUI

public struct TaxionextPicker: View {
    @Binding var selected: Taxion.Ext?
    
    init(_ ext:Binding<Taxion.Ext?>) {
        _selected = ext
    }
    
    public var body: some View {
        HStack {

            Picker("extension", selection:$selected) {
                ForEach (Taxion.extensions) { item in
                    Text(item.id).tag(item)
                }
            }

            if selected != nil {
                Button(action:{
                    selected = nil
                })
                {Image(systemName: "trash")}
            }
        }
        
    }
}

struct TaxionextPreview: View  {
    @State var data : Taxion.Ext?
    var body: some View {
        TaxionextPicker($data)
                .frame(width:250, height:150)
    }
}

#Preview() {
    TaxionextPreview()
}
