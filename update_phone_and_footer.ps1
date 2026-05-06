$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    $replacements = @(
        @{ Old = 'href="tel:\+923494948912"'; New = 'href="tel:+19452060222"' },
        @{ Old = '\+923494948912'; New = '+1 (945) 206-0222' },
        @{ Old = 'E-nnovationrcm\. All Rights Reserved(?!.*USA and Canada)'; New = 'E-nnovationrcm. All Rights Reserved. We have been proudly working in the USA and Canada since 2009.' }
    )

    $changed = $false
    foreach ($replacement in $replacements) {
        if ($content -match $replacement.Old) {
            $content = $content -replace $replacement.Old, $replacement.New
            $changed = $true
        }
    }

    if ($changed) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated $($file.Name)"
    }
}
