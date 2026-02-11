# Deploy Guide - Sinesys (Cloudron)

Este documento descreve o processo de build e deploy da aplicacao Sinesys no Cloudron.

## Visao Geral

O Sinesys utiliza:
- **Docker** para containerizacao (multi-stage build)
- **cloudron/base:4.2.0** como imagem base de producao
- **Cloudron** como plataforma de deploy e gerenciamento

## Arquitetura de Deploy

```
Developer → Build Local → cloudron install → Cloudron Server
```

### Estrutura de Arquivos Cloudron

```
projeto/
├── CloudronManifest.json   # Configuracao do app para Cloudron
├── Dockerfile              # Build multi-stage com base Cloudron
├── start.sh               # Script de inicializacao
└── ...
```

## Requisitos

### Cloudron CLI

Instale o CLI do Cloudron:

```bash
npm install -g cloudron
```

### Autenticacao

```bash
cloudron login https://my.cloudron.server
```

## Build e Deploy

### Build da Imagem

```bash
# Build com variaveis de ambiente
npm run cloudron:build

# Ou manualmente com build args
docker build \
  --build-arg NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co \
  --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=eyJxxx \
  -t io.sinesys.app:latest .
```

### Deploy Inicial

```bash
# Instalar o app
cloudron install --image io.sinesys.app:latest

# Ou especificando a imagem
cloudron install --image io.sinesys.app:latest --location sinesys
```

### Atualizacao

```bash
# Rebuild e update
npm run cloudron:build
npm run cloudron:update

# Ou manualmente
docker build -t io.sinesys.app:latest .
cloudron update --image io.sinesys.app:latest
```

## Configuracao

### CloudronManifest.json

| Campo | Descricao |
|-------|-----------|
| `id` | Identificador unico do app (io.sinesys.app) |
| `httpPort` | Porta HTTP interna (8000) |
| `healthCheckPath` | Endpoint de health check (/api/health) |
| `memoryLimit` | Limite de memoria em bytes (1GB) |
| `addons` | Addons utilizados (localstorage) |

### Variaveis de Ambiente

Configure no painel do Cloudron (Apps > Sinesys > Configure):

**Obrigatorias:**
| Variavel | Descricao |
|----------|-----------|
| `NEXT_PUBLIC_SUPABASE_URL` | URL do projeto Supabase |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY` | Anon Key do Supabase |
| `SUPABASE_SECRET_KEY` | Secret Key do Supabase |
| `SERVICE_API_KEY` | Chave de API interna |

**Opcionais:**
| Variavel | Descricao |
|----------|-----------|
| `OPENAI_API_KEY` | API Key do OpenAI |
| `REDIS_URL` | URL do Redis |
| `B2_ENDPOINT` | Endpoint do Backblaze B2 |
| `DYTE_API_KEY` | API Key do Dyte |

### Variaveis Automaticas do Cloudron

O Cloudron define automaticamente:
- `CLOUDRON=1`
- `CLOUDRON_APP_DOMAIN` (ex: sinesys.meudominio.com)
- `CLOUDRON_APP_ORIGIN` (ex: https://sinesys.meudominio.com)
- `CLOUDRON_PROXY_IP` (IP do proxy reverso)

## Estrutura de Diretorios no Container

| Caminho | Tipo | Descricao |
|---------|------|-----------|
| `/app/code` | Somente leitura | Codigo da aplicacao |
| `/app/data` | Read-write | Dados persistentes |
| `/app/data/cache` | Read-write | Cache da aplicacao |
| `/app/data/uploads` | Read-write | Uploads de arquivos |

## Scripts NPM

```bash
npm run cloudron:build      # Build da imagem Docker
npm run cloudron:build:no-cache  # Build sem cache
npm run cloudron:install    # Instalar no Cloudron
npm run cloudron:update     # Atualizar no Cloudron
npm run cloudron:logs       # Ver logs em tempo real
```

## Troubleshooting

### Ver Logs

```bash
# Via CLI
cloudron logs -f

# Via painel
Apps > Sinesys > Logs
```

### Container Reiniciando

1. Verifique logs: `cloudron logs`
2. Procure por: "out of memory", "heap", "killed"
3. Aumente `memoryLimit` no CloudronManifest.json se necessario

### Build Falha

1. Verifique se Docker tem memoria suficiente (4GB+)
2. Use `npm run cloudron:build:no-cache` para rebuild limpo
3. Verifique se todos os build args estao corretos

### App Nao Inicia

1. Verifique se `healthCheckPath` (/api/health) esta respondendo
2. Verifique variaveis de ambiente obrigatorias
3. Verifique logs de inicializacao

## Metricas Esperadas

| Metrica | Valor |
|---------|-------|
| Tamanho da imagem | ~400-500MB |
| Tempo de build (sem cache) | ~6-10 min |
| Tempo de build (com cache) | ~2-4 min |
| Tempo de inicializacao | ~10-15s |
| Memoria recomendada | 1GB |

## Comandos Uteis

```bash
# Ver informacoes do app
cloudron inspect

# Ver status
cloudron status

# Reiniciar app
cloudron restart

# Backup dos dados
cloudron backup

# Restaurar backup
cloudron restore --backup <backup-id>

# Executar comando no container
cloudron exec -- node -v

# Ver uso de recursos
cloudron stats
```

## Referencias

- [Cloudron App Packaging](https://docs.cloudron.io/packaging/tutorial/)
- [CloudronManifest.json](https://docs.cloudron.io/packaging/manifest/)
- [Cloudron CLI](https://docs.cloudron.io/cli/)
- [Next.js Docker](https://nextjs.org/docs/deployment#docker-image)
