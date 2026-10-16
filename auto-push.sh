#!/bin/bash
# auto-push.sh: envia as alterações do projeto para o GitHub
# Uso: ./auto-push.sh "mensagem do commit"

set -e   # interrompe o script se algum comando der erro
# Mensagem do commit: usa o texto digitado ou data e hora atuais
MSG="${1:-Atualização automática $(date '+%d/%m/%Y %H:%M')}"

# Confere se a pasta atual é um repositório Git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Erro: esta pasta não é um repositório Git."
  echo "Entre na pasta do projeto com 'cd' e tente de novo."
  exit 1
fi

# Se não houver alterações, avisa e sai
if [ -z "$(git status --porcelain)" ]; then
  echo "Nada para enviar: nenhuma alteração encontrada."
  exit 0
fi

echo "Arquivos alterados:"
git status --short

git add .
git commit -m "$MSG"
git push

echo "Enviado com sucesso!"
