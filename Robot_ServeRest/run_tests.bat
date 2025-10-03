@echo off
echo ==========================================
echo  Compass Challenge 03 - Suite de Testes
echo ==========================================
echo.

echo Escolha a opcao de execucao:
echo 1. Executar suites individuais
echo 2. Gerar relatorios detalhados
echo.

set /p escolha="Digite sua escolha (1-2): "

if "%escolha%"=="1" (
    echo.
    echo Executando suites individuais...
    robot --outputdir results/usuarios tests/user_test.robot
    robot --outputdir results/login tests/login_test.robot  
    robot --outputdir results/produtos tests/product_test.robot
    robot --outputdir results/carrinho tests/carrinho_test.robot
    goto fim
)


if "%escolha%"=="2" (
    echo.
    echo Gerando relatorios detalhados...
    robot --outputdir results --report relatorio_detalhado.html --log log_detalhado.html --loglevel DEBUG tests/
    goto fim
)

echo Escolha invalida. Execute o script novamente.

:fim
echo.
echo ==========================================
echo Execucao concluida!
echo Verifique a pasta 'results' para relatorios.
echo ==========================================
pause