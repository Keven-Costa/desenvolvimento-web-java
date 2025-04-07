package com.meuprojeto.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/CalcularTintaServlet")
public class CalcularTintaServlet extends HttpServlet {
    
    // Rendimento padrão: 1 litro para cada 6m²
    private static final double RENDIMENTO_POR_LITRO = 6.0;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Recebe parâmetros do formulário
            double metrosQuadrados = Double.parseDouble(request.getParameter("metrosQuadrados"));
            String tipoSuperficie = request.getParameter("tipoSuperficie"); // Pode ser null
            
            // Verifica se checkbox de duas demãos foi marcado
            boolean duasDemaoes = "on".equals(request.getParameter("duasDemaoes")); 
            int numDemaoes = duasDemaoes ? 2 : 1;
            
            // 2. Realiza o cálculo
            double litrosNecessarios = calcularLitrosTinta(metrosQuadrados, tipoSuperficie, numDemaoes);
            
            // 3. Prepara atributos para a JSP
            request.setAttribute("metrosQuadrados", String.format("%.2f", metrosQuadrados));
            request.setAttribute("tipoSuperficie", tipoSuperficie);
            request.setAttribute("demaoes", numDemaoes);
            request.setAttribute("litrosNecessarios", String.format("%.2f", litrosNecessarios));
            
            // 4. Encaminha para a JSP
            request.getRequestDispatcher("/WEB-INF/views/resultado.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Por favor, insira um valor numérico válido para a área");
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }
    
    private double calcularLitrosTinta(double metrosQuadrados, String tipoSuperficie, int demaoes) {
        // Fator de ajuste baseado no tipo de superfície
        double fator = 1.0; // Padrão para parede
        
        if (tipoSuperficie != null) {
            switch(tipoSuperficie.toLowerCase()) {
                case "madeira": fator = 1.15; break; // +15% de consumo
                case "metal": fator = 1.1; break;    // +10% de consumo
            }
        }
        
        // Cálculo considerando demãos
        double litrosBase = (metrosQuadrados / RENDIMENTO_POR_LITRO) * fator;
        double litrosTotal = litrosBase * (demaoes == 2 ? 1.8 : 1); // 2 demãos = +80%
        
        // Arredonda para 2 casas decimais
        return Math.round(litrosTotal * 100) / 100.0;
    }
}