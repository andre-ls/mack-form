# Mack-Form

Este repositório contém um projeto relacionado ao Trabalho Final Individual da disciplina de Cloud Computing e SRE da Pós Graduação em Engenharia de Dados, ofertada pela Universidade Presbiteriana Mackenzie, e lecionada pelo Professor Yuri Menezes.

## Objetivo

O objetivo deste trabalho é o de utilizar os conhecimento e boas práticas adquiridas em aula relacionadas à utilização de ferramentas de Infrastructure as a Code (IaC), principalmente de Terraform, para implementar em um ambiente AWS a seguinte arquitetura hexagonal:

![Arquitetura]('architecture.png')

A arquitetura acima é oriunda de um exemplo proposto pela própria documentação da AWS que sugere a criação de duas camadas de elementos que dão suporte a uma determinada aplicação, localizada no seu centro. 

Na camada à esquerda, denominada camada Primária, estão elementos relacionados à interface da aplicação para os seus usuários. A camada é composta por três combinações de recursos que permitem uma variedade de formas de acesso à aplicação:

- API Gateway + Lambda: Fornecem uma interface para requisições síncronas à aplicação.
- SQS + Lambda: Fornecem uma interface para requisições assíncronas à aplicação.
- EventBridge + ECS: Fornecem uma interface para requisições em Batch agendadadas à aplicação.

Já na segunda camada, chamada de Secundária e posicionada na direita do diagrama, se encontram elementos relacionados à persistência dos dados da aplicação.

- DynamoDb: Banco de dados NoSQL, permitindo o armazenamento de dados em formato não-relacional.
- RDS: Banco de dados SQL, permitindo o armazenamento de dados relacionais.

Além disso, a segunda camada apresenta um recurso de API Gateway, permitindo o acesso direto aos dados da aplicação através de uma API que pode ser utilizada por usuários ou outras aplicações externas.

Com isso, cria-se uma arquitetura padrão capaz de dar um amplo suporte as mais diversas aplicações, o que torna o fornecimento de infraestutura para um time de desenvolvedores muito mais fácil e ágil.

## Organização do Código

Para fornecer a arquitetura demonstrada na seção acima de uma maneira totalmente automatizada e declarada em código, utilizou-se o Terraform como ferramenta principal deste projeto. O código se encontra no diretório "terraform" com a seguinte arquitetura modular:

```md
terraform
    ├── main.tf
    ├── modules
    │   ├── async_lambda
    │   ├── dynamo_db
    │   ├── ecs
    │   ├── event_bridge
    │   ├── primary_api_gateway
    │   ├── rds
    │   ├── secondary_api_gateway
    │   ├── security_groups
    │   ├── sqs
    │   ├── sync_lambda
    │   └── vpc
    └── submodules
        ├── api_gateway
        └── lambda
```

O arquivo main.tf contém todas as declarações de módulos que juntos compõem a arquitetura desejada. Na pasta modules, se encontra subpastas, cada uma representando um determinado componente da arquitetura. Cada um desses componentes possui em sua composição três arquivos principais:

- main.tf: Um arquivo main que define as configurações do elemento.
- variables.tf: Arquivo que contém a definição de variáveis, que permitem a customização de algumas das configurações do recurso pelo usuário do componente.
- outputs.tf: Arquivo que contém a definição de saídas do módulo, que podem ser utilizadas pelo usuário principal para conexão com outros módulos, integrando-os assim em arranjos complexos.

Por fim, no diretório de submodules, pode-se encontrar a definição básica de recursos que foram utilizados mais de uma vez na arquitetura, que basicamente consiste nos recursos de API Gateway e Lambda. Logo, os submódulos contém uma definição padrão destes recursos, enquanto que os seus devidos módulos contém uma referência à configuração básica, junto a configurações mais específicas de cada utilização. Sob um ponto de vista mais teórico, a ideia de utilizar submódulos é simplesmente evitar a duplicidade de um código comum a elementos repetidos na arquitetura.

## Possíveis Melhorias

Acredito que a principal melhoria neste projeto pode estar associada à uma melhor organização dos outputs de cada módulo, que poderiam ser agregados em alguns objetos, tornando a sua definição mais sucinta e direta, e ao mesmo tempo, dando mais flexibilidade aos usuários para uma utilização dos módulos desenvolvidos para além do cenário proposto neste projeto. Uma outra possibilidade interessante seria reconsiderar uma reorganização dos módulos, e pensar na composição de módulos maiores que englobem um ou mais recursos fortemente acoplados, assim como sugerido em parte dos guias propostos pelo próprio Terraform. Um exemplo poderia incluir a criação de um módulo inteiro voltado para requisições síncronas, que englobaria os elementos de API Gateway e Lambda dentro de um mesmo módulo.

## Referências

[Module creation - recommended pattern por Hashicorp]('https://developer.hashicorp.com/terraform/tutorials/modules/pattern-module-creation')

[How to Create API Gateway Using Terraform & AWS Lambda por Spacelift]('https://spacelift.io/blog/terraform-api-gateway')

[Setup Lambda to Event Source from SQS in Terraform por Sheehan Alam]('https://medium.com/appetite-for-cloud-formation/setup-lambda-to-event-source-from-sqs-in-terraform-6187c5ac2df1')

[Using terraform to setup AWS EventBridge Scheduler and a scheduled ECS Task por Igor Kachmaryk]('https://medium.com/@igorkachmaryk/using-terraform-to-setup-aws-eventbridge-scheduler-and-a-scheduled-ecs-task-1208ae077360')
