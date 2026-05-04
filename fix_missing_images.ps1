$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

$allPaths = @()
foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    $matches = [regex]::matches($content, 'wp-content/uploads/[^"''\s\)\>]+')
    $allPaths += $matches | Foreach-Object { $_.Value }
}

$uniquePaths = $allPaths | Sort-Object -Unique
$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0")

foreach ($path in $uniquePaths) {
    # remove query strings for local path check
    $cleanPath = $path -replace '\?.*$', ''
    $localPath = Join-Path $BaseDir ([uri]::UnescapeDataString($cleanPath) -replace '/', '\')
    
    if (-not (Test-Path $localPath)) {
        $dir = Split-Path $localPath
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
        
        # Determine remote URL
        # We know it failed because the original had Dastify capitalized or something similar.
        # Let's try "Dastify" instead of "dastify"
        $remotePath = $path -cielreplace 'dastify', 'Dastify'
        $fullUrl = "https://www.dastifysolutions.com/" + $remotePath
        
        Write-Host "Attempting missing download: $fullUrl"
        try {
            $client.DownloadFile($fullUrl, $localPath)
            Write-Host "Successfully recovered $localPath"
        } catch {
            Write-Host "Still failed: $fullUrl"
        }
    }
}
Write-Host "Fallback script complete."
