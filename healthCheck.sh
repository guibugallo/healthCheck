#!/bin/bash

# Função para mostrar ajuda
show_help() {
    echo "Uso: $0 {-usodisco|-usomem}"
    echo "  -usodisco   Mostra os 5 maiores arquivos e suas respectivas pastas por consumo de disco."
    echo "  -usomem     Mostra os 5 processos que mais consomem memória e seus respectivos PIDs."
    exit 1
}

# Função para checar o uso de disco e retornar os 5 maiores arquivos e suas respectivas pastas
usodisco() {
    echo "Os 5 maiores arquivos e suas respectivas pastas são:"
    find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 5
}

# Função para checar o uso de memória e retornar os 5 processos que mais estão consumindo memória e seus respectivos PIDs
usomem() {
    echo "Os 5 processos que mais estão consumindo memória são:"
    ps aux --sort=-%mem | awk 'NR<=6 {print $2, $4, $11}' | column -t
}

# Verifica se há argumentos passados e exibe a ajuda se necessário
if [ $# -eq 0 ]; then
    show_help
fi

# Checa qual função o usuário quer executar
case "$1" in
    -usodisco)
        usodisco
        ;;
    -usomem)
        usomem
        ;;
    --help)
        show_help
        ;;
    *)
        echo "Opção inválida. Use --help para ver as opções disponíveis."
        exit 1
        ;;
esac
