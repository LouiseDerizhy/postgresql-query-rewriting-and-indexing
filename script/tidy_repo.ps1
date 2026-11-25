# script\tidy_repo.ps1  (jalankan dari C:\Coding\thesis)
param([switch]$DryRun)
Set-Location C:\Coding\thesis

function Mv($src, $dst) {
    if (-not (Test-Path $src)) { return }
    if (Test-Path $dst)        { Write-Host "[lewati, tujuan ada] $dst"; return }
    Write-Host "[pindah] $src -> $dst"
    if ($DryRun) { return }
    New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
    git mv $src $dst 2>$null
    if ($LASTEXITCODE -ne 0) { Move-Item $src $dst }
}

# 1. Log G1 lama (dijalankan pada berkas SQL sebelum dibekukan) disisihkan,
#    karena validate.py menambahkan baris ke .jsonl yang sama.
Mv "logs\g1" "logs\g1_prefreeze"

# 2. Nama berkas dan skrip
Mv "environtment.txt" "environment.txt"
Mv "sql\load\tpch_mini_setup.sql" "sql\validation\mini\tpch_mini_setup.sql"
Get-ChildItem "sql\validation" -Filter "validate_q*_equivalence.sql" -File -ErrorAction SilentlyContinue |
    ForEach-Object { Mv $_.FullName ("sql\validation\legacy\" + $_.Name) }

# 3. Laporan validasi lama versi CTE
Get-ChildItem "documentation\query-validation" -File -ErrorAction SilentlyContinue |
    ForEach-Object { Mv $_.FullName ("documentation\query-validation\archive_cte_version\" + $_.Name) }

# 4. Perbarui path skrip mini di run_g1.ps1
if (Test-Path "script\run_g1.ps1") {
    $t = Get-Content "script\run_g1.ps1" -Raw
    $n = $t -replace [regex]::Escape('sql\load\tpch_mini_setup.sql'), 'sql\validation\mini\tpch_mini_setup.sql'
    if ($n -ne $t) {
        Write-Host "[ubah] path mini di script\run_g1.ps1"
        if (-not $DryRun) { Set-Content "script\run_g1.ps1" $n -Encoding utf8 }
    }
}
Write-Host "Selesai."