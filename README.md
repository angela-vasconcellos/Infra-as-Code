<h1 align="center">DESAFIO  4 - CONTAINERIZAÇÃO & DEVOPS (CI & CD)</h1>

<p align="justify">Criação de Infraestrutura por código no GCP, a fim de executar as APIs.</p>


<h2>OBJETIVO</h2>

- O objetivo do desafio é criar imagens das aplicações criadas.

- Criação do Cluster GKE e desenvolver os objetos necessários no Kubernetes para realização do deployment, expondo as aplicações atráves de Load Balancers.

- Ao final, inserir o código no GitLab e contruir uma pipeline de entrega da aplicação (GitLab CI) no cluster GKE.

    - Passos da pipeline:
        - Checkout do código e Lint
        - Construir a imagem da aplicação
        - Enviar sua imagem para o Docker Hub
        - Instalar sua aplicação no Kubernetes
        - Runner ubuntu


- Para realização do desafio, utilizei o Terraform e como provedor, o GCP (Google Cloud) e para versionamento e automatização, o GitLab.

<h2>FERRAMENTAS UTILIZADAS</h2>

- <b>Docker</b> como ferramenta para conteinerização usada para empacotar, entregas e executar aplicações em containers Linux.
- <b>Kubernetes</b> como ferramenta para orquestração dos contêineres.
- <b>Terraform</b> como ferramenta para construção, manutenção e versionamento de infraestrutura.
- <b>Google Cloud - GCP</b> como provedor na nuvem.
- <b>Python</b> como linguagem de programação para montagem das APIs referentes ao desafio 1.
- <b>GitLab</b> como gerenciador de repositório baseado em git e gerenciamento de tarefas e CI/CD.

<h2>RECURSOS UTILIZADOS NO GCP</h2>

- [X] VPC Network + Subnetwork 
- [X] Cloud router
- [X] NAT Gateway
- [X] Route Tables
- [X] Firewall Rules
- [X] Bucket
- [X] GKE
- [X] Nood Pools

<h2>PARTE 1 - MONTAGEM DA INFRAESTRUTURA</h2>

Utilizei a infraestutura construída em outro momento no GCP, retirando recursos que não eram mais necessários e adicionando novos recursos, como o GKE e os Node Pools.

    Recursos retirados: 
    - [X]Instance Group
    - [X]Load Balance
    - [X]Health Check
    - [X]Backend Service
    - [X]Instance Template
    - [X]Auto Scalling
    - [X]SQL (banco de dados)


1. Criação da <b>VPC</b> e com ela foram criadas 2 subnetworks, sendo 1 pública e 1 privada, todas na mesma zona.

    - [X] Na subnetwork privada está o cluster e os nodes.
    - [X] Nas subnetwork pública está o Bastion Host.
    - Para uma alta disponibilidade, o ideal é que os recursos sejam provisionados em zonas múltiplas.


2. Criação do cluster com 3 nodes e 1 grupo de node, adicionando a opção de autoscaling (min. 1 e máx. 3).


<h2>PARTE 2 - CRIAÇÃO DAS IMAGENS COM DOCKER</h2>

1. :heavy_check_mark: Com a Infraestrutura criada no GCP, hora da criação das imagens e upload para o DockerHub.

2. Para criação das imagens utilizando docker, criei um arquivo .Dockerfile, através dele, passei os comandos para que uma imagem da nossa API seja criada e posteriormente rodada como contêiner.

3. Na realização do desafio, criamos 5 .Dockerfile, sendo 4 para as APi's e 1 para o banco de dados.

4. Com a criação das imagens, podemos criar contêineres no próprio docker e executar as API's, porém seria muito complicado e trabalhoso, administrar os contêineres e IP's de forma manual, por isso, usamos o Kubernetes, ele irá fazer essa administração de contêineres do docker.


<h2>PARTE 3 - CRIAÇÃO DOS OBJETOS COM KUBERNETES</h2>

1. Para utilização do Kuberentes, nós criamos 5 arquivos: Deployment, Service, Ingress e Load Balancer, todos .yml, linguagem utilizada pelo kubernetes.

2. Finalidade dos arquivos .yml:
    - <b>Deployment:</b> objeto no Kubernetes que permite gerenciar um conjunto de Pods identificados por uma label.
    - <b>Service:</b> objeto que agrupa um conjunto de endpoints de pod em um único recurso.
    - <b>Ingress:</b> objeto que permite expor seu serviço para a rede externa. É possível usar porta, hostname ou path para rotear seu serviço.


3. O Load Balancer, é um tipo de service. Além do Load Balancer, nós criamos um service, tipo ClusterIP, para cada aplicação, incluindo nosso banco de dados.

4. O banco de dados é um objeto deployment, assim como as APis.

5. Para o devido funcionamento do kubernetes, utilizei o comando "kubectl". Através dele, posso gerenciar os recursos criados, bem como criar e excluir. Neste caso, nós utilizado o terminal do GCP, o cloud shell, para acessar o cluster e executar os comandos necessários para teste.


<h2>PARTE 3 - CRIAÇÃO DA PIPELINE (CI/CD)</h2>

1. A ideia da pipeline é automatizar o deploy e realizá-lo sempre que houver alguma alteração no código gerenciado pelo GitLab, atingindo os objetivos do CI/CD - Integração e Entrega Contínua - método de entrega frequente para o cliente.

2. Para inicialização de uma pipeline, devemos utilizar o arquivo .gitlab-ci.yml. Ao criar esse arquivo no seu repositório, ele é automaricamente identificado e starta a pipeline.

3. A criação do arquivo foi realizada com a ajuda da documentação fornecida pelo Git Lab.

4. Além disso, para que uma pipeline rode, é necessário a existênca de um runner (gitlab-runner), podendo ser um runner compatilhado ou personalizo.

5. Nesse caso, utilizamos a imagem base do ubuntu:20.04 e um runner compartilhado.

6. A pipeline foi responsável por buildar, tagear e pushar as imagens para o DockerHub (Repositório de imagens do docker), bem como conectar com o nosso cluster no GCP e realizar o deploy dos objetos do kubernetes com a aplicação e banco de dados.

Com a pipeline concluída com sucesso, temos a aplicação em pleno funcionamento e com acesso da internet, por meio do Load Balancer criado.

