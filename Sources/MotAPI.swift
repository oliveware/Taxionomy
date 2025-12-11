//
//  MotAPI.swift
//  Taxionomy
//
//  Created by Herve Crespel on 11/12/2025.
//
var mot = Mot("chose", "choses", .f)
var nompropre = "Boris Goudounov"
var ligne = "une ligne courte"

public struct MotAPI {
    Form {
        VStack {
            TabView(selection: $simple) {
                MotView($mot)
                    .tabItem { Text("mot") }.tag(0)
                NomPropre($nompropre, "nom propre", "nom propre" )
                    .tabItem { Text("nom propre") }.tag(1)
                Line(input:$nompropre)
                    .tabItem { Text("ligne") }.tag(2)
            }
            
            HStack {
                Text("Mot").font(.title)
                    .frame(width:150)
                MotView($mot).frame(width:400)
                    .padding(10).border(.gray).cornerRadius(3)
            }.frame(width:600, alignment:.leading)
                .padding(10)
            HStack {
                Text("NomPropre").font(.title)
                    .frame(width:150)
                NomPropre($nompropre, "compositeur", "aide" )
                    .frame(width:400)
                    .padding(10).border(.gray).cornerRadius(3)
            }.frame(width:600, alignment:.leading)
                .padding(10)
            HStack {
                Text("Line").font(.title)
                    .frame(width:150)
                Line(input:$ligne)
                    .frame(width:400)
                    .padding(10).border(.gray).cornerRadius(3)
            }.frame(width:600, alignment:.leading)
                .padding(10)
        }
    }
}
