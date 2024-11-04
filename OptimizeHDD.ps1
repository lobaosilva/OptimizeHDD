# Script: Optimize-Drive.ps1
# Autor: Lobão Silva
# Versão: 1.0
# Requer permissões de administrador para execução

# Verifica se o script está rodando como Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Por favor, execute o script como Administrador." -ForegroundColor Red
    exit
}

# Função para exibir a barra de progresso
function Show-Progress {
    param (
        [int]$PercentComplete,
        [string]$Status
    )
    Write-Progress -Activity $Status -PercentComplete $PercentComplete
}

# Solicita ao usuário a unidade para otimização
$driveLetter = Read-Host "Digite a letra da unidade que deseja otimizar (exemplo: C:)"

# Verifica se a unidade existe
if (!(Test-Path "$driveLetter\")) {
    Write-Host "Unidade $driveLetter não encontrada. Verifique e tente novamente." -ForegroundColor Red
    exit
}

# Executa os comandos de otimização
try {
    # 1. Verificação de erros no disco
    Show-Progress -PercentComplete 10 -Status "Verificando erros no disco ($driveLetter)"
    chkdsk $driveLetter /f /r
    Write-Host "Verificação de erros concluída com sucesso." -ForegroundColor Green

    # 2. Desativação da indexação
    Show-Progress -PercentComplete 25 -Status "Desativando indexação ($driveLetter)"
    wmic volume where driveletter="$driveLetter" set indexingenabled=false
    Write-Host "Indexação desativada." -ForegroundColor Green

    # 3. Desativação do Last Access Update
    Show-Progress -PercentComplete 35 -Status "Desativando Last Access Update ($driveLetter)"
    fsutil behavior set disablelastaccess 1
    Write-Host "Last Access Update desativado." -ForegroundColor Green

    # 4. Desfragmentação com consolidação de espaço
    Show-Progress -PercentComplete 50 -Status "Desfragmentando e consolidando espaço ($driveLetter)"
    defrag $driveLetter /X /O /H /U /V
    Write-Host "Desfragmentação concluída." -ForegroundColor Green

    # 5. Limpeza de arquivos temporários
    Show-Progress -PercentComplete 70 -Status "Limpando arquivos temporários ($driveLetter)"
    Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/D $driveLetter" -Wait
    Write-Host "Limpeza de arquivos temporários concluída." -ForegroundColor Green

    # 6. Ativação do plano de energia de alto desempenho
    Show-Progress -PercentComplete 85 -Status "Ativando plano de energia de alto desempenho"
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-Host "Plano de energia de alto desempenho ativado." -ForegroundColor Green

    # 7. Desativação do serviço SysMain (Superfetch)
    Show-Progress -PercentComplete 95 -Status "Desativando serviço SysMain (Superfetch)"
    Set-Content config SysMain start=disabled
    Write-Host "SysMain (Superfetch) desativado." -ForegroundColor Green

    # Conclusão
    Show-Progress -PercentComplete 100 -Status "Otimização concluída"
    Write-Host "Otimização completa para a unidade $driveLetter!" -ForegroundColor Green

} catch {
    Write-Host "Ocorreu um erro durante a otimização: $_" -ForegroundColor Red
}
