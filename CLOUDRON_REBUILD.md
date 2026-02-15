# Guia de Rebuild no Cloudron - Variáveis NEXT_PUBLIC_*

## Por que preciso fazer rebuild?

Variáveis `NEXT_PUBLIC_*` do Next.js são **embutidas no código JavaScript durante o build**. Quando você muda essas variáveis no `env.sh`, o código já compilado não é atualizado automaticamente.

## Variáveis que requerem rebuild

Estas variáveis são compiladas no build e precisam de rebuild quando alteradas:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY`
- `NEXT_PUBLIC_DASHBOARD_URL`
- `NEXT_PUBLIC_MEU_PROCESSO_URL`
- `NEXT_PUBLIC_WEBSITE_URL`
- `NEXT_PUBLIC_APP_URL`
- `NEXT_PUBLIC_DYTE_ORG_ID`
- `NEXT_PUBLIC_AI_FAKE_STREAMING`
- `NEXT_PUBLIC_FORMSIGN_SUBMIT_ENABLED`

## Variáveis que NÃO requerem rebuild

Estas variáveis são lidas em runtime e podem ser alteradas apenas no `env.sh`:

- `SUPABASE_SECRET_KEY`
- `SUPABASE_PROJECT_REF`
- `SUPABASE_ACCESS_TOKEN`
- `REDIS_URL`
- `REDIS_PASSWORD`
- `OPENAI_API_KEY`
- `AI_GATEWAY_API_KEY`
- Todas as outras variáveis sem prefixo `NEXT_PUBLIC_`

---

## Método 1: Rebuild via Cloudron CLI (Recomendado)

### Pré-requisitos

1. **Instalar Cloudron CLI**:
   ```bash
   npm install -g cloudron
   ```

2. **Login no Cloudron**:
   ```bash
   cloudron login https://my.seu-dominio.com
   ```

### Passos para Rebuild

1. **Atualizar variáveis de ambiente**:
   ```bash
   # Definir variáveis NEXT_PUBLIC_* como build args
   cloudron env set NEXT_PUBLIC_SUPABASE_URL="https://hiwwrglhmyogsmoqirpr.supabase.co" --app <app-id>
   cloudron env set NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="sb_publishable_pGPjP_BKaq7puG71HjMvmw_fVXSgimC" --app <app-id>
   ```

2. **Fazer rebuild da aplicação**:
   ```bash
   # Opção A: Rebuild local e push
   cloudron build
   cloudron install --image <sua-imagem>

   # Opção B: Rebuild via Docker Registry
   docker build --platform linux/amd64 \
     --build-arg NEXT_PUBLIC_SUPABASE_URL="https://hiwwrglhmyogsmoqirpr.supabase.co" \
     --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="sb_publishable_pGPjP_BKaq7puG71HjMvmw_fVXSgimC" \
     -t registry.seu-dominio.com/sinesys:latest .
   
   docker push registry.seu-dominio.com/sinesys:latest
   cloudron update --app <app-id> --image registry.seu-dominio.com/sinesys:latest
   ```

---

## Método 2: Rebuild via Docker Registry no Cloudron

### Pré-requisitos

1. **Instalar Docker Registry app no Cloudron**
2. **Configurar acesso ao registry**

### Passos

1. **Build local com variáveis**:
   ```bash
   docker build --platform linux/amd64 \
     --build-arg NEXT_PUBLIC_SUPABASE_URL="https://hiwwrglhmyogsmoqirpr.supabase.co" \
     --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="sb_publishable_pGPjP_BKaq7puG71HjMvmw_fVXSgimC" \
     --build-arg NEXT_PUBLIC_DYTE_ORG_ID="" \
     -t docker.seu-dominio.com/sinesys:latest .
   ```

2. **Push para registry**:
   ```bash
   docker login docker.seu-dominio.com
   docker push docker.seu-dominio.com/sinesys:latest
   ```

3. **Atualizar app no Cloudron**:
   - Acesse o painel da aplicação
   - Clique em "Update"
   - Selecione a nova imagem

---

## Método 3: Rebuild Automático via CI/CD

### GitHub Actions

Crie `.github/workflows/cloudron-deploy.yml`:

```yaml
name: Deploy to Cloudron

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build Docker image
        run: |
          docker build --platform linux/amd64 \
            --build-arg NEXT_PUBLIC_SUPABASE_URL="${{ secrets.NEXT_PUBLIC_SUPABASE_URL }}" \
            --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="${{ secrets.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY }}" \
            -t ${{ secrets.DOCKER_REGISTRY }}/sinesys:latest .
      
      - name: Push to registry
        run: |
          echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin ${{ secrets.DOCKER_REGISTRY }}
          docker push ${{ secrets.DOCKER_REGISTRY }}/sinesys:latest
      
      - name: Update Cloudron app
        run: |
          npm install -g cloudron
          cloudron login ${{ secrets.CLOUDRON_URL }} --token ${{ secrets.CLOUDRON_TOKEN }}
          cloudron update --app ${{ secrets.CLOUDRON_APP_ID }} --image ${{ secrets.DOCKER_REGISTRY }}/sinesys:latest
