<%-- 
    Document   : resultado
    Created on : 7 de abr. de 2025, 15:34:36
    Author     : keven
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cálculo de Tinta</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!--Código CSS-->
    <style>
        .calc-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .btn-calculate {
            background-color: #4b79cf;
            border: none;
            padding: 10px 25px;
            transition: all 0.3s;
        }
        .btn-calculate:hover {
            background-color: #3a5f9e;
            transform: translateY(-2px);
        }
    </style>
    
    <body class="bg-light">
    <div class="container py-4">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h2 class="h4 mb-0">Resultado do Cálculo de Tinta</h2>
            </div>
            <div class="card-body">
                <% 
                String areaParametro;
                float area = 0F;

                areaParametro = request.getParameter("metrosQuadrados");
                area = Float.parseFloat(areaParametro);

                // Adiciona 10% de folga
                double areaComFolga = area * 1.1;

                // Calcula a quantidade de litros necessária (1L para cada 6m²)
                double litrosNecessarios = areaComFolga / 6;

                // Opção 1: Apenas latas de 18L
                int latas18L = (int) Math.ceil(litrosNecessarios / 18);
                double precoLatas = latas18L * 80.0;

                // Opção 2: Apenas galões de 3.6L
                int galoes3_6L = (int) Math.ceil(litrosNecessarios / 3.6);
                double precoGaloes = galoes3_6L * 25.0;

                // Opção 3: Mistura de latas e galões (otimizada para menor preço)
                int latas = (int) (litrosNecessarios / 18);
                double litrosRestantes = litrosNecessarios % 18;
                int galoes = (int) Math.ceil(litrosRestantes / 3.6);

                // Verifica se compensa comprar uma lata extra em vez de vários galões
                if (litrosRestantes > 0 && galoes * 25 > 80) {
                    latas++;
                    galoes = 0;
                }

                double precoMisto = (latas * 80.0) + (galoes * 25.0);
                %>

                <div class="mb-4">
                    <h3 class="h5">Informações Básicas</h3>
                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item"><strong>Área informada:</strong> <%= area %> m²</li>
                        <li class="list-group-item"><strong>Área com folga (10%):</strong> <%= String.format("%.2f", areaComFolga) %> m²</li>
                        <li class="list-group-item"><strong>Tinta necessária:</strong> <%= Math.ceil(litrosNecessarios) %> litros</li>
                    </ul>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="card h-100 <%= precoLatas == Math.min(Math.min(precoLatas, precoGaloes), precoMisto) ? "border-success" : "" %>">
                            <div class="card-header bg-info text-white">
                                <h4 class="h6 mb-0">Apenas Latas (18L)</h4>
                            </div>
                            <div class="card-body">
                                <p class="card-text"><strong>Quantidade:</strong> <%= latas18L %> latas</p>
                                <p class="card-text"><strong>Preço total:</strong> R$ <%= String.format("%.2f", precoLatas) %></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <div class="card h-100 <%= precoGaloes == Math.min(Math.min(precoLatas, precoGaloes), precoMisto) ? "border-success" : "" %>">
                            <div class="card-header bg-info text-white">
                                <h4 class="h6 mb-0">Apenas Galões (3.6L)</h4>
                            </div>
                            <div class="card-body">
                                <p class="card-text"><strong>Quantidade:</strong> <%= galoes3_6L %> galões</p>
                                <p class="card-text"><strong>Preço total:</strong> R$ <%= String.format("%.2f", precoGaloes) %></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 mb-3">
                        <div class="card h-100 <%= precoMisto == Math.min(Math.min(precoLatas, precoGaloes), precoMisto) ? "border-success" : "" %>">
                            <div class="card-header bg-info text-white">
                                <h4 class="h6 mb-0">Mistura Otimizada</h4>
                            </div>
                            <div class="card-body">
                                <p class="card-text"><strong>Latas:</strong> <%= latas %></p>
                                <p class="card-text"><strong>Galões:</strong> <%= galoes %></p>
                                <p class="card-text"><strong>Preço total:</strong> R$ <%= String.format("%.2f", precoMisto) %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="alert alert-info mt-3">
                    <strong>Observação:</strong> A opção com borda verde é a mais econômica.
                </div>
            </div>
        </div>
    </div>

</body>
</html>
    
    
<!--</head>
    <body>
        
            <div class="container">
                    
                String areaParametro;
                float area = 0F;

                areaParametro = request.getParameter("metrosQuadrados");
                area = Float.parseFloat(areaParametro);


            // Adiciona 10% de folga
            double areaComFolga = area * 1.1;

            // Calcula a quantidade de litros necessária (1L para cada 6m²)
            double litrosNecessarios = areaComFolga / 6;

            // Opção 1: Apenas latas de 18L
            int latas18L = (int) Math.ceil(litrosNecessarios / 18);
            double precoLatas = latas18L * 80.0;

            // Opção 2: Apenas galões de 3.6L
            int galoes3_6L = (int) Math.ceil(litrosNecessarios / 3.6);
            double precoGaloes = galoes3_6L * 25.0;

            // Opção 3: Mistura de latas e galões (otimizada para menor preço)
            int latas = (int) (litrosNecessarios / 18);
            double litrosRestantes = litrosNecessarios % 18;
            int galoes = (int) Math.ceil(litrosRestantes / 3.6);

            // Verifica se compensa comprar uma lata extra em vez de vários galões
            if (litrosRestantes > 0 && galoes * 25 > 80) {
                latas++;
                galoes = 0;
            }

            double precoMisto = (latas * 80.0) + (galoes * 25.0);

            // Exibe os resultados
            out.println("\nQuantidade de tinta necessária: " + Math.ceil(litrosNecessarios) + " litros");

            out.println("\nOpção 1: Comprar apenas latas de 18L");
            out.println("Quantidade de latas: " + latas18L);
            out.println("Preço total: R$ " + precoLatas);

            out.println("\nOpção 2: Comprar apenas galões de 3.6L");
            out.println("Quantidade de galões: " + galoes3_6L);
            out.println("Preço total: R$ " + precoGaloes);

            out.println("\nOpção 3: Misturar latas e galões (melhor custo)");
            out.println("Quantidade de latas: " + latas);
            out.println("Quantidade de galões: " + galoes);
            out.println("Preço total: R$ " + precoMisto);

            %>
            </div>
        
    </body>
</html>-->
