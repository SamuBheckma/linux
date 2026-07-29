#!/usr/bin/env python3
import os
import subprocess
import sys
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
SCRIPTS_DIR = BASE_DIR / "scripts"

if not SCRIPTS_DIR.is_dir():
    print(f"Diretório de scripts não encontrado: {SCRIPTS_DIR}")
    sys.exit(1)

scripts = sorted([p for p in SCRIPTS_DIR.iterdir() if p.is_file()])
if not scripts:
    print(f"Nenhum script encontrado em {SCRIPTS_DIR}")
    sys.exit(1)

print("Escolha uma opção para executar:")
for index, script in enumerate(scripts, start=1):
    print(f"  {index}) {script.name}")
print("  0) Sair")

while True:
    choice = input("Opção: ").strip()
    if not choice.isdigit():
        print(f"Opção inválida: {choice}. Digite um número entre 0 e {len(scripts)}")
        continue

    choice_int = int(choice)
    if choice_int == 0:
        print("Saindo.")
        sys.exit(0)
    if 1 <= choice_int <= len(scripts):
        selected = scripts[choice_int - 1]
        print(f"Executando: {selected.name}")
        if os.access(selected, os.X_OK):
            subprocess.run([str(selected)], check=True)
        else:
            subprocess.run([sys.executable, str(selected)], check=True)
        break

    print(f"Opção inválida. Digite um número entre 0 e {len(scripts)}")
