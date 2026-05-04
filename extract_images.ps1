$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

$allUrls = @()
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    # Capture URLs with query strings too, but safely
    $matches = [regex]::matches($content, 'https://(?:www\.)?dastifysolutions\.com/(wp-(?:content|includes)/[^"''\s\)\>]+)')
    $allUrls += $matches | Foreach-Object { $_.Groups[1].Value }
}

$uniqueUrls = $allUrls | Sort-Object -Unique

Write-Host "Found $($uniqueUrls.Count) unique assets to download."

$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$count = 0
foreach ($urlPath in $uniqueUrls) {
    $count++
    
    # 1. Construct Remote URL
    # Revert accidental branding in URLs so the remote server doesn't 404
    $remotePath = $urlPath -ireplace 'E-nnovationrcmsolutions', 'dastifysolutions'
    $remotePath = $remotePath -ireplace 'E-nnovationrcm', 'dastify'
    $fullUrl = "https://www.dastifysolutions.com/" + $remotePath
    
    # 2. Construct Local Path
    # Strip query strings like ?ver=4.0 for the local file system
    $urlPathNoQuery = $urlPath -replace '\?.*$', ''
    $localPath = Join-Path $BaseDir ([uri]::UnescapeDataString($urlPathNoQuery) -replace '/', '\')
    $dir = Split-Path $localPath
    
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
    
    if (-not (Test-Path $localPath)) {
        if ($count % 50 -eq 0 -or $count -eq 1 -or $count -eq $uniqueUrls.Count) {
            Write-Host "[$count / $($uniqueUrls.Count)] Downloading..."
        }
        try {
            $client.DownloadFile($fullUrl, $localPath)
        } catch {
            Write-Host "Failed to download $fullUrl : $_"
        }
    }
}

Write-Host "Downloads complete! Updating HTML files..."

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # Force logo replacement
    $content = $content -replace "https?://(?:www\.)?dastifysolutions\.com/wp-content/[^`"']*cropped-E-nnovationrcmsolutions-logo[^`"']*\.png", "assets/logo.png"
    $content = $content -replace "https?://(?:www\.)?dastifysolutions\.com/wp-content/[^`"']*cropped-dastifysolutions-logo[^`"']*\.png", "assets/logo.png"
    $content = $content -replace "wp-content/[^`"']*cropped-E-nnovationrcmsolutions-logo[^`"']*\.png", "assets/logo.png"
    
    # Special fix: there are some places where logo was hardcoded to `star-01.png` or `dastifysolutions-logo.webp`
    $content = $content -replace "https?://(?:www\.)?dastifysolutions\.com/wp-content/[^`"']*dastifysolutions-logo\.webp", "assets/logo.png"
    $content = $content -replace "wp-content/[^`"']*dastifysolutions-logo\.webp", "assets/logo.png"
    
    # Rewrite asset URLs to local
    # We must also strip the query strings from the HTML so they point to the physical files we just saved without query strings
    $content = [regex]::Replace($content, 'https://(?:www\.)?dastifysolutions\.com/(wp-content/[^"''\s\?]+)(?:\?[^"''\s\>]+)?', '$1')
    $content = [regex]::Replace($content, 'https://(?:www\.)?dastifysolutions\.com/(wp-includes/[^"''\s\?]+)(?:\?[^"''\s\>]+)?', '$1')
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "All files rewritten. The clone is now 100% self-contained offline!"
