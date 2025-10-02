*** Variables ***
#Api Configuration
${BASE_URL}    https://serverest.dev
${TIMEOUT}    120

#Session Configuration
${API_SESSION}    serverest

#Global Variables
${AUTH_HEADER}
${USER_ID}
${PRODUCT_ID}
${CARRINHO_ID}
&{USER_COMUM}     nome=Usuario Comum    password=Teste123    administrador=false
&{PRODUTO}        preco=100    descricao=Descricao do produto teste    quantidade=10     
&{USER_ADMIN}     nome=Usuario Admin    password=Teste123    administrador=true
${EMAIL_ADMIN}    admin_robot_125@qa.com.br
${emailcarrinho}
