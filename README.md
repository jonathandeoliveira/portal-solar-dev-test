<h1 align="center">Buscador de Geradores de Energia Solar </h1>

<div align="center"><img src="app/assets/images/readme/solar_panel.png"></div>

<div align="center"><img src="https://badgen.net/badge/Ruby/Versão%202.6.3/red?icon=ruby"> <img  align="justify" src="https://img.shields.io/badge/Rails-Versão%205.2-red"> <img  align="justify" src=https://img.shields.io/badge/Status-Em%20desenvolvimento-brightgreen> </div>

____
### <p align="justify"> Tabela de Conteúdos 🗺️: </p>
  🔹	[Descrição do projeto](#descrição-do-projeto) </br>
  🔹	[Funcionalidades](#funcionalidades)</br>
  🔹	[Gems utilizadas](#gems-utilizadas)</br>
  🔹	[Como instalar a aplicação](#como-instalar-a-aplicação)</br>
  🔹	[Configurando o banco de dados](#configurando-o-banco-de-dados)</br>
  🔹	[Layout da aplicação](#layout-da-aplicação)</br>
  🔹	[Ideias para implementações futuras](#ideias-para-implementações-futuras)</br>

  #### <p align="justify"> Descrição do projeto </p>
___
  Uma plataforma que permite a visualização e busca, de forma simples ou avançada, de geradores de energia de um e-commerce de geradores, bem como consultar o valor do frete com base no CEP.

  #### <p align="justify"> Funcionalidades da aplicação </p>
___

  - [X] Geradores ordenados pela hierarquia: Preço → Nome → Quilowatt Pico (kWp)
  - [X] Lista de geradores organizada em páginas, contendo grupos de no máximo 6  por página.
  - [x] O peso cubado de um gerador é calculado e salvo automaticamente.
  - [X] Usuário pode buscar geradores através de uma pesquisa simples de um parâmetro ou uma pesquisa avançada com mais opções de parâmetros.
  - [X] Usuário pode inserir cep para verificar o custo de frete de um gerador.
  - [x] Calculo do frete otimizado para buscar o menor custo de frete entre o Peso líquido e Peso Cubado.

 #### <p align="justify"> Linguagens, Gems e Frameworks utilizados 🛠️⚙️ : </p>
___
- [Ruby 2.6.3](https://ruby-doc.org) - Linguagem utilizada
- [Rails 5.2](https://guides.rubyonrails.org) - Framerwork utilizado para desenvolver o projeto
- [Docker](https://docs.docker.com) - Utilizado para modularização da aplicação
- [Rspec](https://github.com/rspec/rspec-rails) - Utilizado para os testes da aplicação
- [Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec) -Auxilia o rspec durante os testes
- [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) - Utilizada para debugar o código
- [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers) - Utilizada para facilitar testes de validações de models
- [Kaminari](https://github.com/kaminari/kaminari)- Utilizada para fazer a paginação da aplicação
- [Faraday](https://lostisland.github.io/faraday/)- Utilizada para comunicações de API

####  <p align="justify"> Como instalar a aplicação 🔌: </p>
___

Clone o repositório em seu computador: 

    $ git clone  git@github.com:jonathandeoliveira/portal-solar-dev-test.git

######  <p align="justify"> Preparando o ambiente: </p>

Instale as depencedias do sistema

    $ bundle install

Será necessário utilizar o docker para nos fornecer postgresql para conectarmos ao banco de dados, execute o comando:

    $ docker-compose up


#### Configurando banco de dados 💾:
___

Execute o comando seed no seu console para popular o banco de dados:

    $ bundle exec rails db:create db:migrate db:seed

###### Inicie o servidor:

    $ bundle exec rails server

###### Rodando os testes:

    $ bundle exec rspec

#### Layout da aplicação 🔭:
___
###### Página inicial:
  <img src="app/assets/images/readme/homepageAdvSearch.jpg">

###### Detalhes de um gerador:
  <img src="app/assets/images/readme/product_detail.jpg">
  <img src="app/assets/images/readme/product_detai_with_freightl.jpg">

###### Página de busca:
  <img src="app/assets/images/readme/search_reasult.jpg">
  <img src="app/assets/images/readme/search_reasult_not_found.jpg">

### Ideias para implementações futuras 📖:
___
* Utilização da Gem FriendlyId para urls personalizadas
* Melhorar o front-end da aplicação
* Adicionar mais parâmetros no sistema de busca avançada
* Implementação de frete através de matriz de distância

### Contribuintes 👨‍💻👩‍💻 : 

| [<img src="https://avatars.githubusercontent.com/u/56161566?v=4v" width=115><br><sub>Jonathan de Oliveira Gonçalves</sub>](https://github.com/jonathandeoliveira) |
| :---: 