```

---

## Método 4: Script de Build Simplificado

Crie `scripts/cloudron-rebuild.sh`:

```bash
#!/bin/bash

# Carregar variáveis do env.sh
source env.sh

# Build com variáveis
docker build --platform linux/amd64 \
  --build-arg NEXT_PUBLIC_SUPABASE_URL="$NEXT_PUBLIC_SUPABASE_URL" \
  --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="$NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY" \
  --build-arg NEXT_PUBLIC_DYTE_ORG_ID="$NEXT_PUBLIC_DYTE_ORG_ID" \
  -t sinesys:latest .

echo "Build concluído! Agora faça push para o registry do Cloudron."
```

Uso:
```bash
chmod +x scripts/cloudron-rebuild.sh
./scripts/cloudron-rebuild.sh
```

---

## Verificação Pós-Rebuild

Após o rebuild, verifique se as variáveis foram aplicadas:

1. **Acesse a aplicação no browser**
2. **Abra o Console do DevTools** (F12)
3. **Execute**:
   ```javascript
   console.log(process.env.NEXT_PUBLIC_SUPABASE_URL)
   ```
4. **Deve mostrar o valor correto** (não `undefined`)

---

## Troubleshooting

### Erro: "NEXT_PUBLIC_* is undefined"

**Causa**: Build não incluiu as variáveis

**Solução**:
1. Verifique se passou `--build-arg` no `docker build`
2. Confirme que o Dockerfile tem `ARG` e `ENV` para cada variável
3. Faça rebuild completo (sem cache): `docker build --no-cache ...`

### Erro: "Cannot connect to Supabase"

**Causa**: URL ou chave incorreta

**Solução**:
1. Verifique os valores no Supabase Dashboard
2. Confirme que não há espaços ou quebras de linha
3. Use aspas duplas nos valores: `--build-arg VAR="valor"`

### Build muito lento

**Solução**:
1. Use cache do Docker: remova `--no-cache`
2. Aumente memória do Docker: Settings > Resources > Memory (8GB+)
3. Use `npm run build:ci` (já configurado no Dockerfile)

---

## Resumo do Fluxo

```
1. Editar env.sh com novas variáveis NEXT_PUBLIC_*
   ↓
2. Build Docker com --build-arg para cada NEXT_PUBLIC_*
   ↓
3. Push imagem para registry
   ↓
4. Update app no Cloudron com nova imagem
   ↓
5. Cloudron reinicia app automaticamente
   ↓
6. Variáveis agora disponíveis no client-side
```

---

## Quando NÃO precisa rebuild

Se você mudou apenas variáveis **sem** `NEXT_PUBLIC_`:

1. Edite `/app/data/env.sh` no File Manager
2. Reinicie a aplicação
3. Pronto! ✅

Exemplos:
- `REDIS_PASSWORD` → Apenas reiniciar
- `OPENAI_API_KEY` → Apenas reiniciar
- `SUPABASE_SECRET_KEY` → Apenas reiniciar
- `NEXT_PUBLIC_SUPABASE_URL` → **Precisa rebuild** ⚠️
