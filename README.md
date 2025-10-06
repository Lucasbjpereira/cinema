# 🎬 Cinema App

Um aplicativo Flutter moderno e elegante para consulta de cinemas, filmes em cartaz e programação de sessões. O app permite aos usuários encontrar cinemas por região, visualizar filmes disponíveis e consultar horários de sessões de forma intuitiva.

## ✨ Características Principais

- 🎭 **Splash Screen Animado**: Tela inicial com logo animado e transições suaves
- 🔍 **Busca de Cinemas**: Localização de cinemas por região metropolitana
- 🎥 **Catálogo de Filmes**: Visualização de filmes em cartaz com carrossel interativo
- 📋 **Detalhes Completos**: Informações detalhadas dos filmes incluindo sinopse, gênero, duração e classificação
- 📅 **Programação de Sessões**: Consulta de horários organizados por data e sala
- 🌍 **Filtros Regionais**: Seleção por regiões metropolitanas de São Paulo
- 💾 **Persistência Local**: Salvamento de preferências do usuário
- 🎨 **Interface Moderna**: Design dark com elementos visuais atraentes

## 🛠️ Tecnologias Utilizadas

### Framework e Linguagem
- **Flutter** 3.0.1+ - Framework de desenvolvimento multiplataforma
- **Dart** - Linguagem de programação

### Dependências Principais
- `carousel_slider: ^4.2.1` - Carrossel de imagens para destaque de filmes
- `shared_preferences: ^2.1.2` - Persistência de dados locais
- `http: ^1.0.0` - Requisições HTTP
- `intl: ^0.18.1` - Formatação de datas e internacionalização
- `flutter_svg: ^2.0.6` - Suporte para imagens SVG
- `flutter_dropdown: ^1.0.1` - Componentes de dropdown customizados

### Ferramentas de Desenvolvimento
- `flutter_launcher_icons: ^0.13.1` - Geração de ícones do app
- `flutter_lints: ^2.0.0` - Análise estática de código

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── splash.dart              # Tela de splash com animação
├── search_cinema.dart       # Busca e seleção de cinemas
├── cinema.dart              # Tela principal com filmes em cartaz
├── filme.dart               # Detalhes do filme e programação
├── sessions.dart            # Visualização de sessões por data
└── components/
    ├── header.dart          # Cabeçalho com logo e navegação
    ├── menu.dart            # Componente de menu
    └── pesquisa.dart        # Componente de busca

assets/
├── db.json                  # Base de dados com cinemas e filmes
├── regioes.json            # Lista de regiões metropolitanas
├── imgs/                   # Imagens do aplicativo
│   ├── logo.png
│   ├── home.png
│   ├── search-cine.png
│   ├── sessions.png
│   └── icon.png
└── fonts/                  # Fontes customizadas
    ├── Inter-Bold.ttf
    └── Inter-SemiBold.ttf
```

## 🎯 Funcionalidades Detalhadas

### 🚀 Splash Screen
- Animação de escala do logo com efeito pulsante
- Verificação automática de cinema previamente selecionado
- Redirecionamento inteligente baseado no estado do usuário

### 🔍 Busca de Cinemas
- Lista completa de cinemas disponíveis
- Filtro por região metropolitana de São Paulo
- Busca por nome do cinema
- Seleção e persistência da escolha do usuário

### 🎬 Tela Principal (Cinema)
- Carrossel automático com filmes em destaque
- Lista categorizada de filmes (Em cartaz, Em breve)
- Busca de filmes por título
- Navegação rápida para detalhes dos filmes

### 📽️ Detalhes do Filme
- Poster em alta resolução
- Informações completas: gênero, duração, classificação etária
- Sinopse detalhada
- Programação de sessões organizada por data
- Horários disponíveis por sala (dublado/legendado, 2D/3D)

### 📅 Programação de Sessões
- Visualização por data (próximos 7 dias)
- Filtros por características da sessão
- Informações de sala e tipo de exibição
- Interface intuitiva para seleção de horários

## 📊 Dados e Assets

### Base de Dados (db.json)
Contém informações estruturadas sobre:
- **Cinemas**: ID, nome, região, endereço, logo
- **Filmes**: Título, imagem, gênero, classificação, sinopse, trailer
- **Sessões**: Datas, salas, horários, tipo de exibição

### Regiões (regioes.json)
Lista das 19 regiões metropolitanas de São Paulo:
- Região Metropolitana de São Paulo
- Região Metropolitana de Campinas
- Região Metropolitana da Baixada Santista
- E outras regiões do estado

### Assets Visuais
- **Logo**: Identidade visual do aplicativo
- **Ícones**: Navegação e funcionalidades
- **Fontes**: Tipografia Inter para consistência visual

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.0.1 ou superior
- Dart SDK
- Android Studio / VS Code
- Emulador Android/iOS ou dispositivo físico

### Instalação

1. **Clone o repositório**
```bash
git clone [url-do-repositorio]
cd cinema
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```

### Comandos Úteis

```bash
# Verificar dependências
flutter pub deps

# Executar testes
flutter test

# Gerar APK
flutter build apk

# Gerar bundle para Play Store
flutter build appbundle
```

## 📱 Plataformas Suportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎨 Screenshots

*Seção reservada para capturas de tela do aplicativo*

<!-- Adicione aqui as imagens das telas principais -->

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Diretrizes de Contribuição
- Siga as convenções de código Dart/Flutter
- Adicione testes para novas funcionalidades
- Mantenha a documentação atualizada
- Use commits semânticos

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

Desenvolvido como parte do portfólio de projetos.

---

⭐ Se este projeto foi útil para você, considere dar uma estrela!
