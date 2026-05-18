$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    $originalContent = $content
    
    # 1. Branding: dastifysolutions.com -> e-nnovationrcm.com
    $content = $content -replace 'dastifysolutions\.com', 'e-nnovationrcm.com'
    
    # 2. Branding: E-Nnovationrcm -> E-nnovationrcm
    $content = $content -creplace 'E-Nnovationrcm', 'E-nnovationrcm'
    
    # 3. Fix specific question mark artifacts
    $content = $content -replace '\? Written by:', 'Written by:'
    $content = $content -replace '\? Reviewed by:', 'Reviewed by:'
    
    # 4. Fix ? at the start of spans / after brackets (checkmarks/bullets)
    $content = $content -replace '>(\s*)\?\s*([A-Z0-9])', '>$1- $2'
    
    # 5. Fix apostrophes (e.g., patient?s -> patient's)
    $content = $content -replace '(?i)([a-z])\?(s|re|d|m|ve|ll|t)\b', '$1''$2'
    
    # 6. Fix dashes in numbers (e.g., 43107?43124 -> 43107-43124)
    $content = $content -replace '([0-9])\?([0-9])', '$1-$2'
    
    # 7. Fix spaces and formatting
    $content = $content -replace '([a-zA-Z])\?(is|are|and|with|the|to|of|in|for|on|that|by|this|all)\b', '$1 $2'
    $content = $content -replace '(\.)\?([A-Za-z])', '$1 $2'
    $content = $content -replace '([a-zA-Z])\?(\s)', '$1$2'
    $content = $content -replace ' \? ', ' - '
    
    if ($content -cne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
    }
}

# Also do a wider replacement for dastifysolutions.com in other assets
$assetFiles = Get-ChildItem -Path .\wp-content -Recurse -Include *.css, *.js, *.json -File
foreach ($file in $assetFiles) {
    $content = Get-Content -Raw $file.FullName
    $originalContent = $content
    
    $content = $content -replace 'dastifysolutions\.com', 'e-nnovationrcm.com'
    
    if ($content -cne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
    }
}
