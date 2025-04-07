<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Resultado do Cálculo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .result-card {
            max-width: 600px;
            margin: 50px auto;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .highlight {
            font-size: 1.5rem;
            color: #0d6efd;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card result-card">
            <div class="card-header bg-primary text-white">
                <h2 class="text-center">Resultado do Cálculo</h2>
            </div>
            <div class="card-body">
                <div class="mb-4">
                    <h4>Detalhes da Pintura:</h4>
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Área total:</span>
                            <span class="fw-bold">${metrosQuadrados} m²</span>
                        </li>
                        <c:if test="${not empty tipoSuperficie}">
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Tipo de superfície:</span>
                                <span class="text-capitalize fw-bold">${tipoSuperficie}</span>
                            </li>
                        </c:if>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Número de demãos:</span>
                            <span class="fw-bold">${demaoes}</span>
                        </li>
                    </ul>
                </div>

                <div class="alert alert-success">
                    <h3 class="text-center">
                        Quantidade necessária: 
                        <span class="highlight">${litrosNecessarios} litros</span>
                    </h3>
                    <p class="text-center mt-2 mb-0">
                        (Considerando rendimento de 6m² por litro)
                    </p>
                </div>

                <div class="d-grid gap-2">
                    <a href="index.html" class="btn btn-primary">
                        <i class="bi bi-arrow-left"></i> Novo Cálculo
                    </a>
                </div>

                <div class="mt-4 text-muted small">
                    <p class="mb-1">Dica profissional:</p>
                    <ul>
                        <li>Compre 10% a mais para compensar perdas</li>
                        <li>Para melhores resultados, use rolo de lã de carneiro</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>