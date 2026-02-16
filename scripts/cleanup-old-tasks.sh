#!/bin/bash

# Script para remover arquivos antigos do módulo de tarefas após validação
# Execute apenas após confirmar que a nova implementação está funcionando

echo "⚠️  ATENÇÃO: Este script irá remover os arquivos antigos do módulo de tarefas"
echo "Certifique-se de que a nova implementação em src/features/tasks/ está funcionando corretamente"
echo ""
read -p "Deseja continuar? (s/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Ss]$ ]]
then
    echo "❌ Operação cancelada"
    exit 1
fi

echo "🗑️  Removendo arquivos antigos..."

# Remover componentes antigos
rm -rf src/app/app/tarefas/components/
echo "✅ Removido: src/app/app/tarefas/components/"

# Remover dados antigos
rm -rf src/app/app/tarefas/data/
echo "✅ Removido: src/app/app/tarefas/data/"

# Remover actions antigas
rm -rf src/app/app/tarefas/actions/
echo "✅ Removido: src/app/app/tarefas/actions/"

# Remover arquivos de domínio/service/repository antigos
rm -f src/app/app/tarefas/domain.ts
echo "✅ Removido: src/app/app/tarefas/domain.ts"

rm -f src/app/app/tarefas/repository.ts
echo "✅ Removido: src/app/app/tarefas/repository.ts"

rm -f src/app/app/tarefas/service.ts
echo "✅ Removido: src/app/app/tarefas/service.ts"

rm -f src/app/app/tarefas/index.ts
echo "✅ Removido: src/app/app/tarefas/index.ts"

echo ""
echo "✨ Limpeza concluída!"
echo "📁 Arquivos mantidos:"
echo "   - src/app/app/tarefas/page.tsx (página principal)"
echo ""
echo "📦 Nova estrutura em:"
echo "   - src/features/tasks/"
