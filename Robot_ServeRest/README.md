# Compass Challenge 03 - Automação de Testes de API

## 📋 Visão Geral
Suíte de testes automatizados para a API ServeRest usando Robot Framework. Os testes cobrem gerenciamento de usuários, autenticação, gerenciamento de produtos e funcionalidade de carrinho de compras.

## 🚀 Início Rápido
```bash
# Usar script batch
run_tests.bat

# Executar suítes individuais
robot tests/user_test.robot
robot tests/login_test.robot
robot tests/product_test.robot
robot tests/carrinho_test.robot
```

## 📁 Estrutura do Projeto
```
Compass_Challenge_03/
├── run_tests.bat           # Script de execução dos testes
├── tests/                  # Suítes de teste individuais
│   ├── user_test.robot    # Testes de gerenciamento de usuários
│   ├── login_test.robot   # Testes de autenticação
│   ├── product_test.robot # Testes de gerenciamento de produtos
│   └── carrinho_test.robot # Testes de carrinho de compras
├── keywords/              # Keywords reutilizáveis
│   ├── user_keyword.robot
│   ├── login_keyword.robot
│   ├── product_keyword.robot
│   ├── carrinho_keyword.robot
│   └── common_keyword.robot
├── variables/
│   └── global_variables.robot
└── README.md
```

## 🧪 Cobertura de Testes

### Suítes de Teste Individuais

**Gerenciamento de Usuários**
- Listar usuários e validar esquema
- Criar/editar/excluir usuários
- Tratar emails duplicados

**Autenticação**
- Login bem-sucedido
- Tratamento de credenciais inválidas

**Gerenciamento de Produtos** (requer autenticação)
- Operações CRUD para produtos
- Validação de nome duplicado

**Carrinho de Compras** (requer autenticação)
- Adicionar produtos ao carrinho
- Conclusão da compra
- Restrições de exclusão de usuário

## 🔧 Pré-requisitos
```bash
pip install robotframework
pip install robotframework-requests
```

## 📊 Opções de Execução

### Opção 1: Suítes Individuais
```bash
robot tests/user_test.robot
robot tests/login_test.robot
robot tests/product_test.robot
robot tests/carrinho_test.robot
```

### Opção 2: Por Tags
```bash
robot --include usuarios tests/
robot --include login tests/
robot --include produtos tests/
robot --include carrinhos tests/
```

## 🏗️ Endpoints da API Testados

| Endpoint | Método | Cobertura de Teste |
|----------|--------|-----------------|
| `/usuarios` | GET, POST, PUT, DELETE | ✅ CRUD Completo |
| `/login` | POST | ✅ Cenários de autenticação |
| `/produtos` | GET, POST, PUT, DELETE | ✅ CRUD Completo |
| `/carrinhos` | POST, DELETE | ✅ Operações de carrinho |

## 📈 Principais Características

- **Execução em Ciclo Único**: Todos os testes executam em um fluxo unificado
- **Gerenciamento de Sessão**: Tratamento eficiente de sessão da API
- **Dados Dinâmicos**: Geração aleatória de email para isolamento de testes
- **Cobertura Abrangente**: Fluxo Usuário → Autenticação → Produtos → Carrinho
- **Execução Fácil**: Scripts batch simples para execução rápida
- **Design Modular**: Keywords reutilizáveis e separação clara

## 🔍 Configuração

**Configurações da API** (`variables/global_variables.robot`):
- URL Base: https://serverest.dev
- Timeout: 120 segundos
- Dados de teste para usuários, produtos e autenticação

## 📝 Relatórios
A execução dos testes gera:
- `report.html` - Resumo dos resultados dos testes
- `log.html` - Log detalhado de execução
- `output.xml` - Dados brutos dos testes

## 🚀 Pronto para CI/CD
A estrutura do projeto suporta integração com:
- Jenkins
- GitHub Actions
- Azure DevOps
- Qualquer pipeline CI/CD que suporte Robot Framework

## 📄 Licença
Compass Sprint 6 Challenge 03 - Automação de Testes de API
