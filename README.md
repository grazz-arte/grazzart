# GrazzArte — Static site mirror

Esta é uma cópia local/spa de um site WordPress espelhado (HTTrack). O projeto foi ajustado para uso estático local (caminhos relativos, Formsubmit para formulário de contato).

O repositório contém páginas HTML geradas pelo espelho do site, ativos em `wp-content`, `wp-includes`, etc.

Instruções rápidas

- Servir localmente para testar Formsubmit (recomendado): usar o script PowerShell `serve.ps1` ou `python -m http.server 8000`.
- Formulário de contato já configurado para `https://formsubmit.co/grazzart@outlook.com`.

Como publicar no GitHub

1. Crie um repositório no GitHub (use o site ou `gh repo create`).
2. Conecte o repositório remoto e faça push:

```bash
git remote add origin git@github.com:<usuario>/<repo>.git
git push -u origin main
```

Observações

- O repositório contém arquivos espelhados do WordPress (sem o backend). Para alterações de comportamento do Contact Form 7 é necessário acesso ao painel WordPress ou ao servidor.
- Remova/filtre quaisquer arquivos sensíveis antes de publicar (por exemplo backups, arquivos de configuração com credenciais).