$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    if ($content -match '\+\+1 \(945\)') {
        $content = $content -replace '\+\+1 \(945\)', '+1 (945)'
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Fixed ++1 in $($file.Name)"
    }
}
