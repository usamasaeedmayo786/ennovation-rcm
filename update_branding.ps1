$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw

    $replacements = @(
        @{ Old = 'https://www.dastifysolutions.com/'; New = '/' },
        @{ Old = 'https://www.dastifysolutions.com'; New = '/' },
        @{ Old = 'https://dastifysolutions.com/'; New = '/' },
        @{ Old = 'https://dastifysolutions.com'; New = '/' },
        @{ Old = 'info@dastifysolutions.com'; New = 'admin@e-nnovationrcm.com' },
        @{ Old = 'support@dastifysolutions.com'; New = 'admin@e-nnovationrcm.com' },
        @{ Old = 'compliance@dastifysolutions.com'; New = 'admin@e-nnovationrcm.com' },
        @{ Old = '\+18889286503'; New = '+923494948912' },
        @{ Old = '\+1\s*\(888\)\s*928-6503'; New = '+923494948912' },
        @{ Old = '1-888-928-6503'; New = '+923494948912' },
        @{ Old = '\(888\)\s*928-6503'; New = '+923494948912' },
        @{ Old = '888-928-6503'; New = '+923494948912' }
    )

    $changed = $false
    foreach ($replacement in $replacements) {
        if ($content -match $replacement.Old) {
            $content = $content -replace $replacement.Old, $replacement.New
            $changed = $true
        }
    }

    if ($changed) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}
