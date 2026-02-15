# Cloudron - Guia Rápido

## 🚀 Deploy Inicial

### 1. Configure as variáveis no Cloudron

No File Manager da aplicação, crie `/app/data/env.sh`:

```bash
#!/bin/bash

# Supabase (obrigatórias)
export NEXT_PUBLIC_SUPABASE_URL="https://hiwwrglhmyogsmoqirpr.supabase.co"
export NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="sb_publishable_pGPjP_BKaq7puG71HjMvmw_fVXSgimC"
export SUPABASE_SECRET_KEY="sb_secret_wJfS3Gj9IIWVb2AmpF4ttg_ioFGVhEk"

# Redis
export ENABLE_REDIS_CACHE="true"
export REDIS_URL="redis://redis-13078.crce207.sa-east-1-2.ec2.cloud.redislabs.com:13078"
export REDIS_PASSWORD="7UuDAooB669GNcpaAzwqjkBpyyfNUPbF"

# OpenAI
export OPENAI_API_KEY="sua-chave"
export AI_GATEWAY_API_KEY="sua-chave"

# ... outras variáveis
```

### 2. Faça o primeiro build

```bash
# No seu computador local
./scripts/cloudron-build.sh docker.seu-dominio.com/sinesys latest
docker push docker.seu-dominio.com/sinesys:latest
```

### 3. Instale no Cloudron

```bash
cloudron install --image docker.seu-dominio.com/sinesys:latest
```

---

## 🔄 Atualizando Variáveis

### Variáveis Runtime (Sem Rebuild)

Para variáveis **SEM** `NEXT_PUBLIC_`:

1. Edite `/app/data/env.sh` no File Manager
2. Reinicie a aplicação
3. ✅ Pronto!

**Exemplos**: `REDIS_PASSWORD`, `OPENAI_API_KEY`, `SUPABASE_SECRET_KEY`

### Variáveis Build Time (Com Rebuild)

Para variáveis **COM** `NEXT_PUBLIC_`:

1. Edite `env.sh` localmente
2. Execute:
   ```bash
   ./scripts/cloudron-build.sh docker.seu-dominio.com/sinesys latest
   docker push docker.seu-dominio.com/sinesys:latest
   cloudron update --app <app-id> --image docker.seu-dominio.com/sinesys:latest
   ```
3. ✅ Pronto!

**Exemplos**: `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_DYTE_ORG_ID`

---

## 📋 Checklist de Variáveis

### ✅ Obrigatórias (Rebuild necessário)
- [ ] `NEXT_PUBLIC_SUPABASE_URL`
- [ ] `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY`

### ✅ Obrigatórias (Runtime)
- [ ] `SUPABASE_SECRET_KEY`
- [ ] `SERVICE_API_KEY`

### ⚙️ Opcionais (Runtime)
- [ ] `ENABLE_REDIS_CACHE`
- [ ] `REDIS_URL`
- [ ] `REDIS_PASSWORD`
- [ ] `OPENAI_API_KEY`
- [ ] `AI_GATEWAY_API_KEY`

### ⚙️ Opcionais (Rebuild necessário)
- [ ] `NEXT_PUBLIC_DYTE_ORG_ID`
- [ ] `NEXT_PUBLIC_DASHBOARD_URL`
- [ ] `NEXT_PUBLIC_APP_URL`

---

## 🐛 Troubleshooting

### Erro: "Supabase client requires URL and API key"

**Causa**: Variáveis `NEXT_PUBLIC_*` não foram incluídas no build

**Solução**:
```bash
# Rebuild com as variáveis
./scripts/cloudron-build.sh docker.seu-dominio.com/sinesys latest
docker push docker.seu-dominio.com/sinesys:latest
cloudron update --app <app-id> --image docker.seu-dominio.com/sinesys:latest
```

### Erro: "Cannot connect to Redis"

**Causa**: Variáveis de Redis incorretas ou Redis indisponível

**Solução**:
1. Verifique `REDIS_URL` e `REDIS_PASSWORD` em `/app/data/env.sh`
2. Teste conexão: `redis-cli -h host -p port -a password ping`
3. Reinicie a aplicação

### App não inicia

**Solução**:
1. Verifique logs: Cloudron Dashboard > App > Logs
2. Verifique health check: `curl http://localhost:8000/api/health`
3. Verifique variáveis obrigatórias em `/app/data/env.sh`

---

## 📚 Documentação Completa

- [CLOUDRON_REBUILD.md](./CLOUDRON_REBUILD.md) - Guia detalhado de rebuild
- [Cloudron Docs](https://docs.cloudron.io/packaging/tutorial/)
- [Next.js Environment Variables](https://nextjs.org/docs/app/building-your-application/configuring/environment-variables)

---

## 🆘 Suporte

- Logs da aplicação: Cloudron Dashboard > App > Logs
- Health check: `https://seu-app.dominio.com/api/health`
- Documentação Cloudron: https://docs.cloudron.io
