$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$IndexPath = Join-Path $BaseDir "index.html"
$BaseUrl = "https://www.dastifysolutions.com"

# Read index.html
$IndexContent = Get-Content -Raw $IndexPath

# Find all URLs
$matches = [regex]::matches($IndexContent, 'href="(/[a-zA-Z0-9-][^"]*/)"')
$urls = $matches | Foreach-Object { $_.Groups[1].Value } | Sort-Object -Unique

# Function to process content
function Process-Content {
    param([string]$content)
    
    $content = $content -creplace 'Dastify Solutions', 'E-nnovationrcm'
    $content = $content -creplace 'Dastify', 'E-nnovationrcm'
    $content = $content -replace 'https://www.dastifysolutions.com/wp-content/uploads/2025/05/dastifysolutions-logo.webp', 'assets/logo.png'
    $content = $content -replace 'https://www.dastifysolutions.com/wp-content/uploads/2025/09/dastify-solutions-logo-white.webp', 'assets/logo.png'
    
    # Link replacement
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
        param($m)
        $url = $m.Groups[1].Value
        if ($url -eq "/") {
            return 'href="index.html"'
        }
        $flat = ($url.Trim('/') -replace '/', '-') + '.html'
        return 'href="' + $flat + '"'
    }
    
    $content = [regex]::Replace($content, 'href="(/[a-zA-Z0-9-][^"]*/)"', $evaluator)
    $content = [regex]::Replace($content, 'href="/"', 'href="index.html"')
    
    return $content
}

# Download and process
foreach ($url in $urls) {
    if ($url -eq "/") { continue }
    
    $fullUrl = $BaseUrl + $url
    $flatFilename = ($url.Trim('/') -replace '/', '-') + ".html"
    $savePath = Join-Path $BaseDir $flatFilename
    
    Write-Host "Downloading $fullUrl -> $flatFilename ..."
    try {
        $response = Invoke-WebRequest -Uri $fullUrl -UseBasicParsing
        $html = $response.Content
        $processed = Process-Content -content $html
        Set-Content -Path $savePath -Value $processed -Encoding UTF8
    } catch {
        Write-Host "Error downloading $fullUrl : $_"
    }
}

# Process index.html
Write-Host "Processing index.html ..."
$IndexContent = Process-Content -content $IndexContent
Set-Content -Path $IndexPath -Value $IndexContent -Encoding UTF8
Write-Host "Done! All pages cloned and flattened."
