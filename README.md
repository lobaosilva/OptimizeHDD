# 🛠️ Optimize-Drive.ps1
## Um script avançado para otimizar unidades de armazenamento no Windows   
**Autor:** Lobão Silva  
**Versão:** 1.0

---

## 📜 Sobre o Script
`Optimize-Drive.ps1` é um script em PowerShell projetado para otimizar o desempenho de unidades de armazenamento (HD ou SSD) usadas intensivamente para leitura de arquivos, como jogos e grandes coleções de mídia. Ele aplica uma série de ajustes que maximizam a velocidade de leitura e reduzem o uso desnecessário de recursos.

## 🚀 Funcionalidades
- **Verificação de erros no disco**  
- **Desativação da indexação e registro de último acesso**  
- **Desfragmentação avançada e limpeza de arquivos temporários**  
- **Ativação do plano de energia de alto desempenho**  
- **Desativação do serviço SysMain (Superfetch)**  

---

## ⚙️ Etapas de Otimização

| Etapa  | Descrição | Comando Utilizado |
|--------|-----------|-------------------|
| **1**  | **Verificação de Erros no Disco**: Corrige erros e recupera setores defeituosos. | `chkdsk C: /f /r` |
| **2**  | **Desativação da Indexação**: Reduz a carga no sistema, evitando a indexação de arquivos em discos de leitura. | `wmic volume where driveletter="C:" set indexingenabled=false` |
| **3**  | **Desativação do Registro do Último Acesso**: Melhora o desempenho de leitura ao evitar a gravação do timestamp de último acesso. | `fsutil behavior set disablelastaccess 1` |
| **4**  | **Desfragmentação Completa e Consolidação**: Organiza os dados e o espaço livre, facilitando o acesso a arquivos grandes. | `defrag C: /X /O /H /U /V` |
| **5**  | **Limpeza de Arquivos Temporários**: Libera espaço ao remover arquivos desnecessários. | `cleanmgr /D C:` |
| **6**  | **Ativação do Plano de Energia de Alto Desempenho**: Maximiza a alocação de recursos para acesso rápido ao disco. | `powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61` |
| **7**  | **Desativação do SysMain (Superfetch)**: Elimina a pré-carregamento desnecessário em unidades de leitura. | `sc config SysMain start=disabled` |

---

## 📝 Pré-requisitos

1. **Permissão de Administrador:**  
    Este script precisa ser executado com permissões administrativas.
2. **PowerShell com Execução de Scripts Habilitada:**  
   Para habilitar, abra o PowerShell como Administrador e execute:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

---

## 🚀 Instruções de Uso
1. **Baixe o Script**   
    Salve o conteúdo do script como Optimize-Drive.ps1.

2. **Execute o PowerShell como Administrador**  
    Abra o PowerShell com permissões administrativas para que o script tenha acesso completo.

3. **Execute o Script** 
    Navegue até a pasta onde o script está salvo e digite:
    ```powershell
    .\Optimize-Drive.ps1
    ```

4. **Escolha a Unidade**    
    O script solicitará que você informe a letra da unidade a ser otimizada (por exemplo, `C:`). Digite a letra da unidade e pressione **Enter**.

5. **Acompanhe o Progresso**    
    Cada etapa será executada com uma barra de progresso e mensagens indicando sucesso ou falha.

---

## 🔍 Exemplo de Uso   
    Digite a letra da unidade que deseja otimizar (exemplo: C:): C:
    Verificando erros no disco (C:)... ✔️ Sucesso
    Desativando indexação (C:)... ✔️ Sucesso
    Desativando Last Access Update (C:)... ✔️ Sucesso
    Desfragmentando e consolidando espaço (C:)... ✔️ Sucesso
    Limpando arquivos temporários (C:)... ✔️ Sucesso
    Ativando plano de energia de alto desempenho... ✔️ Sucesso
    Desativando serviço SysMain (Superfetch)... ✔️ Sucesso
    Otimização completa para a unidade C:!

---

## ⚠️ Aviso Importante
Este script realiza otimizações que podem alterar o comportamento padrão do Windows em relação ao gerenciamento de disco e arquivos. Use-o somente em unidades dedicadas a leitura e onde esses ajustes são realmente necessários.

---

💡 **Dica:** Este script é especialmente útil para HDs dedicados à leitura, como aqueles usados para jogos, onde o acesso rápido aos dados melhora significativamente o desempenho.

**Licença:** MIT