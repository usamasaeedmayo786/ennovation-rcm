$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # Strip corrupt srcset attributes globally
    $content = $content -replace '\s*srcset="assets/medical_team\.png"', ''
    $content = $content -replace '\s*imagesrcset="assets/medical_team\.png"', ''
    $content = $content -replace '\s*data-lazy-srcset="assets/medical_team\.png"', ''
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Successfully removed corrupted srcset attributes across all files."
