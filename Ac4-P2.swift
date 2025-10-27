//
//  Ac4-P2.swift
//  HolaMundo
//
//  Created by WIN603 on 08/10/25.
//

import SwiftUI

struct Ac4_P2: View {
    @State private var todasBloqueadas = false
    @State private var tarjetaPreferida: Int? = nil
    @State private var mostrarAlerta = false
    @State private var nombreBancoSeleccionado = ""
    
    let bancos = ["NU", "Banamex", "Hey", "Stori", "Mercado Pago"]
    
    var body: some View {
        VStack {
            Text("Tarjeta de Crédito")
                .font(.title)
                .padding(.top)
            
            // Toggle para bloquear/desbloquear todas
            Toggle(isOn: $todasBloqueadas) {
                Text("Bloquear todas las tarjetas")
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    // GroupBox cuando están bloqueadas
                    if todasBloqueadas {
                        GroupBox {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.red)
                                Text("Tarjetas congeladas")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    
                    Tarjeta(
                        titulo: "NU",
                        imagen: "nu",
                        wifi: "señal",
                        numero: "4152 4567 8904 5678",
                        nombre: "Sara Segura Lara",
                        boton: todasBloqueadas ? "lock.fill" : "lock.open.fill",
                        esBloqueada: todasBloqueadas,
                        esPreferida: tarjetaPreferida == 0,
                        alPresionarPreferida: {
                            tarjetaPreferida = 0
                            nombreBancoSeleccionado = "NU"
                            mostrarAlerta = true
                        }
                    )
                    .tarjetaEstilo(color: .black)
                    
                    Tarjeta(
                        titulo: "Banamex",
                        imagen: "banamex",
                        wifi: "señal",
                        numero: "4152 4567 8904 5676",
                        nombre: "Valeria Segura Lara",
                        boton: todasBloqueadas ? "lock.fill" : "lock.open.fill",
                        esBloqueada: todasBloqueadas,
                        esPreferida: tarjetaPreferida == 1,
                        alPresionarPreferida: {
                            tarjetaPreferida = 1
                            nombreBancoSeleccionado = "Banamex"
                            mostrarAlerta = true
                        }
                    )
                    .tarjetaEstilo(color: .blue, offset: -10)
                    
                    Tarjeta(
                        titulo: "Hey",
                        imagen: "hey",
                        wifi: "señal",
                        numero: "4152 4567 8904 5675",
                        nombre: "Valeria Segura Lara",
                        boton: todasBloqueadas ? "lock.fill" : "lock.open.fill",
                        esBloqueada: todasBloqueadas,
                        esPreferida: tarjetaPreferida == 2,
                        alPresionarPreferida: {
                            tarjetaPreferida = 2
                            nombreBancoSeleccionado = "Hey"
                            mostrarAlerta = true
                        }
                    )
                    .tarjetaEstilo(color: .yellow, offset: -20)
                    
                    Tarjeta(
                        titulo: "Stori",
                        imagen: "stori",
                        wifi: "señal",
                        numero: "4152 4567 8904 5673",
                        nombre: "Valeria Segura Lara",
                        boton: todasBloqueadas ? "lock.fill" : "lock.open.fill",
                        esBloqueada: todasBloqueadas,
                        esPreferida: tarjetaPreferida == 3,
                        alPresionarPreferida: {
                            tarjetaPreferida = 3
                            nombreBancoSeleccionado = "Stori"
                            mostrarAlerta = true
                        }
                    )
                    .tarjetaEstilo(color: .green, offset: -30)
                    
                    Tarjeta(
                        titulo: "Mercado Pago",
                        imagen: "mp",
                        wifi: "señal",
                        numero: "4152 4567 8904 5672",
                        nombre: "Valeria Segura Lara",
                        boton: todasBloqueadas ? "lock.fill" : "lock.open.fill",
                        esBloqueada: todasBloqueadas,
                        esPreferida: tarjetaPreferida == 4,
                        alPresionarPreferida: {
                            tarjetaPreferida = 4
                            nombreBancoSeleccionado = "Mercado Pago"
                            mostrarAlerta = true
                        }
                    )
                    .tarjetaEstilo(color: .cyan, offset: -40)
                }
            }
        }
        .alert("Método de pago preferido", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Tarjeta de \(nombreBancoSeleccionado) ha sido establecida como método preferido de pago exitosamente")
        }
    }
}

struct Tarjeta: View {
    let titulo: String
    let imagen: String
    let wifi: String
    let numero: String
    let nombre: String
    let boton: String
    let esBloqueada: Bool
    let esPreferida: Bool
    let alPresionarPreferida: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(titulo)
                    .foregroundColor(.white)
                    .font(.title)
                
                Image(imagen)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipped()
                    .cornerRadius(10)
                
                Spacer()
                
                // Botón de tarjeta preferida (estrella)
                Button(action: {
                    alPresionarPreferida()
                }) {
                    Image(systemName: esPreferida ? "star.fill" : "star")
                        .foregroundColor(esPreferida ? .yellow : .white)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
                
                Image(wifi)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipped()
                    .cornerRadius(10)
            }
            
            Text(numero)
                .foregroundColor(.white)
                .font(.title2)
            
            Text(nombre)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: boton)
                    .foregroundColor(.white)
                
                Text(esBloqueada ? "Bloqueada" : "Activa")
                    .foregroundColor(.white)
                
                Spacer()
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 20, height: 20)
                    .offset(x: -15)
            }
        }
        .opacity(esBloqueada ? 0.6 : 1.0)
    }
}

// MARK: - ViewModifier
struct TarjetaEstilo: ViewModifier {
    let color: Color
    let offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: 350)
            .padding()
            .background(color)
            .cornerRadius(20)
            .shadow(radius: 9)
            .offset(y: offset)
    }
}

// MARK: - Extension
extension View {
    func tarjetaEstilo(color: Color, offset: CGFloat = 0) -> some View {
        modifier(TarjetaEstilo(color: color, offset: offset))
    }
}

#Preview {
    Ac4_P2()
}
