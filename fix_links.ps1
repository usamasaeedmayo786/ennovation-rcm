$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$BaseUrl = "https://www.dastifysolutions.com"

# 1. Collect ALL html files to find URLs
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html
$allUrls = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # Absolute URLs
    $matchesAbs = [regex]::matches($content, 'href="https?://(?:www\.)?dastifysolutions\.com/([^"]*)"')
    $allUrls += $matchesAbs | Foreach-Object { $_.Groups[1].Value }
    
    # Relative URLs
    $matchesRel = [regex]::matches($content, 'href="(/[^"]*)"')
    $allUrls += $matchesRel | Foreach-Object { $_.Groups[1].Value }
}

$uniquePaths = $allUrls | Sort-Object -Unique | Where-Object { 
    $_ -ne "" -and $_ -ne "/" -and 
    $_ -notmatch "wp-content" -and $_ -notmatch "wp-json" -and 
    $_ -notmatch "\.php" -and $_ -notmatch "\?page_id" -and 
    $_ -notmatch "feed" -and $_ -notmatch "comments" 
}

# Process function
function Process-Content {
    param([string]$content)
    $content = $content -creplace 'Dastify Solutions', 'E-nnovationrcm'
    $content = $content -creplace 'Dastify', 'E-nnovationrcm'
    $content = $content -replace 'https://www.dastifysolutions.com/wp-content/uploads/2025/05/dastifysolutions-logo.webp', 'assets/logo.png'
    $content = $content -replace 'https://www.dastifysolutions.com/wp-content/uploads/2025/09/dastify-solutions-logo-white.webp', 'assets/logo.png'
    return $content
}

# Download missing pages
foreach ($path in $uniquePaths) {
    $cleanPath = $path -replace "^\/", ""
    if ($cleanPath -eq "") { continue }
    $flatFilename = ($cleanPath.Trim('/') -replace '/', '-') + ".html"
    $savePath = Join-Path $BaseDir $flatFilename
    
    if (-not (Test-Path $savePath)) {
        $fullUrl = $BaseUrl + "/" + $cleanPath
        Write-Host "Downloading missing: $fullUrl -> $flatFilename ..."
        try {
            $response = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
            $html = Process-Content -content $response.Content
            Set-Content -Path $savePath -Value $html -Encoding UTF8
        } catch {
            Write-Host "Error downloading $fullUrl : $_"
        }
    }
}

# Now rewrite ALL links in ALL local html files
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

$evaluatorAbs = [System.Text.RegularExpressions.MatchEvaluator] {
    param($m)
    $url = $m.Groups[1].Value
    if ($url -eq "" -or $url -eq "/") { return 'href="index.html"' }
    if ($url -match "wp-content" -or $url -match "wp-json" -or $url -match "\.php" -or $url -match "\?page_id" -or $url -match "feed" -or $url -match "comments") { return $m.Value }
    $flat = ($url.Trim('/') -replace '/', '-') + '.html'
    return 'href="' + $flat + '"'
}

$evaluatorRel = [System.Text.RegularExpressions.MatchEvaluator] {
    param($m)
    $url = $m.Groups[1].Value
    if ($url -eq "" -or $url -eq "/") { return 'href="index.html"' }
    if ($url -match "wp-content" -or $url -match "wp-json" -or $url -match "\.php" -or $url -match "\?page_id" -or $url -match "feed" -or $url -match "comments") { return $m.Value }
    $flat = ($url.Trim('/') -replace '/', '-') + '.html'
    return 'href="' + $flat + '"'
}

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    $content = [regex]::Replace($content, 'href="https?://(?:www\.)?dastifysolutions\.com/([^"]*)"', $evaluatorAbs)
    $content = [regex]::Replace($content, 'href="(/[^"]*)"', $evaluatorRel)
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}
Write-Host "All links fixed and missing pages downloaded!"
