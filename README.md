# Total Express Tracker

Este projeto automatiza o fluxo de consulta disponível publicamente no site da transportadora Total Express utilizando os mesmo mecanismos HTTP empregados por navegadores. 

> [!WARNING]
> Este projeto foi desenvolvido para fins educacionais e de uso pessoal. Não deve ser utilizado para consultas em massa, coleta de dados ou atividades que violem os termos aplicáveis do serviço.

## Tópicos aprendidos

### HTTP
* Diferença entre requisições realizadas pelo navegador e por ferramentas como `curl`.
* Negociação de conteúdo através dos cabeçalhos `Accept`, `Content-Type` e `Content-Encoding`.

### Cookies
* Gerenciamento de sessões através de cookies.
* Obtenção de cookies através de uma requisição inicial (*bootstrap* da sessão).
* Persistência de cookies utilizando um *cookie jar*.
* Reutilização de cookies em requisições subsequentes.

### Engenharia Reversa
* Análise de tráfego gerado pelo navegador através das ferramentas de desenvolvedor.
* Identificação de endpoints utilizados internamente pela aplicação.

### Shell Script/Bash
* Organização de um projeto Shell Scritp em múltiplos arquivos.
* Uso de variáveis de ambiente através de arquivos `.env`.
* Uso de `readonly`, `local`.

## Desafios encontrados
* Ao longo do projeto descobri que a API necessitava de uma sessão inicial.
* O entendimento que os cookies que estavam fazendo o papel de autenticação.
* Comparações constantes com o navegador e o `curl`.
* Problemas na compressão e codificação de respostas HTTP.

## Como utilizar?

### Pré-requisitos
* `bash`
* `curl`
* `jq`
* `ca-certificates`

> [NOTE!]
> Caso prefira usar uma imagem docker dê uma olhada na sessão [Docker](#Docker).

### 0. Configuração via `.env` (opcional)
Crie um arquivo `.env` na raíz do projeto:

```
TRACKING_CODE=TX12345678901tx
```

> [NOTE!]
> Ao criar o arquivo `.env` você garante que o script sempre terá o código de rastreio salvo.

### 1. Utilizando o script
Caso tenha feito o passo `0`, basta executar:
```
./tracker.sh
```

Senão, terá que informar o código de rastreio ao script:
```
./tracker.sh TX12345678901tx
```

> [WARNING!]
> Lembre-se de dar permissão ao script para execução.

> [NOTE!]
> O argumento informado pela linha de comando possui prioridade sobre o valor definido no `.env`.

### Exemplo de saída

```
🌎 Coletando cookies...
🌎 Checando encomenda na Total Express...
🌎 Coletando informações da Total Express...

📦 Pedido: .... 
🏷️ Código: TX12345678901tx
📅 Previsão: dd/MM/yyyy


📦 Em posse da transportadora
  ✓ dd/MM hh:mm  COLETA REALIZADA
  ...

📦 Transferência para unidade local
  ✓ dd/MM hh:mm  EMBARCADO PARA: ...
  ✓ dd/MM hh:mm  TRANSFERENCIA PARA: - ...
  ...

📦 Saída para Entrega
  ✓ dd/MM hh:mm  EM ROTA
  ✓ dd/MM hh:mm  PROCESSO DE ENTREGA
  ...

📦 Entrega Realizada
  ✓ dd/MM hh:mm  ENTREGA REALIZADA
```

### Como o script funciona?

1. Cria uma sessão inicial para obtenção dos cookies necessários.
2. Armazena os cookies em um `cookie jar`.
3. Reutiliza essa sessão para consultar a API de rastreio.
4. Obtém os dados da encomenda e os apresenta no terminal.

## Docker

O projeto possui uma imagem Docker com todas as dependências necessárias já instaladas. Dessa forma não é necessário configurar o ambiente local.

### 1. Construindo a imagem
Na raiz do projeto execute:
```
docker build -t totalexpress-tracker .
```

### 2. Executando uma consulta
* Execução passando o código de rastreio através da opção `-e`:
```
docker run --rm \
    -e TRACKING_CODE=TX12345678901tx \
    totalexpress-tracker
```

* Execução passando o arquivo `.env`. O arquivo pode ser passado através da opção `--env-file`:
```
docker run --rm \
    --env-file .env \
    totalexpress-tracker
```

* Execução passando o código de rastreio:
```
docker run --rm totalexpress-tracker TX12345678901tx
```

