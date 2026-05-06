$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw

    $replacements = @(
        @{ Old = 'href="/"'; New = 'href="https://www.e-nnovationrcm.com/"' },
        @{ Old = '"url": "/"'; New = '"url": "https://www.e-nnovationrcm.com/"' },
        @{ Old = '"url":"/"'; New = '"url":"https://www.e-nnovationrcm.com/"' },
        @{ Old = 'content="/"'; New = 'content="https://www.e-nnovationrcm.com/"' },
        @{ Old = 'https:\\/\\/www.dastifysolutions.com'; New = 'https:\/\/www.e-nnovationrcm.com' },
        @{ Old = 'https:\\/\\/dastifysolutions.com'; New = 'https:\/\/www.e-nnovationrcm.com' }
    )

    $changed = $false
    foreach ($replacement in $replacements) {
        if ($content -match [regex]::Escape($replacement.Old)) {
            $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
            $changed = $true
        }
    }

    if ($changed) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}
