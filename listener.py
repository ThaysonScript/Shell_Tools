import os
import re
import time

# Linha de chamada para o arquivo com as funções de strings
linha_chamada_strings = 'source ../core/strings/strings.sh'

# Diretório onde os novos arquivos bash serão criados
diretorio_src = './src'

# Função para verificar se a linha de chamada já está presente no arquivo
def verificar_chamada_presente(caminho_arquivo):
    with open(caminho_arquivo, 'r') as arquivo:
        conteudo = arquivo.read()
        return linha_chamada_strings in conteudo

# Função para verificar se há chamadas de funções no arquivo
def verificar_chamadas_funcoes(caminho_arquivo):
    with open(caminho_arquivo, 'r') as arquivo:
        conteudo = arquivo.read()
        padrao = r'\b(trim|trim_all|trim_quotes|pattern_strip|first_strip|lstrip|rstrip|regex|split|lower|upper|reverse|url_encode|url_decode)\b'
        return re.search(padrao, conteudo)

# Loop para monitorar constantemente a pasta src em busca de novos arquivos bash
while True:
    arquivos_src = [arquivo for arquivo in os.listdir(diretorio_src) if arquivo.endswith('.sh')]

    for arquivo_src in arquivos_src:
        caminho_arquivo_src = os.path.join(diretorio_src, arquivo_src)
        
        if os.path.exists(caminho_arquivo_src):
            # Verifica as chamadas de funções no arquivo
            chamadas_funcoes = verificar_chamadas_funcoes(caminho_arquivo_src)
            
            # Se há chamadas de funções, verifica se a linha de chamada está presente após a shebang
            if chamadas_funcoes and not verificar_chamada_presente(caminho_arquivo_src):
                with open(caminho_arquivo_src, 'r') as arquivo:
                    linhas = arquivo.readlines()
                    
                    # Procura pela shebang no arquivo
                    for i, linha in enumerate(linhas):
                        if linha.startswith('#!/usr/bin/env bash'):
                            # Adiciona a linha de chamada após a shebang
                            linhas.insert(i + 1, '\n' + linha_chamada_strings + '\n')
                            
                            # Escreve o conteúdo atualizado de volta no arquivo
                            with open(caminho_arquivo_src, 'w') as arquivo_bash:
                                arquivo_bash.write(''.join(linhas))
                            break
                    
    time.sleep(1)  # Verificação a cada segundo (ajuste conforme necessário)
