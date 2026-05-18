$files = Get-ChildItem -Path . -Recurse -Filter "*.html"
foreach ($file in $files) {
    $content = Get-Content -Raw $file.FullName
    $modified = $false
    
    if ($content -match '\?2026 E-nnovationrcm') {
        $content = $content -replace '\?2026 E-nnovationrcm', '&copy; 2026 E-nnovationrcm'
        $modified = $true
    }
    
    if ($content -match 'Let\?s Talk') {
        $content = $content -replace 'Let\?s Talk', "Let's Talk"
        $modified = $true
    }
    
    # Also remove the Client Portal button and mobile menu item by replacing their HTML with empty string, 
    # but CSS is safer, so I'll also add a CSS rule in custom-enhancements.css later.
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $content
    }
}
